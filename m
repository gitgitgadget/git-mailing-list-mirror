From: "Reini Urban" <rurban@x-ray.at>
Subject: Re: shared lib+symlinks patch for cygwin
Date: Sun, 22 Jun 2008 10:19:19 +0200
Message-ID: <6910a60806220119g2a515f44qdfd664459923fc70@mail.gmail.com>
References: <6910a60806220056i1dda7f4elb4e5c69cdeea3cf9@mail.gmail.com>
	 <485E08F7.ADE2290C@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 22 10:20:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAKoJ-0007Dr-Ln
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 10:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbYFVITi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 04:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752709AbYFVITi
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 04:19:38 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:52554 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbYFVITV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 04:19:21 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1875737fkq.5
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=PBexh6uxebo0JIe+UfBmOXDNHk8lg+vO1zuEneTGoB4=;
        b=MDLwC5uGyY91uIdPgolT7ADFeRehw6RXqfkj70tSDq80zuPFaWwbIoTy6ewJezOiLC
         8Xw9O9wKE0LfKjV20s5YyQTizQ6dXggtRWp55Cki6ofLmCl50/KyAUZSgVR6v4OjpCbd
         2IKd89cAJOdoevF/tJ0YnQNfvYTVF6FawoKIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=l5nvO6WnRas88QtWqEKxLPu1bFesZAR1HJ/e5p50GGirxKijrNwKqGHKUF2jD4ekH4
         R+0Q4UTlE41MB6we0H+gzTSnEx5CKdxNdK6lwYtDIjzfUhlwjerAlzsrZq253omGXfsv
         G69MsVGmrDz31pQ5fCCbDQmlIXmO/yOf5FDNU=
Received: by 10.82.124.10 with SMTP id w10mr331113buc.18.1214122759332;
        Sun, 22 Jun 2008 01:19:19 -0700 (PDT)
Received: by 10.82.179.17 with HTTP; Sun, 22 Jun 2008 01:19:19 -0700 (PDT)
In-Reply-To: <485E08F7.ADE2290C@dessent.net>
Content-Disposition: inline
X-Google-Sender-Auth: c49408002b456837
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85754>

2008/6/22 Brian Dessent <brian@dessent.net>:
> Reini Urban wrote:
>
>> esp. on cygwin where file hardlinks do not work as on linux.
>> old bindir 5.8MB, new 2.7MB
>
> Hard links work just fine on Cygwin, assuming the underlying volume is
> NTFS.

And you have Administrator rights, yes. On cygwin you can install packages
without having root perms.

> What you probably mean to say is that the Cygwin setup.exe
> program won't create hardlinks from the tarball when installing binary
> packages.  But this could be worked around by creating the links with
> 'ln' in a postinstall script.  Then NTFS users would get the space
> savings and FAT users would get copies.

Good. So just postinstall.sh has to be fixed.
Anyway, I like the symlink approach to be fixed also.
-- 
Reini Urban
http://phpwiki.org/              http://murbreak.at/
