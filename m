From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Creating objects manually and repack
Date: Fri, 4 Aug 2006 01:11:56 -0400
Message-ID: <9e4733910608032211r3571f6adje52968ffcb689457@mail.gmail.com>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	 <Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	 <9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	 <Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	 <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 07:12:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8ryc-0002Qu-7g
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 07:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWHDFL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 01:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWHDFL7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 01:11:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:58831 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030193AbWHDFL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 01:11:58 -0400
Received: by nf-out-0910.google.com with SMTP id x30so1232348nfb
        for <git@vger.kernel.org>; Thu, 03 Aug 2006 22:11:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bO5pkexDqRNCQHOKZj992Lwib6G6hyfjp0dqnon/azw1ol/ax8+QKaAU/Byxlp+HnOxVqZHGDiGrQK03zfOpXG0N4Z22PoLQ4xaeTjkRtkqkCfSQ0S3C8CYmPWktrc4I5cwcR+wdOH/QRhwXtkEN2mu3A550//hSUWZsXYEoYcs=
Received: by 10.78.165.16 with SMTP id n16mr1412633hue;
        Thu, 03 Aug 2006 22:11:56 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Thu, 3 Aug 2006 22:11:56 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24776>

On 8/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Thu, 3 Aug 2006, Linus Torvalds wrote:
> >
> > Sure. In that case, just list the object ID's in the exact same order you
> > created them.
>
> Btw, you still want to give a filename for each object you've created, so

I'll add a file name hint.

I'm converting the cvs2svn tool to do cvs2git.

Martin has a copy of it up under git. I haven't checked in any of my
changes yet.
http://git.catalyst.net.nz/gitweb?p=cvs2svn.git;a=summary

If you read the log it is obvious that these guys have done major work
to deal with all kinds of broken CVS repositories. I want to piggyback
on that work and reuse their code that builds change sets.  So far
this is the only tool I have found that can import the Mozilla CVS
without errors. Only problem is that it imports it to SVN instead of
git. I'm fixing that and learning Python at the same time.

-- 
Jon Smirl
jonsmirl@gmail.com
