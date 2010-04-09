From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] send-email: Add sendemail.smtpdomain
Date: Thu, 08 Apr 2010 23:56:30 -0700 (PDT)
Message-ID: <m3wrwhglnd.fsf@localhost.localdomain>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
	<1270789906-23735-4-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 08:57:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O088t-00050Y-TL
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 08:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0DIG4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 02:56:35 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:61092 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0DIG4e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 02:56:34 -0400
Received: by fxm23 with SMTP id 23so2599665fxm.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 23:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=AFaTcT3eGF/dT2QCf+fRoS70PVUgOvoQKlQlKMf85Is=;
        b=X6q1Uoe52xJaeYb/1QvzcmT3fqaYVfHL7N39i1FU9wHPcgn06dwr5/L3B+/mOYRSvp
         mLZa2HZvwTwzEQ/Bzn3jvQRchXPwCYl6eRMsohot9iIUlebbydEQqJt2Vdw+mdOIO8Sx
         t91ZF832/vLZcaWhlrmuGYNItAkExsU+Bt0Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=c7Ddrij0dnGCW5FiTSnz0osKjGo8wOhkBM2iGoIq4oN2jX5pv9jJiauNdoAkfXBBU9
         hGeRMLS/kazp0crGtHFjL1VRu4GlF2Y2TBO7RGLRWM+TP9Lg8rmfRoGZyED6U0QcjGXo
         1fmgJKyd0cLFkzFzm9NUB+rXlHAxTOyVQ+3lc=
Received: by 10.103.84.1 with SMTP id m1mr670509mul.26.1270796192340;
        Thu, 08 Apr 2010 23:56:32 -0700 (PDT)
Received: from localhost.localdomain (abvc167.neoplus.adsl.tpnet.pl [83.8.200.167])
        by mx.google.com with ESMTPS id j2sm3760182mue.23.2010.04.08.23.56.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Apr 2010 23:56:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o396tvP8006737;
	Fri, 9 Apr 2010 08:56:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o396tZm7006723;
	Fri, 9 Apr 2010 08:55:35 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1270789906-23735-4-git-send-email-brian@gernhardtsoftware.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144412>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> --smtp-domain is an option that if you need once, you probably will
> need again.  To help with that, allow the user to set it in their
> .gitconfig
             via 'sendemail.smtpdomain' ?
> 
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
> 
>  Seemed like a natural thing to add.  Was surprised it wasn't there when I went
>  poking around.
> 
>  Documentation/git-send-email.txt |    3 ++-
>  git-send-email.perl              |   20 ++++++++++----------
>  2 files changed, 12 insertions(+), 11 deletions(-)

You should also add one-liner to Documentation/config.txt, mentioning
'sendemail.smtpdomain' configuration variable (the part referring reader
to git-send-email(1) documentation).


P.S. Some of git-send-email configuration variables: sendemail.identity,
sendemail.smtpencryption, sendemail.smtpssl (deprecated), and the concept
of sendemail.<identity>.* are described in Documentation/config.txt, 
which means that they are present in git-config(1) manpage.  Some of them
are described in "Configuration" section of Documentation/git-send-email.txt
(which means git-send-email(1) manpage): sendemail.aliasesfile, 
sendemail.aliasfiletype, sendemail.multiedit, sendemail.confirm; I think
those are config variables which do not have corresponding command line
option.  The rest: sendemail.bcc, sendemail.cc, sendemail.from, 
sendemail.to, sendemail.envelopesender, sendemail.smtpencryption (which
is described in git-config(1)), sendemail.smtppass, sendemail.smtpserver,
sendemail.smtpserverport, sendemail.smtpuser, sendemail.cccmd, 
sendemail.chainreplyto, sendemail.identity and 'sendemail.<identity>' 
subsection (described in git-config(1)), sendemail.signedoffbycc,
sendemail.suppresscc, sendemail.suppressfrom, sendemail.thread, and
sendemail.validate are described only with corresponding command-line
option.

Huh...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
