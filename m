From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: Why isn't builtin.h used by all builtin/*.c files?
Date: Wed, 01 Sep 2010 07:56:37 -0700
Message-ID: <4C7E69A5.4070008@gmail.com>
References: <AANLkTinHtvHt0q=dK9KHtCX6JzymB5dx1NuaAZN_uu2R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 16:57:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqokI-00035R-Sd
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 16:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404Ab0IAO45 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 10:56:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47620 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953Ab0IAO44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 10:56:56 -0400
Received: by pwi3 with SMTP id 3so792708pwi.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=c8/iHrN/qvvDoEcLm6nfYttNJy3cMz3ggJUFCAXrLZ0=;
        b=aZ9tdP5GUt33Z2EwbMgNvdMjSBaA1OysT3cXAXKWn586bYfxemfueT2h8Mx+9yzeHp
         td2unbdEzpHpkktdaMbHMKrR2lE8Kp4pCGXBIyU/RfGmzfXkRQzF8n4Y2HL/fZ41G4cc
         5DTTNWYiBVxpj/y26CjwkqkTcu9sB/MaRx7LI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pULHHKA0fKGkOtmoY7X7tE2EXmZ/QJbRtA5uS+8lZPCu/arvNy25BAvNr2JHRi2KvR
         UlrlXAWCAAAGcxrV7l+KHF18QAdr9Aa7K+JZzcW439EemQWWzVs497/rR3sqUyIYq1yc
         gRxDIkn1Iyx0FVhNxaA/6k5isr7wMn0Azn4Hw=
Received: by 10.142.207.9 with SMTP id e9mr2786070wfg.111.1283353015612;
        Wed, 01 Sep 2010 07:56:55 -0700 (PDT)
Received: from [192.168.1.101] ([75.85.182.25])
        by mx.google.com with ESMTPS id v38sm12602197wfh.0.2010.09.01.07.56.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 07:56:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100831 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <AANLkTinHtvHt0q=dK9KHtCX6JzymB5dx1NuaAZN_uu2R@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155048>

 On 09/01/2010 07:17 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> I'm working on gettextizing the 'mainporcelain common' commands now,
> and I ran into this:
>
[snip]
>
> Anyway, I'll convert these to builtin.h where appropriate as part of
> the series unless someone can find a good reason not to.

Sparse warns about this too. "Prototype not found, should it be static?=
"
for a few cmd_*'s. So sounds good to me.
