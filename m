From: knittl <knittl89@googlemail.com>
Subject: Re: [PATCH] Match lightweight tags too in bash prompt
Date: Wed, 1 Dec 2010 00:16:38 +0100
Message-ID: <AANLkTinoZbSqwtiRwZ5+FZyn=6y7usgFi6p-JVUUTM5g@mail.gmail.com>
References: <AANLkTikeH=MODho_GsZP5VPQmt2NOoHyfw2pbt4yqGkt@mail.gmail.com> <AANLkTi=0+s164XkWHho1++hvnTCAFg5=GGfMbHF4ugTE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 01 00:18:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNZSv-0002RI-DF
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 00:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab0K3XRA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Nov 2010 18:17:00 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50622 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab0K3XQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Nov 2010 18:16:59 -0500
Received: by pzk6 with SMTP id 6so970003pzk.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 15:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WlT3X5l/42TQFRoVk0INPGGmBFaBpDqlG2kPRvE5F7I=;
        b=KjOEMh7dOW3zV05Mk4UInQ6fdgNbbtX1wkKOybkjsqmaxXuoR+j1pvtDW2JDeFmOZO
         WEcFV75mI/OYWFbuF4+QT9G/UpDtTJ7VOcswVjHjJgAvzu2bZXLR67rWAeX/Qqlnv/Ma
         bU+JCgB/VVZWyYI+gynJZvBdrYu7lXVb8C41o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LvkKWjdLMhpoZ+QrZCe/D8PsfqsYnXHSZ4fU6yE6UfvoripAjrMVtmsxs5SCd0BaWF
         Mvr9LABVR0/wPSh5mZl/tPCEFhpe1cd33PMW7PlbpNphvlRw38IMy17do6Ex41PS+Ryb
         t+vdj2t1et6N1EfTav8B6PY5F/WNmvlsAi+5E=
Received: by 10.142.172.13 with SMTP id u13mr7961600wfe.403.1291159018735;
 Tue, 30 Nov 2010 15:16:58 -0800 (PST)
Received: by 10.142.70.14 with HTTP; Tue, 30 Nov 2010 15:16:38 -0800 (PST)
In-Reply-To: <AANLkTi=0+s164XkWHho1++hvnTCAFg5=GGfMbHF4ugTE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162492>

On Tue, Nov 30, 2010 at 7:04 PM, Shawn Pearce <spearce@spearce.org> wro=
te:
> On Fri, Nov 19, 2010 at 7:43 AM, knittl <knittl89@googlemail.com> wro=
te:
>> From 1fea30e0167681917b4f40a3cb2cde9a90706011 Mon Sep 17 00:00:00 20=
01
>> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
>> Date: Fri, 19 Nov 2010 16:40:02 +0100
>> Subject: [PATCH] Match lightweight tags too in bash prompt
>>
>> provide `--tags` to git describe
>
> Missing signed-off-by-line.

i mentioned the s-o-b line already in my forward-mail ;)

>> ---
>>
>> bash prompt would display a commit's sha1, when checking out a light=
weight tag.
>> provide --tags to git describe in the completion script, so it will
>> display the name
>> of the tag (as it already does for annotated tags)
>
> This information is useful justification for the change. =A0It should
> therefore appear in the commit message, above the --- line.

ok, i'll resend v2 tomorrow morning to you and the mailing list


cheers, daniel

--=20
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
