From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Make test-lib.sh emit valid TAP format
Date: Fri, 7 May 2010 20:25:33 +0000
Message-ID: <AANLkTinitdHqD2-viSB2jnS6jONWQQZznp1V0JW934CN@mail.gmail.com>
References: <1273261025-31523-1-git-send-email-avarab@gmail.com>
	 <v2sfabb9a1e1005071250i5cfbcb93qbbed103d1d8c73d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:25:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAU7A-000686-Vd
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198Ab0EGUZg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 16:25:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54207 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090Ab0EGUZf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 16:25:35 -0400
Received: by gyg13 with SMTP id 13so872704gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FSjxv5EgBUlOTgfa9LQdTIFPbhvjnti6hTOduEKP0y8=;
        b=bqfySyryg/MKXIVQvDVy7+F/1CFCUS+6ZXIfddNP37spU67Al2Ap902ctB5lPJ18Nn
         1pfDrsAnflmRYgjNhFQJlmrG1wajjzo1hWjlsHQVKsaxiq00xg18nlIO4aKkp9BFMbDG
         Hc6ZkOxYZkaN7l/NefQjmOuSslDF/CIupRtBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GAJksZvlZtZ29jhsBn/i+bhK3PxXTL+EMKYZADVJ1fCzonnaxddSmwypEW+R52Z4PQ
         bFno7hibqI3s5dCGD9lFEqNHmuSOd/Hz2HgPplS390W/rmxcNIPSEfol+Jca5RLr6UJD
         N83sBw7D4aXWlh+uZPUDsi3FVDyqsyYtutVC8=
Received: by 10.231.160.135 with SMTP id n7mr328295ibx.26.1273263933488; Fri, 
	07 May 2010 13:25:33 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Fri, 7 May 2010 13:25:33 -0700 (PDT)
In-Reply-To: <v2sfabb9a1e1005071250i5cfbcb93qbbed103d1d8c73d6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146587>

On Fri, May 7, 2010 at 19:50, Sverre Rabbelier <srabbelier@gmail.com> w=
rote:
> On Fri, May 7, 2010 at 21:37, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> On my quad Xeon server running the test suite with `make test` takes
>> 21 minutes. Running it with `prove -j 15 ./t[0-9]*.sh` takes just ov=
er
>> 5 minutes.
>
> That's not a fair comparison, how much does 'make -j 15 test' take yo=
u?

Indeed it isn't. I embarrassingly hadn't tested running `make test`
with -j. The time it takes prove and `make test` to complete tests
with -j 15 is the same (within a margin of error), although prove's
output is much better.

I'll submit an improved patch that doesn't have a confusing commit mess=
age.
