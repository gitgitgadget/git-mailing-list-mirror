From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 16:50:50 +0200
Message-ID: <AANLkTikY6-Q1UphyfpsBo6_Hu98ZbVyeGmB7ZmI8FbTC@mail.gmail.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> 
	<4BFE83A7.4020604@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 16:51:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHeQf-0006VL-7x
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757903Ab0E0OvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 10:51:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33926 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744Ab0E0OvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 10:51:16 -0400
Received: by vws9 with SMTP id 9so24444vws.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=vzBnC3hwE3RdsiqBdvsDLJe8XcyxfSEmet2FPFcwfps=;
        b=mz2ZzBIkovER0Q2ytVgwmcIN7JHcAlVPjJfZxO7oh+MzIFkMei/Y3nBCXr8RUoGc9O
         ABpTMFfAlxKcpcQV1hmpi2CTvxwfsBWhSfSnbS4HBH66pS/Pyjyp9eG27nEaMBrHlU4l
         n6qko/3t8r1VgGPLpLDs3z51b7jYC0h8SwhjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ADU6OSv4FhL7sH4RqQ61GczWHfVCeN4XnciKZu3atGxOEqvzaVxjzhnnjtyXM4kFPH
         CwhFpmOSYjtccOwujS9cGKtcajDkDoKVyCM3Wa2vkmoXFI7h/+qegJf+13ZGHEHlXgZe
         2hR5ZDDB8pr5Ls5lU4/pwh1n3+eyGp33ZwKIA=
Received: by 10.229.104.194 with SMTP id q2mr2300337qco.69.1274971871133; Thu, 
	27 May 2010 07:51:11 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Thu, 27 May 2010 07:50:50 -0700 (PDT)
In-Reply-To: <4BFE83A7.4020604@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147868>

Hi,

On Thu, May 27, 2010 at 4:37 PM, Ivan Uemlianin <ivan@llaisdy.com> wrote:
> git-pull is 755, and I can run /path/to/git-pull (I get an error and it
> crashes, but I have the permission).

Your error comes from run-command.c:290 - Maybe it tries to execute
git-pull and (wrongly) reports that it wasn't able to execute it? What
error (and return status) do you get when you execute the script
yourself?
It looks like there's something wrong with your installation of Git.
Perhaps you'd like to re-install?

-- Ram
