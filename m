From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH v3 13/13] some document update
Date: Sun, 18 Jul 2010 22:37:25 +0800
Message-ID: <AANLkTikmJmWfwdigYADX7JnrOxZBVvP9i7lDZ84yRz-B@mail.gmail.com>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
	<1278829141-11900-13-git-send-email-struggleyb.nku@gmail.com>
	<m3hbk6l901.fsf@localhost.localdomain>
	<AANLkTinO9uLByOvUMRf4Y9vcne1jNAfPnvT3Dq0l4xa9@mail.gmail.com>
	<7v1vb8bktw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 16:37:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaUzj-0002yi-PV
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 16:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863Ab0GROh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 10:37:27 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43231 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517Ab0GROh1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 10:37:27 -0400
Received: by qyk38 with SMTP id 38so1513755qyk.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xQnaQAInr9ScwWjt+yiCmDqBuKwxwAxZTsfTmVx63eM=;
        b=nNKDWHvW5SuQsFPJs2xqXBDh3MskZG3CM82jVhTypL+DVT6OV/qjh1w73pbwX6kkmR
         6RGUsjCP431lhY9FaQRPTW4QLWvEYPurnfO7rJXsTib+n1bcrUtUp9WOCQTUHJ9mdroH
         lJ04OyQ9ajdfzhwrv3j1CFFQxh/cUs6OOOzV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nFY5Zkab7b7K3hiujtabO2EJKGFw9ephsjTp38BZKyFT1/T14b/2nXU5iV1S3aslzq
         t0sJB/A85AxOmp+KW++vkm7ECHcqdhlEdAD78I9GA7zxmsT29XcjccZepL5xjosqSI8J
         NOra/bcG5+hCASwz5qAtcM+j31a47u38LHXaA=
Received: by 10.224.54.146 with SMTP id q18mr3286425qag.93.1279463845912; Sun, 
	18 Jul 2010 07:37:25 -0700 (PDT)
Received: by 10.229.79.148 with HTTP; Sun, 18 Jul 2010 07:37:25 -0700 (PDT)
In-Reply-To: <7v1vb8bktw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151213>

Hi Junio,

On Tue, Jul 13, 2010 at 2:45 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Bo Yang <struggleyb.nku@gmail.com> writes:
>
>> ...
>> Thanks a lot for your advice, I have revised the patch.
>>
>> -----------------------------------------------------------
>>>From 88ed88a53d83c2d46fa4917008efadc531ba1068 Mon Sep 17 00:00:00 20=
01
>> From: Bo Yang <struggleyb.nku@gmail.com>
>> Date: Sat, 26 Jun 2010 01:35:48 -0700
>> Subject: [PATCH v3 revised 13/13] some document update
>>
>> Both 'git log' and 'git blame' support the same
>> format of '-L' arguments, so put the argument
>> format description into a new file.
>>
>> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
>> ---
>> =A0Documentation/blame-options.txt =A0 =A0 | =A0 19 +---------------=
---
>> =A0Documentation/git-log.txt =A0 =A0 =A0 =A0 =A0 | =A0 13 ++++++++++=
+++
>> =A0Documentation/line-range-format.txt | =A0 18 ++++++++++++++++++
>> =A03 files changed, 32 insertions(+), 18 deletions(-)
>
> Every time you do this, you seem to send a corrupt patch, like...
>
>> @@ -19,6 +20,9 @@ command to control what is shown and how, and
>> options applicable to
>> ...
>> diff --git a/Documentation/line-range-format.txt
>> b/Documentation/line-range-format.txt
>
> Please don't.
>

I am sorry, I promise I won't do the same thing from now on. :)

--=20
Regards!
Bo
----------------------------
My blog: http://blog.morebits.org
Why Git: http://www.whygitisbetterthanx.com/
