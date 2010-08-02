From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 2 Aug 2010 22:32:36 +0000
Message-ID: <AANLkTimv7XKoTG1y=5RcUGmCmwpqyj=xVmT78F1OxNsw@mail.gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com>
	<1280780684-26344-3-git-send-email-avarab@gmail.com>
	<AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>
	<4C5732CE.10906@gmail.com>
	<AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
	<20100802221328.GA3826@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Sverre Rabbelier <srabbelier@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:32:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3Yp-0001Nz-Lu
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab0HBWci convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:32:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42371 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab0HBWch convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:32:37 -0400
Received: by iwn7 with SMTP id 7so4475259iwn.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=SvJ7bATWsF3vcWfP9tha/j89uqxMVcAfkPpHTnYgLyM=;
        b=oqrXcOnu75ghpqn6Cb7O/fDjPpPOtpscT42Q8d4X+arvXepEAVv8xLxgkBX6tzyIb1
         hm38E4eyPq1I9nY2R2amEUAzcwrL0N41rGV8fG5dHdm/wbWnYVmOSPaitX9dZ8I7BYB0
         S71S6TUNmuQYTSmw9JqXUg/LCC/WIdaqqVSyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OZ3BfQw++qg8yfApi889LFO/VfV3GXdWaiKlbseQaE0Spaoe8rbM2O2ZE/PjeDU+c7
         GcG2PJxqK2Mh9+HALhL5shgNR9gEMAkehFsFaESUqKxxycYWpAs6cnF05ddT3E6WSMot
         KHubuTauDSi6vc3LAVefM7WHnN2M23Kh9Xk6g=
Received: by 10.231.160.17 with SMTP id l17mr7516605ibx.102.1280788356596; 
	Mon, 02 Aug 2010 15:32:36 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 15:32:36 -0700 (PDT)
In-Reply-To: <20100802221328.GA3826@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152476>

On Mon, Aug 2, 2010 at 22:13, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Mon, Aug 2, 2010 at 21:04, A Large Angry SCM <gitzilla@gmail.com>=
 wrote:
>
>>> And what's on the site tells us almost nothing about the tested sys=
tems.
>>
>> Can you be more specific? What information do you find lacking at
>> http://smoke.git.nix.is/app/projects/smoke_reports/1 ?
>
> Operating system (i.e., distro). =C2=A0Precise CPU architecture. =C2=A0=
Number of
> CPUs. =C2=A0Available memory. Configuration used to build git.

That'd be nice. We could detect that and include it later in
extra_properties in t/harness. It'd need some fancy detection code
though.

> Which tests were skipped and which had expected failures.

That's actually already there.
