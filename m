From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v4 3/4] t4052: Test diff-stat output with minimum columns
Date: Wed, 18 Apr 2012 14:19:09 -0700
Message-ID: <CACz_eydRKq6d5LU3OpYhZ84_TXOXoxYS=_PzkEJOfDinB1D2Kg@mail.gmail.com>
References: <1334716196-9870-1-git-send-email-lucian.poston@gmail.com>
	<1334716196-9870-3-git-send-email-lucian.poston@gmail.com>
	<7v4nsglru2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKcHc-0004E8-LD
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 23:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab2DRVTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 17:19:12 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:50465 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533Ab2DRVTK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 17:19:10 -0400
Received: by dake40 with SMTP id e40so10402905dak.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Jd7XDteWd77YW2oYxEdFD6C7hpvsKKPTsN5XVESsPTE=;
        b=Beja1M/pNLLC6zIjiI0jIyFX3gMBsQaUoNLMH7114LlibCNIFktT3F2/TWdLCc2XQs
         yrVbo+hG+HLr3lC6UK1gzNF9y37TuMY0/yLFjH+D1epfExiFLGMwIRVvyOLGjKvoUqUF
         0Eaoj+c4AiXI2LqPSb3ZojFaqxQiOQIlcP4rRagI86GS+FiUNhX1KIAdJJrUDlhWlSRO
         9h19as5YA/icSscWRKFXSsmkXGJBQU4mCRiHm2hynDJr8BHq2FP3kTXhxd45Wm7fRHkP
         hamX0yZ8euiJXS0XIl+2jbFLF6y4SCmtX0PiU2kwaM8lHwgmuRo4fq7rUFff3NZSAaHv
         EiLQ==
Received: by 10.68.194.1 with SMTP id hs1mr9561595pbc.6.1334783949746; Wed, 18
 Apr 2012 14:19:09 -0700 (PDT)
Received: by 10.68.58.129 with HTTP; Wed, 18 Apr 2012 14:19:09 -0700 (PDT)
In-Reply-To: <7v4nsglru2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195910>

On Wed, Apr 18, 2012 at 13:15, Junio C Hamano <gitster@pobox.com> wrote=
:
> Lucian Poston <lucian.poston@gmail.com> writes:
>
>> When COLUMNS or --stat-width restricts the diff-stat width to near t=
he
>> minimum, 26 columns, the graph_width value becomes negative. Consequ=
ently, the
>> graph part of diff-stat is not resized properly.
>>
>> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
>> ---
>> =C2=A0t/t4052-stat-output.sh | =C2=A0 28 +++++++++++++++++++++++++++=
+
>> =C2=A01 files changed, 28 insertions(+), 0 deletions(-)
>
> Running t4052 with this patch applied reports
>
> # fixed 2 known breakage(s)
> # still have 5 known breakage(s)
> # passed all remaining 81 test(s)
>
> Please mark the ones that already pass as "test_expect_success", leav=
ing
> the only broken ones as "test_expect_failure". =C2=A0Otherwise the pa=
tch to the
> test that contains the fix would not illustrate what it fixed.

Sorry about that. Fixed in the recently emailed diffs.

Thanks!
