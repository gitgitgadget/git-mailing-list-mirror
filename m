From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Mailing list headers: Date:<TAB> instead of Date:<SPACE>
Date: Mon, 13 Sep 2010 11:24:59 -0700
Message-ID: <4C8E6C7B.2090904@gmail.com>
References: <20100913150245.GT22527@danbala.tuwien.ac.at> <AANLkTinEb9geKox+a+HosQn-g4eKd-DW4agRCf8yqv=k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Klausner <tk@giga.or.at>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 20:24:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvDi5-0004on-D0
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 20:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab0IMSYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 14:24:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54330 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752515Ab0IMSYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 14:24:48 -0400
Received: by pzk34 with SMTP id 34so2246260pzk.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 11:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=RCbJuWk17Laus7fZ9WYeaTw8n+7Xt7CSw/e7zJc7YM0=;
        b=Z858mBy5MZeTdFjpx69EbN3TfWvqfwxymUwr3XOTGzhJfxVK9FhMvDkdQEIp4nfq3N
         O+bHs/8AHAvZDWgd6iy4Lgc3yBEViXjtggIDrLaybnP9/CgmX2CWEq4zomOl32fyXJxa
         H2+Fd155hj1t4i9k824XMe8ND6hBhXTO1BkqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pi37VZ2ABQ27EwMtWichhkwrxepOhElFsVhoIzgXDyIErtVKM99JBzg2LI5SPIpcVN
         Gks73YMCNEJopt5DU7G2GkGN9Xh1dXMVwXdutWg+Rne44xHoVxl8aLcmpNDvCrK/giCo
         M+jFrqJerY1Ry18s04Sh7djj0APOkP7/CHxdE=
Received: by 10.114.27.2 with SMTP id a2mr129854waa.25.1284402288275;
        Mon, 13 Sep 2010 11:24:48 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id d39sm12511900wam.16.2010.09.13.11.24.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 11:24:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <AANLkTinEb9geKox+a+HosQn-g4eKd-DW4agRCf8yqv=k@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156107>

On 13/09/10 11:03, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Sep 13, 2010 at 15:02, Thomas Klausner <tk@giga.or.at> wrote:
>=20
>> While this doesn't seem to be forbidden by the RFC, I think it is
>> at least uncommon, and here it causes trouble. Could you please chan=
ge
>> this?
>=20
> Wouldn't it be better to just change tin to be RFC compliant?

There is also a problem with your definition of "uncommon". I haven't
checked but I'm guessing the tabs are there for every mailing list run
by vger.kernel.org. Those are some of the highest volume mailing lists
that I know of. It can't be to hard to change tin to parse a tab or
space character.
