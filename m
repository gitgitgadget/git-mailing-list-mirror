From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: [PATCH] t0008: 4 tests fail with ksh88
Date: Fri, 20 May 2016 18:14:36 +0200
Message-ID: <CALR6jEgaHXAfh6137XYfouFbNL7SYSdrgE_+PSX=xiS8u-mNjQ@mail.gmail.com>
References: <CALR6jEhviK9KZxR6R6xzkZ5EAO-RjWj3xYah_DOSDXhEjYsT-A@mail.gmail.com>
	<xmqq37pchi90.fsf@gitster.mtv.corp.google.com>
	<xmqqk2iog16g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 18:14:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3n4U-0005UG-SM
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 18:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbcETQOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 12:14:38 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36310 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbcETQOh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 12:14:37 -0400
Received: by mail-yw0-f193.google.com with SMTP id u62so15410399ywe.3
        for <git@vger.kernel.org>; Fri, 20 May 2016 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TwJcj766vuvlyurCJHG4UbZj6HPY1iW/tlAMqSA/qTs=;
        b=YduBt6PjHXOmvO2OWX9+6nijILIBB0E4ppxhpBsEZLMsmQdnGY7tcBHwDEPaQqsRqe
         tQzFuCwRlllnUsAgS2epZ6BUU+yOTP5Qo2DlrXpF+iYruEMACm+4A8cqo/zOlBM3DGI6
         nkCsGJYmhWrhlGGxLphuXwSlVDMY/CJXS5O7WZm3Iqkj60MfjBS/kDrGyMn6FhDZYfVS
         CDSpc8sd/IOvUqt6HR3sgsX+gm33Fp3CBcW1X+qfdXNnWsPWmapMLTGNkNy5XRTBtU5S
         CHiA+LZdH0QRk1TT81hfj6xUkqomnywhCGUtrEpmNMnq0d84OTeMQHfy97DusKlf9x4b
         A6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TwJcj766vuvlyurCJHG4UbZj6HPY1iW/tlAMqSA/qTs=;
        b=XaNkxxOSfOU8S5zEH+FXmvr0E8bfgh4ZbimVELmg68AIgOo8uwiBuDbMZsA00A2x9+
         MrcIT5kdRAjf6bGVOjzCUwvRRuz4KuEUnQ+a7RzU1vQKOdC4ijEKkY/VCsSVIeAwMqUi
         cla3j9Zhb0/1eDKtnukI09jb2CquHC3np33Ique+ZzyIKlCltZV4GjuFKpMj+iDYV2St
         m0jl/Nbnh8tMEu3FqwmI8jbVT2CdOIQE7SgzBBctRWW+JOdILgL3YXKAJ7z6+TQwky9B
         uk8B8Ab+uZhlT5O7o3egaOof/M3N7R58+/s6aE0RrDVQEubx3frfbfGyoMkmpjo6I+YF
         KRXQ==
X-Gm-Message-State: AOPr4FVZAELZXjXBq01Tlb0dgxO3V0gBROiEUUrkMKSWH7MfymyBxYiWkV6GWMQHdUqwLToFKbJ0ZdTV4PMQuA==
X-Received: by 10.13.204.69 with SMTP id o66mr2423054ywd.168.1463760876665;
 Fri, 20 May 2016 09:14:36 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Fri, 20 May 2016 09:14:36 -0700 (PDT)
In-Reply-To: <xmqqk2iog16g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295182>

On Fri, May 20, 2016 at 6:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
>>> index 89544dd..b425f3a 100755
>>> --- a/t/t0008-ignores.sh
>>> +++ b/t/t0008-ignores.sh
>>> @@ -605,7 +605,7 @@ cat <<-EOF >expected-verbose
>>>         a/b/.gitignore:8:!on*   a/b/one
>>>         a/b/.gitignore:8:!on*   a/b/one one
>
> The patch was whitespace-damaged and didn't apply, so I had to redo
> it from scratch while updating the log message.  If this looks good
> to you, there is no need to resend.

Thanks. Looks like even Google Mail interface in plain text mode eats
white spaces :-(
