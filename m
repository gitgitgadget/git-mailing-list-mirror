From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 02 Aug 2010 18:16:57 -0400
Message-ID: <4C5743D9.108@gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com>	<1280780684-26344-3-git-send-email-avarab@gmail.com>	<AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>	<4C5732CE.10906@gmail.com> <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:17:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3Jj-00037k-FW
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930Ab0HBWRB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:17:01 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42872 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0HBWRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 18:17:00 -0400
Received: by vws3 with SMTP id 3so2457395vws.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2+KADKGomtfZfXpzfWE7HjjY3Va05NPavJrRbsfaCG0=;
        b=VPI5xOVBj844ZbhjZo0RVDx/H1tqs0g+pZWcYPHD1ahDVf2kRtOE50HSgSqc1QwRQn
         nwJtMpbP4/pOL5P2jAEsSe2jXw4++UUeJOxQALAekDmayotU999IcPIQCsneP6ihP/7r
         FTlPEepjt8mWFJ0mGqNwpxL7bjpoEHZQyM6w4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=P7Fe+i3Ej3cUlfhKX2YWEXOiwexoUiSPfbCBYveXXOrscewTqd3uDe9iTaMXODvgjw
         lhQYIWcoj2IvG3c7hcHiogFFrC9OZgtj0QxsHN3gEbi7ycLn6G5RjulcX1Frn3A0v/FY
         TeHAUZMa6KXF0xnN8ctyUECkz9mF9cki497Bo=
Received: by 10.220.159.14 with SMTP id h14mr4635421vcx.115.1280787419517;
        Mon, 02 Aug 2010 15:16:59 -0700 (PDT)
Received: from [192.168.1.5] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id v11sm6430049vbb.12.2010.08.02.15.16.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 15:16:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152472>

On 08/02/2010 06:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Aug 2, 2010 at 21:04, A Large Angry SCM<gitzilla@gmail.com>  =
wrote:
[...]
>> And what's on the site tells us almost nothing about the tested syst=
ems.
>
> Can you be more specific? What information do you find lacking at
> http://smoke.git.nix.is/app/projects/smoke_reports/1 ?

The only information available there is that the tested system was some=
=20
Linux on an x86_64 and the particular git version tested. My complaint=20
is that "Linux" is _way_ too generic to be useful when trying to get an=
=20
idea of where things are known to work and where they are known not to =
work.
