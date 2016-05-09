From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t6044 broken on pu
Date: Mon, 9 May 2016 16:10:47 -0400
Message-ID: <CAPig+cSg7e=aV4YmJ2iioo6GHB7ZeNREKC-20X47F=5MbzDQLA@mail.gmail.com>
References: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
	<878tzmrrfg.fsf@linux-m68k.org>
	<d1fcc54b-ddd7-b03b-79fa-2112a3f43141@web.de>
	<xmqqa8k11e8j.fsf@gitster.mtv.corp.google.com>
	<5618208c-ce45-d65c-abf8-498cfe0f2f84@web.de>
	<xmqqoa8gza1t.fsf@gitster.mtv.corp.google.com>
	<CANgJU+V9+-hTFvDxCGbQxFcHMRcFaP-NdS_P93DqXuxi1Lh4mg@mail.gmail.com>
	<20160509083323.GB14299@sigill.intra.peff.net>
	<CAPig+cTyEU1gEwD5AuODkLzF--EOqo5_MQHD5QEFpb8dgh_wrw@mail.gmail.com>
	<20160509161226.GB11861@sigill.intra.peff.net>
	<xmqqr3dbulyp.fsf@gitster.mtv.corp.google.com>
	<xmqqh9e7ulie.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Elijah Newren <newren@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 22:10:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azrW5-0003oZ-Tj
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbcEIUKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:10:55 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35320 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbcEIUKx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:10:53 -0400
Received: by mail-io0-f196.google.com with SMTP id u185so22085590iod.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=gqNygSPHZ7Txplb2l40tsQlKMhlp32jO40Vc61+g23s=;
        b=ELzC6rxavjat52B/LGm+u5UTu2QgceUHTYEBOLHhBjf2XeJGn+Gg5JsvUqlymT+RR8
         2iTn4LHD/Tm7N7+lj5CLORnwUaCpJznxun0sS7sAWQ2EBhsgopzF9zsoxCPz+iKjQ5LG
         BBp0+Z6E37d/uYsRst2a4uivX82wr0pXIPl8o7Q0HSPua7Tdx0IGRvLh/+qe77awcrFr
         qAWPt/vgizK7NFCMThSkPvrImZb7i4V3GgWQ2BvoJbIGH+VPpzqGADTxs/yAfh++vrDM
         i9U7nT8tx4aZXv7KCuv2fuyrjVM5x7HXM3eK5KRDNvbb8XeH7NIAhIAYAV4l2mowGYYH
         9pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gqNygSPHZ7Txplb2l40tsQlKMhlp32jO40Vc61+g23s=;
        b=epUvdWO0E5Fl2FblnsUWbRbrcpefii8rOkMcpyNOWsbiFLF30HzvCuEngEv9/LFMgx
         1YgZm/OZpfy1LvFrb9eXltLFQcrJ13M+10F1ks9pntVmBbMB2l5uWTsqsL7qgwpG7Qd3
         NBntBne1IrOj731rOcB8mfgwmNc7BMDjjgvucy7vC2J60tfaptTl8/ZxBLTThI3HTROC
         Rb9ogJz41jGCU3V9L4psZxsCMi66B+7z1sliM1yFpU+DdC0wWmpcVh2J6YqfBaTaYDAN
         h/oadXhid7sChh9+KTkCvFeGz4ngXxStgAPg/121lZ6XEvP4dWeorGz76Pol4IctOo3M
         9LBQ==
X-Gm-Message-State: AOPr4FX4TMEPIA2v4Nc5bmK2X82HWNu/LRDO9pWzReH5n6QE5Hp2AD+MNYDF3wdjtRCLJ+7j45sC+yLiKjdwrw==
X-Received: by 10.107.132.66 with SMTP id g63mr42610541iod.34.1462824647959;
 Mon, 09 May 2016 13:10:47 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 13:10:47 -0700 (PDT)
In-Reply-To: <xmqqh9e7ulie.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: K97LuCtH5kLsNI5LCD6l0FxwYLY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294045>

On Mon, May 9, 2016 at 2:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: test-lib-functions.sh: remove misleading comment on test_seq
>
> We never used the "letters" form since we came up with "test_seq" to
> replace use of non-portable "seq" in our test script, which we
> introduced it at d17cf5f3 (tests: Introduce test_seq, 2012-08-04).
>
> We use this helper to either iterate for N times (i.e. the values on
> the lines do not even matter), or just to get N distinct strings
> (i.e. the values on the lines themselves do not really matter, but
> we care that they are different from each other and reproducible).
>
> Stop promising that we may allow using "letters"; this would open an
> easier reimplementation that does not rely on $PERL, if somebody
> later wants to.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -718,20 +718,13 @@ test_cmp_rev () {
> -# Print a sequence of numbers or letters in increasing order.  This is
> -# similar to GNU seq(1), but the latter might not be available
> -# everywhere (and does not do letters).  It may be used like:
> -#
> -#      for i in $(test_seq 100)
> -#      do
> -#              for j in $(test_seq 10 20)
> -#              do
> -#                      for k in $(test_seq a z)
> -#                      do
> -#                              echo $i-$j-$k
> -#                      done
> -#              done
> -#      done
> +# Print a sequence of integers in increasing order, either with
> +# two arguments (start and end):
> +#
> +#     test_seq 1 5 -- outputs 1 2 3 4 5 one line at a time
> +#
> +# or with one argument (end), in which case it starts counting
> +# from 1.

This new documentation is quite readable. Thanks.

>  test_seq () {
>         case $# in
