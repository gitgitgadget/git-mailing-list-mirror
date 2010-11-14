From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/4] builtin: use builtin.h for all builtin commands
Date: Sun, 14 Nov 2010 16:11:41 +0100
Message-ID: <AANLkTimhrEAgOwfHb07vaR-QxWW6PicRWgiP8BBtP+_E@mail.gmail.com>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
	<1289745857-16704-5-git-send-email-avarab@gmail.com>
	<AANLkTi=SbqD_3yYsRGCsmSxh-B8kpupnjq0XPGjMsxdK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 16:11:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHeF9-0001ju-VR
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 16:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab0KNPLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 10:11:43 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41133 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab0KNPLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 10:11:42 -0500
Received: by fxm6 with SMTP id 6so1214074fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 07:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t+erZTyEMH0q9z9vmiAvv0wpGfB4m/Kn+b7IA7PTSLg=;
        b=aDB8doEyKlSq8AsyUi3XdA64Am/QPUsw7UJFYbCKgDeRei64CBnR4E6fcGl8npju42
         5oD+JO4VDy7vxLSlIJsvFoVNvT+OFaMQRwQxUmCkZJMlaj3EQVm0EuX4zYyFP3kxfdkF
         52+l6aWTnmcw2TMO5K7ievjpyA80eKFBw7Kws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xVQIhMoEN3TrxnZPLeJpjPt8mROSKqgVSi4t8v6F9G3HT4B2AWZNGvWGLiaBSeBtFx
         8ssx4RfpfYVNp7wyERF+1wr+Zr/v5sAmPZCc6mEyeprDWiZeTUb2lRS03Ot6dnPZk7F/
         XuGx0N6FRN5ZfWbmretDxO92bE1jN5C86Oc4U=
Received: by 10.223.101.131 with SMTP id c3mr3763210fao.95.1289747501354; Sun,
 14 Nov 2010 07:11:41 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Sun, 14 Nov 2010 07:11:41 -0800 (PST)
In-Reply-To: <AANLkTi=SbqD_3yYsRGCsmSxh-B8kpupnjq0XPGjMsxdK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161419>

On Sun, Nov 14, 2010 at 16:01, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> On Sun, Nov 14, 2010 at 15:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 <avarab@gmail.com> wrote:
>> diff --git a/wt-status.c b/wt-status.c
>> index fc2438f..bfc97fb 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1,4 +1,4 @@
>> -#include "cache.h"
>> +#include "builtin.h"
>
> Doesn't this suggest wt-status.c should be moved to builtin? Or
> something like that.

It just suggests that the header was useful. But maybe it should be
moved to buildin/status.c.
