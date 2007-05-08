From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Tue, 8 May 2007 08:30:15 +0200
Message-ID: <e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com>
References: <loom.20070502T111026-882@post.gmane.org>
	 <20070503200013.GG4489@pasky.or.cz>
	 <loom.20070504T143538-533@post.gmane.org>
	 <87y7k4lahq.wl%cworth@cworth.org>
	 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
	 <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
	 <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
	 <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Karl Hasselstr?m" <kha@treskal.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Alex Riesen" <raa.lkml@gmail.com>,
	"Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 08 08:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlJOP-0001B3-Nl
	for gcvg-git@gmane.org; Tue, 08 May 2007 08:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbXEHGaZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 02:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342AbXEHGaY
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 02:30:24 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:53953 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbXEHGaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 02:30:16 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1860189nzf
        for <git@vger.kernel.org>; Mon, 07 May 2007 23:30:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CGlaetIXGkqPuqbqwLG49LpyLTuB/hKZWJRkNTzOBW0Zk1xm36eUaIybL1bclzKXuDDCPVLlT1lkWeihkQpjvMMyCTq8IppEqhyo/7P2QzysnzIrypMO2KIYvkIgh8CHSo8G2xCzeOauhwIaJksp0u8Mds6wSl1tPM7lDcb591A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SA3T1G9FWx1W1YCQ8vVXMoqwbc4YwEkV8az75D74vkWljZATAsFo3Gd7gMowb1BmLBLn12NCEYZD5W8K9I4gDzPpE007TaaL4dHPzF/2uqchvd3We/iogXntGPTvz9suAMbVDyA9tNt2tSu18t8LYHgNFALr2RZHxLAf8ZYzdi4=
Received: by 10.114.179.1 with SMTP id b1mr2485891waf.1178605815118;
        Mon, 07 May 2007 23:30:15 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 7 May 2007 23:30:15 -0700 (PDT)
In-Reply-To: <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46545>

On 5/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 5/7/07, Paul Mackerras <paulus@samba.org> wrote:
> > I have thought about rewriting it in a different language, but I
> > haven't found anything that really appeals.  I don't want to go to
> > C/GTK or C/Qt since that would make it hard to port to Windows and
> > MacOS AFAIK.  Python/Tk would be a possibility, but I have never
>
> C++/Qt4 is ported to Windows.
>
> > Any suggestions?
>
> It(Qt4) wasn't a suggestion though. I still consider Tcl/Tk more portable.
> -

Qt4 is a very good designed and elegant API and it works perfectly
under Windows, see current porting of qgit under Windows:

              git://git.kernel.org/pub/scm/qgit/qgit4


Language to use is C++, not C (much more powerful IMHO)

One thing that you should note is that if you go Qt4/C++ you can
forget to have it all in one file.

I think you should consider the new gitk 'footprint' becuase if you
leave TCL, any windows library you use will force you to create a
multi file project.

 Marco

P.S: If you choose Qt/C++ (the best technically speaking ;-)  please
you could consider starting from an already laid out code base instead
of starting from scratch.
As example, hmmmm, I think there is one called 'qgit', if I remember
correctly. It's nice and very very very fast.
