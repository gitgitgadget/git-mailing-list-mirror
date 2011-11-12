From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: Update Linux kernel branch source from GIT
Date: Sat, 12 Nov 2011 18:59:20 -0200
Message-ID: <CACnwZYdFByS7pAgi5di8jDE=tYMvFQtxsTTiGqY9O0O3W04Dig@mail.gmail.com>
References: <7vsjlyw0y4.fsf@alter.siamese.dyndns.org>
	<4EBCB737.4090100@kom.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Kom <erickom@kom.za.net>
X-From: git-owner@vger.kernel.org Sat Nov 12 21:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPKfr-0003x3-2e
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 21:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab1KLU7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 15:59:22 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55303 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab1KLU7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 15:59:21 -0500
Received: by ywt32 with SMTP id 32so1206919ywt.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 12:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=L/RklmRHQLrZjOrfYoQ7/0pvx+hO5nTR9Wd42iJNxbw=;
        b=GXj60wCq+pOWay2NOG72RKrzvcsP1zGyk4g6/m14emUyetaKncSYUURUVO8fTQ9KnJ
         rCpMs9Quffe6QZSASm0v+cPNX+e0UGphvNYispnqR0FRCs/XhwFAMve8ZyMszefuf67A
         Jb3Svz0YGLNtRAjkDvzOD582y6lXhO1gzPxnE=
Received: by 10.147.127.27 with SMTP id e27mr1357061yan.34.1321131560918; Sat,
 12 Nov 2011 12:59:20 -0800 (PST)
Received: by 10.146.191.7 with HTTP; Sat, 12 Nov 2011 12:59:20 -0800 (PST)
In-Reply-To: <4EBCB737.4090100@kom.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185317>

On Fri, Nov 11, 2011 at 3:48 AM, Eric Kom <erickom@kom.za.net> wrote:
> Good day,
>
> Am new on this list, and also compile the kernel linux from git after
> clone. since I don't use the tar kernel version, am use to clone a new
> kernel branch instead to update it via patch.
>
> Please can you explain to me how to make a patch after clone it?
>
To make a patch?

I think you want something like this (uncompleted/untested offhand):

$ git checkout -b my-patch origin/master
# hack on some files
$ git commit -a -s
# edit commit message
$ git format-patch
$ git send-email

Hugely these are the commands I'd use to make a change and send it out to LKML.
