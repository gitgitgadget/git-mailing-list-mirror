From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv3 00/16] Add missing &&'s in the testsuite
Date: Sat, 25 Sep 2010 15:07:24 -0600
Message-ID: <AANLkTimvFycg229-_wSRTLo1TKeOqPxa1JJge6vDz3-O@mail.gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
	<AANLkTimL1d9EbcEjV9KDBuqFBG6aBRuFQoRX091j3RSM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 23:07:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozbxy-0000UB-8N
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 23:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756956Ab0IYVH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 17:07:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63290 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab0IYVHZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 17:07:25 -0400
Received: by fxm3 with SMTP id 3so1258370fxm.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hsMsC0HzdwTWO1B2YKXALwcDoUPveJG0soh0w4kfmDY=;
        b=PatwzwHRQP393o3M7iiiXQSDC+XOAGyD+NNuClI35J+e2J5xPB3s+W8s42xxFdzrbz
         g9mNrXWH1Mp3uxLZlh8XQhnnbbtqf70rZlkElyBg+5Stx2eMsRjnt87IaEN0/adw9K/Z
         WwkYnS7CtL+ABFnnV9Gbxj1YxMFgacDcyNfT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tES3qsnr0bt0Vjhp7Vi1eV6FB8X6rhcL1vQcWgVUhYN9MmbVux++FqqhU8BXakgzNX
         P0Ahja+6YZHfUe3qk/EreWIMU1dvrX9tCFRMU35y2hoe94OVGsZ/M0pFO0Y2KlOERPcx
         /id6nnpTsuO80nN4k4Cst5xUwdLimGg/E2pA0=
Received: by 10.223.124.206 with SMTP id v14mr4056782far.52.1285448844049;
 Sat, 25 Sep 2010 14:07:24 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Sat, 25 Sep 2010 14:07:24 -0700 (PDT)
In-Reply-To: <AANLkTimL1d9EbcEjV9KDBuqFBG6aBRuFQoRX091j3RSM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157203>

On Sat, Sep 25, 2010 at 1:39 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Sat, Sep 25, 2010 at 19:06, Elijah Newren <newren@gmail.com> wrote=
:
>> =C2=A0* Made several changes suggested by =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason and Jeff
>
> Except as noted in patch 15 (if that is an actual issue):
>
> Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Thanks, I'll resubmit with a fixed patch 15, after I can get some
confirmation on patch 11.
