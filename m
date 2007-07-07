From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: git describe origin ?
Date: Sat, 7 Jul 2007 18:53:52 +0200
Message-ID: <38b2ab8a0707070953s33ca0d1aw879fd3d1a986aaeb@mail.gmail.com>
References: <38b2ab8a0707070851m25d615bdn4f7286cbadaf1316@mail.gmail.com>
	 <Pine.LNX.4.64.0707071728330.4093@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 18:53:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7DXg-00011E-08
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 18:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbXGGQxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 12:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbXGGQxx
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 12:53:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.237]:14809 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXGGQxx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 12:53:53 -0400
Received: by nz-out-0506.google.com with SMTP id s18so435935nze
        for <git@vger.kernel.org>; Sat, 07 Jul 2007 09:53:52 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IdpkM6MXz70N91REizxQxOFbiMJaxF9M3h6XoRKNDWrDIvm4ULzsaVJ97gxLEaeo1jv4TqCZ4By+zjvgD2NRWfdLJjZWuYGNqdw09JIhp/Rf0SsPAZ5GTYsQHyRy8+Z/aKlW26fAwYMBdefNZGnGfhWUMzWXwIrnjtvC6b2cC6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U+/cLF9IhPcvuxaizgLmN0a/weP7vgAybyyK8iTnm9BdriuVZijilosPR4GoRcNQ9YDkqMiJJb1+Sjv/s77mJFcPxbKoUAFKADNBbFAjZ3Zp0ltBOg5/A/EWv6Z3pQfrtguPbS/HlymfbpMUS4Yr41/Lao/XHHGUFEGsA4oa7yU=
Received: by 10.114.168.1 with SMTP id q1mr1661531wae.1183827232154;
        Sat, 07 Jul 2007 09:53:52 -0700 (PDT)
Received: by 10.115.47.12 with HTTP; Sat, 7 Jul 2007 09:53:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707071728330.4093@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51824>

Hi,

On 7/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sat, 7 Jul 2007, Francis Moreau wrote:
>
> > I was wondering what does 'git describe origin' command mean on a git
> > repo. Does it mean ?
> >
> >    a/ git describe origin/HEAD
> >    b/ git describe origin/master
> >    c/ something else
>
> This is completely unrelated to "git describe". It is about naming
> commits AKA "specifying revisions". You might find the section "SPECIFYING
> REVISIONS" in Documentation/git-rev-parse.txt especially helpful. FWIW
> this section is hinted at in the section "Symbolic Identifiers" in
> Documentation/git.txt.
>
> If you're too lazy to read, it's a/.

nope I'm not. I'll do read it thanks.

>
> > I also played with git remote and did something silly like:
> > $ git remote add bob /tmp/dummy # dummy does not exist
> > $ git remote show bob
> > fatal: '/tmp/dummy': unable to chdir or not a git archive
> > fatal: The remote end hung up unexpectedly
> > ls-remote --heads /tmp/dummy: command returned error: 1
> >
> > Maybe the output could be improved to be more readable.
>
> The first line is very helpful IMHO:
>
>         fatal: '/tmp/dummy': unable to chdir or not a git archive
>

yep but the 2 others are just noise, aren't they ?

BTW, shouldn't "git remote add" have complained at first ?

thanks
-- 
Francis
