From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Mon, 7 May 2007 14:56:37 +0200
Message-ID: <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com>
References: <loom.20070502T111026-882@post.gmane.org>
	 <20070503180016.GB21333@informatik.uni-freiburg.de>
	 <20070503200013.GG4489@pasky.or.cz>
	 <loom.20070504T143538-533@post.gmane.org>
	 <87y7k4lahq.wl%cworth@cworth.org>
	 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
	 <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
	 <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Karl Hasselstr?m" <kha@treskal.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 07 14:56:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl2ld-0001nm-QF
	for gcvg-git@gmane.org; Mon, 07 May 2007 14:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933741AbXEGM4j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 08:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933740AbXEGM4j
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 08:56:39 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:38519 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933741AbXEGM4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 08:56:38 -0400
Received: by an-out-0708.google.com with SMTP id d18so138371and
        for <git@vger.kernel.org>; Mon, 07 May 2007 05:56:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UI+KFw0yn7cQjAffcQ8mANDcPmWkBN7A2pKPlESIKwf7ltTzvT09j8nAWmb2VdRA8FTXWYEhK9ldTmRklxxX3YGmxMhWkFXYWrZv145OWdNGlv85kkjS3o4vkvPYxKV3DC4lXTkUVr9J/V23JFZig5cYc0dmKzq26hbw8lhqVvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tscRKTe4kyfgIhyxn5zTz6N6nulIm7VIP8SUYg7+LC6vDmJb3Pc8lGLYwtl9nnfYsMjltu8rj5IQOxSSO5Ox9cv1VSCe0HgljPb9p1ZvQayT8CxLcy05OpsDH7ORbQ06LPY9ss/9bnotJRtNcckG4x+i/SjBEztEk/M4agJMN1E=
Received: by 10.100.248.18 with SMTP id v18mr4737014anh.1178542597787;
        Mon, 07 May 2007 05:56:37 -0700 (PDT)
Received: by 10.100.202.10 with HTTP; Mon, 7 May 2007 05:56:37 -0700 (PDT)
In-Reply-To: <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46460>

On 5/7/07, Paul Mackerras <paulus@samba.org> wrote:
> I have thought about rewriting it in a different language, but I
> haven't found anything that really appeals.  I don't want to go to
> C/GTK or C/Qt since that would make it hard to port to Windows and
> MacOS AFAIK.  Python/Tk would be a possibility, but I have never

C++/Qt4 is ported to Windows.

> Any suggestions?

It(Qt4) wasn't a suggestion though. I still consider Tcl/Tk more portable.
