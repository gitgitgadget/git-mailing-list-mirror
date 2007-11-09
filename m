From: "Yossi Leybovich" <sleybo@gmail.com>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 13:37:35 -0500
Message-ID: <4fe79b4b0711091037g8c6c048h29b7d387e75d62bb@mail.gmail.com>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com>
	 <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org>
	 <4fe79b4b0711090953h5b06f7d4l2d17972630a4d355@mail.gmail.com>
	 <alpine.LFD.0.999.0711091000310.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ae@op5.se,
	"Yossi Leybovich" <sleybo@mellanox.co.il>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYjs-0001mi-Ap
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbXKIShi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbXKIShi
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:37:38 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:44852 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbXKIShh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:37:37 -0500
Received: by nz-out-0506.google.com with SMTP id s18so586845nze
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 10:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A1t8K3SBA1w5uJKNBri8nAyl5TXyjZfElZ4Gsb+uAO8=;
        b=EmJllo70h+dNHJOsAXNbe4x0cjeNtkhFiv9c75cPadhAV71EH3lMz2bEKatHstADt5YJQUhcPWLh/0Agq9U+7JPfz58dF/eaXet8tmtRUSlj9KpQypb4nto6RS/BMWVa87P5n8rjioFuYBFutj2os9m5tVFTV5f0q6IiPExx+bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fvIny1yI4Fl0uUK0ZsUjhVPZBcZ7t79ABvHT4Hq3Wqp5OpfdFPBa0yhoyNrmxj0m5o0zzqRSBnaUDYNW5gTmJqLpoTHxm9o48yRZTb2OHJ3Lznd8xKUaGVWEJEzwsTnJIqdaReGM8aKkOcEJrTiSY90FWTaksJVM6OK/D6D0vxE=
Received: by 10.114.157.1 with SMTP id f1mr997579wae.1194633455634;
        Fri, 09 Nov 2007 10:37:35 -0800 (PST)
Received: by 10.114.174.5 with HTTP; Fri, 9 Nov 2007 10:37:35 -0800 (PST)
In-Reply-To: <alpine.LFD.0.999.0711091000310.15101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64245>

On Nov 9, 2007 1:02 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Fri, 9 Nov 2007, Yossi Leybovich wrote:
> >
> > Ok, tried that and unfortuantly the SHA1 number is apear only one
> >
> > [mellanox@mellanox-compile ib]$ git log --raw --all --full-history --
> > SymmK/St.c  | grep 4b9
> > :100755 100755 308806c... 4b9458b3786228369c63936db65827de3cc06200 M  SymmK/St.c
>
> Actually, that's not at all "unfortunately", because that implies that
> it's the very *latest* version of that "SymmK/St.c" file. I really think
> you already had it checked out, but didn't try my first suggestion of just
> doing "git hash-object -w SymmK/St.c" which likely would have fixed it
> already (unless you had changed it in your working tree, of course!)
>
Its very old version of the file.
What interesting is the second part of the experiment
I tried to apply the same commit on this file and it leaded to different SHA1




>                Linus
>
