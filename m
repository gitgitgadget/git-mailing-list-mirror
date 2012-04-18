From: Lucian Poston <lucian.poston@gmail.com>
Subject: Re: [PATCH v3 2/7] Add output_prefix_length to diff_options
Date: Tue, 17 Apr 2012 19:31:12 -0700
Message-ID: <CACz_eyftA6GQhSMscoucEbzKagjTSU3Psd8z+d9_oWWrKD--+w@mail.gmail.com>
References: <1334573095-32286-1-git-send-email-lucian.poston@gmail.com>
	<1334573095-32286-3-git-send-email-lucian.poston@gmail.com>
	<7vsjg3tsvv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 04:31:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKKft-0000yh-C9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 04:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab2DRCbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 22:31:13 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41111 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab2DRCbM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 22:31:12 -0400
Received: by pbcun15 with SMTP id un15so8353357pbc.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 19:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=mHN2oCFn/eoXClweN1I5KcA7lmbxFBU8BNKEa36RaPQ=;
        b=wcgxuXwqfi+lheR3fvR2Q8D627AogxBqZS2lmnsUInWsXQijWEQGqVHrFeSx/+R5H9
         jiVbezN3ucmHDl4mTZU3T7VAFQp8stuGzAkXFh1FTmyafKs67tAj7Hd6l9N+CW+hQvUM
         6JG+HUqh1XU/p6V2dM6qcWri3ts/uYTMEn5Z0VNdZJtiADxUv5SDbxHcVOy4T9DGTV8J
         fwxR3btNAK/kYUTxYqiia/HYzlRvIrbOJUphiY/lqn0r1Qw1TrW9VRYULAFOxLYAlABE
         2TEBIH81Q1HF1AWSK2siJl5dF5QsKkQRKpO2fjQQVGQzpDVNV1svTUc02PEUxdvldd+U
         sStw==
Received: by 10.68.194.1 with SMTP id hs1mr2443035pbc.6.1334716272320; Tue, 17
 Apr 2012 19:31:12 -0700 (PDT)
Received: by 10.68.58.129 with HTTP; Tue, 17 Apr 2012 19:31:12 -0700 (PDT)
In-Reply-To: <7vsjg3tsvv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195830>

On Mon, Apr 16, 2012 at 11:48, Junio C Hamano <gitster@pobox.com> wrote=
:
> Lucian Poston <lucian.poston@gmail.com> writes:
>
>> Add output_prefix_length to diff_options. Initialize the value to 0 =
and only
>> set it when graph.c:diff_output_prefix_callback() is called.
>>
>> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
>> ---
>> =C2=A0diff.h =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A0graph.c | =C2=A0 =C2=A03 +++
>> =C2=A02 files changed, 4 insertions(+), 0 deletions(-)
>
> This patch is a no-op, as nobody pays attention to the value this fie=
ld
> contains. =C2=A0I think it is better to squash this with 3/7 where yo=
u
> introduce the only user of this field.
>
> Also when that happens, you would need to adjust the test vector, whi=
ch
> may mean that you need to squash the result with 4/7 as well.

Squashed.
