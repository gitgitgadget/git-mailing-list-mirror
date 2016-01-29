From: Andrew Wheeler <andrew@igmo.org>
Subject: Re: [PATCH v3] push --force-with-lease: Fix ref status reporting
Date: Fri, 29 Jan 2016 16:53:46 -0600
Message-ID: <CAJay-wm=1Bf6HUvsZd-cRVh2ehU_aZ1SuiOBfBTQ2uafVnjNoQ@mail.gmail.com>
References: <1454012898-10138-1-git-send-email-agwheeler@gmail.com>
	<xmqqmvrpl2lb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Andrew Wheeler <awheeler@motorola.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 23:53:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPHvL-0006Dg-KJ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 23:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbcA2Wxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 17:53:48 -0500
Received: from mail-ig0-f195.google.com ([209.85.213.195]:33875 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbcA2Wxr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 17:53:47 -0500
Received: by mail-ig0-f195.google.com with SMTP id ik10so5583156igb.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2016 14:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fGQUWxbDz9lA67K2p+fWbVXATz+nm6nFx/1oPglgHak=;
        b=JYofTKBvn58WUt01JH86gApZ9icguNiAZV7NaPY8MBWLqE6lzkT7XjTlZ0V6JE5ZZB
         J8VhVJ/eZo7dSviMDsxzdQdJH84srq70SFGFmPGfMuqZaqLRZhQTX1EjMewyiBup9+em
         KYQfTzuDhVVFTA32qfpdDXbtbKPDHSAia1/PXM78fQ90aLsXy5Wlh5VRDE6SwHeOCzDo
         a3zKcaIOuX9URwsElsPUKtJekEnCN/kAN9umkO7oxEK35entKeeHQTuyuzIR96RJjYR6
         7bIdN26BLsTWmZyqFRiBjpxfGBA895rkm1cAds8GNdBe501v1WhrSF3TXwoCdKjNx0Hw
         VQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fGQUWxbDz9lA67K2p+fWbVXATz+nm6nFx/1oPglgHak=;
        b=O4dShE+gwOqLVJ0wm3EcKv5aOoplKBixsOQFaIWrYRLS3AvWe2GguvQHQSAuuoNuFv
         awSVMDRXiKxzK7yYbUrhiZx/wFYHUbMpC9JR+mCeqFSdI/lH/nuEBBpaLy4M3uPy4sc7
         zgcPqQB0KI/JtLtAKZMpxfWobduQ3d4uKVLrQgR2tL+rh0xZ5HR5KKSsoBb3QVPASNWF
         vOZLN/YFuRVaQsleZ7x37lazCRVuEsimBSzn58huLkgnnoJTxpho/oSxEAzO4jEsId40
         1Pjs8wcSGPRPRQcKYAlJ4LlbHMOmFI1TDVDthYa2Sh3y1Xja4lrtbRIrsoiKneBggGFR
         bxGg==
X-Gm-Message-State: AG10YOSUKARoyvnQ0ONk+kWD6pHmy76aTIkc+JxSw4U0RK0q0jJSNywwWACf6t9tQCyJUNWuezz/MEdJPy55gw==
X-Received: by 10.50.8.42 with SMTP id o10mr11941723iga.59.1454108026702; Fri,
 29 Jan 2016 14:53:46 -0800 (PST)
Received: by 10.79.5.147 with HTTP; Fri, 29 Jan 2016 14:53:46 -0800 (PST)
In-Reply-To: <xmqqmvrpl2lb.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: f_B0XICHVMkPB-Rfcd-0S2L-iDA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285095>

> These all look OK (I am not sure about message i18n, though).
>
> Do we not test a case where --force-with-lease push is rejected due
> to REF_STATUS_REJECT_STALE?

Good idea, new patch on the way.


-andrew
