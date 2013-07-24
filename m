From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/5] t4211: demonstrate empty -L range crash
Date: Wed, 24 Jul 2013 16:18:35 -0400
Message-ID: <CAPig+cQJn+9eNcQZ6PBPVJ4firFs3LNetDMKo4BbF9kFVjKRfg@mail.gmail.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
	<1374589688-27751-3-git-send-email-sunshine@sunshineco.com>
	<20130723175942.GA21019@goldbirke>
	<7vvc416qvq.fsf@alter.siamese.dyndns.org>
	<CAPig+cTPcFJ_kfQ7zveE-Uf-itRRw2O99vQ61Or0QHvkKnxc_g@mail.gmail.com>
	<7vbo5s6ljb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 22:18:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V25WD-0005HX-9N
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 22:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab3GXUSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Jul 2013 16:18:37 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:63591 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab3GXUSg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jul 2013 16:18:36 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so698697lab.3
        for <git@vger.kernel.org>; Wed, 24 Jul 2013 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=afqY1Cr4ve94BX3ySSciVn7lGhQzCtpai6niBHKwACI=;
        b=IjbzO0gHP0Fc/0HYRdtIw6F84HVO870uYbdGoTfQ/RP7fBIAyggMLhI/AkaaVGQ0Ip
         fJDT+LBvdDDxdrfQL64L1SaokOJDgUBQ+iWu/0aMJCQogVZScyLeIWNKQrEGclarOXxC
         PJqDvU6NSqA8bDHqMqR4YueryxZVCODBl8XUwq8vT91E0DcmZuHmVXfPjB2G48LkpSoc
         p76ojpuslQLzHtF81Pwe1AbOVHm1WhRQK3QV8nkJuIyRCWGCmfj5ae5JH/i02tnnqLf0
         9JUbaAFTmMDayO/iH3u6lyu2DV314Z/kYBNGUVDQe85mH7bEDF5/OJYi9F1KMZHbas4K
         /T2Q==
X-Received: by 10.152.4.65 with SMTP id i1mr17757366lai.21.1374697115313; Wed,
 24 Jul 2013 13:18:35 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Wed, 24 Jul 2013 13:18:35 -0700 (PDT)
In-Reply-To: <7vbo5s6ljb.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: KFE_nWoMCzT5LznwmeRac8Wtv80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231116>

On Wed, Jul 24, 2013 at 11:10 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Jul 23, 2013 at 3:03 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>>>> You could avoid the 'cat' here and patch in 4/5 by doing $(wc -l <=
b.c).
>>> Correct.
>>
>> Thanks, I like that better.
>>
>> Unfortunately, what actually got queued on 'next', after applying th=
is
>> fix-up and re-ordering the patch series, is slightly bogus.
>
> The lesson is that one should not rebase while waiting for a flight
> in a hurry X-<.
>
> Will queue the following on top.

Thanks, that looks fine.
