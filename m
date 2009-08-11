From: Ori Avtalion <ori@avtalion.name>
Subject: Re: [PATCH] Change mentions of "git programs" to "git commands"
Date: Tue, 11 Aug 2009 14:49:00 +0300
Message-ID: <4A815AAC.2030601@avtalion.name>
References: <4a7c3971.170d660a.3caa.20b3@mx.google.com> <20090811125813.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:05:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maq5x-0004GO-UQ
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbZHKL54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 07:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZHKL5e
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 07:57:34 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37848 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbZHKL53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 07:57:29 -0400
Received: by bwz19 with SMTP id 19so3116472bwz.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5Be9qYJNIts1X56iPjVww+lJygia+JNCRCbKX041g6o=;
        b=Gi4tgNGIBW7rB/qMb2zDH0aqnQePYaAjZvv7LrIklEORuQo/5jAtyTtncJsUEe02W9
         TuoTzSXRipYIyl5iioBO3e1Y6UFPMvkw512ccVww72kvWBf9LhziGAL5xJPmaWC4DO2S
         lap4+w7DxguDXKXfHnU9myNgyJTNu6oIH+OG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=ZrhUFsp1srCsWWvlIY11RlGmtJv7mQ7Ng2EBRh2G8Xx/MddTMSQQhrCAJawdClZTRu
         Hl47aSlFnPZ+Z3LsvXRiGJR8sF7Qy6vWlgQGDPGxrjSycdvZUVASlgs+Dj75DEbEHYrH
         7YmA7hlMPvWx40XKT3/cQZr9wKxb5SSej2o5w=
Received: by 10.204.114.136 with SMTP id e8mr1447215bkq.149.1249991352351;
        Tue, 11 Aug 2009 04:49:12 -0700 (PDT)
Received: from ?192.168.1.55? (bzq-82-81-59-125.red.bezeqint.net [82.81.59.125])
        by mx.google.com with ESMTPS id g28sm8101007fkg.15.2009.08.11.04.49.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Aug 2009 04:49:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1.3pre) Gecko/20090809 Shredder/3.0b4pre
In-Reply-To: <20090811125813.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125520>

On 08/11/2009 06:58 AM, Nanako Shiraishi wrote:
> From: Ori Avtalion<ori@avtalion.name>
> Date: Fri, 7 Aug 2009 17:24:21 +0300
> Subject: [PATCH] Change mentions of "git programs" to "git commands"
>
> Most of the docs and printouts refer to "commands" when discussing what
> the end users call via the "git" top-level program. We should refer them
> as "git programs" when we discuss the fact that the commands are
> implemented as separate programs, but in other contexts, it is better to
> use the term "git commands" consistently.
>
> Signed-off-by: Ori Avtalion<ori@avtalion.name>
> Signed-off-by: Nanako Shiraishi<nanako3@lavabit.com>
> ---
>

Thanks Nanako!

I'm fine with the changes.
(it doesn't help much to nitpick on 'git-foo' vs 'git foo' vs 'foo' :)

You might want to consider this patch too:

diff --git a/Documentation/git-mailsplit.txt 
b/Documentation/git-mailsplit.txt
index 5cc94ec..8f1b99b 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -3,7 +3,7 @@ git-mailsplit(1)

  NAME
  ----
-git-mailsplit - Simple UNIX mbox splitter program
+git-mailsplit - Simple UNIX mbox splitter

  SYNOPSIS
  --------
