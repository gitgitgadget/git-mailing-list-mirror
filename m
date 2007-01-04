From: "Chris Lee" <clee@kde.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 19:06:24 -0800
Message-ID: <204011cb0701031906i30366286q800fba716f9fa725@mail.gmail.com>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
	 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org>
	 <20070104020652.GB18206@spearce.org>
	 <20070104023510.GC18206@spearce.org>
	 <204011cb0701031836w7d33ca8dh5de08984eec9730d@mail.gmail.com>
	 <20070104024523.GD18206@spearce.org>
	 <204011cb0701031853xd226683g85f376c206aacf3e@mail.gmail.com>
	 <20070104025659.GE18206@spearce.org>
	 <204011cb0701031858x231df34as424b7f0c0ae4ab8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 04 04:06:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Iw2-0001Cr-JP
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 04:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbXADDG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 22:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbXADDGZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 22:06:25 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:55788 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932259AbXADDGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 22:06:25 -0500
Received: by wr-out-0506.google.com with SMTP id 68so783706wri
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 19:06:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kCgrsAWG+0ldP4FYjelOAIsK3FPlWai+nuLMSMKX7DVE0W3v+EKKN4XaEuTRc0ZR3px8N4qlIkLibX7q9og0K3xPRjFSTSi33S9CIUki1PsXyg1ql/nz97Zamna2+Lcz+4/c9xPrHTwHcZhEaRnzYcDohx2A8Jfa5p8lkpZdr7E=
Received: by 10.90.89.5 with SMTP id m5mr15358476agb.1167879984680;
        Wed, 03 Jan 2007 19:06:24 -0800 (PST)
Received: by 10.90.80.11 with HTTP; Wed, 3 Jan 2007 19:06:24 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <204011cb0701031858x231df34as424b7f0c0ae4ab8b@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 512125e89afe8669
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35913>

On 1/3/07, Chris Lee <chris133@gmail.com> wrote:
> Uh... somehow, it lost this part:
>
> > All that's needed is to get data from SVN in a way that it can be
> > fed into git-fastimport.
>
> That's what I meant - I assume that someone already has the
> svn-repo-to-gfi piece working? Where's that available from?

Right, and I'm an idiot! Awesome.

I obviously didn't comprehend the part where you wrote:

> I should also point out that my git-fastimport hack that we used
> on the huge Mozilla import may be helpful here.  Its _very_ fast
> as it goes right to a pack file, but there's no SVN frontend for
> it at this time.

Anyway. Thanks for the pointers, I'll see if I can't hack something up.
