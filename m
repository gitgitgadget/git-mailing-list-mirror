From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Thu, 10 Mar 2016 17:56:12 +0700
Message-ID: <CACsJy8A8ZUpsc+=65u8Rg7jksCFM1RYh0fvWNS99QTmm01_ktg@mail.gmail.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
 <20160304055117.GB26609@ikke.info> <1457071957.2027843.539286050.10CF8D0A@webmail.messagingengine.com>
 <20160304115634.GC26609@ikke.info> <CACsJy8AN7xxFuVX4c6aR_RdDiuDRPjqbXS8Y2+xD4pV8G2onfg@mail.gmail.com>
 <xmqq4mcm17b4.fsf@gitster.mtv.corp.google.com> <CACsJy8BZm9pFdR+Njst7qZ1UnHUL9XpigM5pW+CLEicOc7ra8g@mail.gmail.com>
 <xmqqlh5ungct.fsf@gitster.mtv.corp.google.com> <xmqq8u1tmr6l.fsf@gitster.mtv.corp.google.com>
 <CACsJy8C5r2f76p3oq5oX_1P5Vqt9qd7TAafuKxJ=Y8baELbJog@mail.gmail.com>
 <xmqqbn6olu1w.fsf@gitster.mtv.corp.google.com> <CACsJy8AUs-DAo-GceO9ND9RPVeDOfm_UM4ZuaeNWDwBVMu+dnQ@mail.gmail.com>
 <xmqqk2lbil7k.fsf@gitster.mtv.corp.google.com> <CACsJy8D=OjLBN-EXyKM4NnGhSGftYX+RAaR9fg8ML3QWAAb+iQ@mail.gmail.com>
 <xmqqd1r3f9rc.fsf@gitster.mtv.corp.google.com> <xmqq60wvf8qm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>, Charles Strahan <charles@cstrahan.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 11:56:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adyGv-0005fA-RH
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 11:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965623AbcCJK4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 05:56:46 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33306 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965615AbcCJK4o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 05:56:44 -0500
Received: by mail-lb0-f179.google.com with SMTP id k15so107402236lbg.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 02:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kZ8yXSUYq9poNSKVr+7PUwYpf8yaPG3/U3yk64QvAls=;
        b=xmPSi0OoaKqMhy2Um9baqrnvvmKjQ8ioc7nVpsI91HY5teSBf13xg4jjxk1ZrDaoNW
         Ju3R9EDNqcObJ10Z12vdMmpnfzgpx1qU0hJkKBCvGp5sX41LS0ccVrYlKfdrqRtlcmJd
         BPOPHtAQqYd7nSacfjSEDJAWK/EWZBOfsNp8Mm49V9ebX1U2Fzu9+XIEL7m1P+/DyXqy
         O1cqv2IsGu83GQxNa+N+C5fboQ0/VVf2OnqqKsTpNXn14vm43aW7rjVd+bGI66jKmaR6
         XbHD/CVM3e+BKWFe5DFee5XUeWXvaC2uzkJqkC5Tto8ka8m9kQtZvgGzn7/tuQs8DPyX
         ca5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kZ8yXSUYq9poNSKVr+7PUwYpf8yaPG3/U3yk64QvAls=;
        b=IkKQ9nI3d0kuU4jH67RSP2h1wTtpsdvZDUjYfIlk/CxbJnjbUcIJO4bnhDOVdazFlC
         No9Zz8P0B7Awttw39gtc+7+4zs5iCHl1yQlq7x3Veqx0UTAozZl9bcyXfj2lO1N3wtWs
         CGr6VRCYjRwastAOcyzpAmCjd/CMplGG/nkLdPbzHF4+13Wwm9NZr+2p9NmoYj+kRdsO
         p4fGcvTldFP4otPsSteACWGpEJZyprthJjASNlVkZQ0JJGPXy8GluR72Xp5I12Fx08PM
         WoV6igbhEj8cc3LBbRSNG+JgoVmDLbIVhzPoHkmmZkACRwkIMvsotGL1n+vEpvOs+4hm
         sglw==
X-Gm-Message-State: AD7BkJKw5rPc8W9EWKhMoVg2gCiNdDf3no2lmDdxtnPb5+9nrAb6KfK8HDnbX25HAe/E5/g6DxsHviUoBnNm8Q==
X-Received: by 10.25.211.75 with SMTP id k72mr950835lfg.45.1457607402435; Thu,
 10 Mar 2016 02:56:42 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 02:56:12 -0800 (PST)
In-Reply-To: <xmqq60wvf8qm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288611>

On Thu, Mar 10, 2016 at 7:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> In any case, back to "on topic" part again; I couldn't come up with
> a better rewrite using named rules (partly because you need to
> clearly define each rule before referring them, and some of the
> rules are temporary workarounds for the 2.8 regression that will
> hopefully disappear in near future).  I think you understand the bug
> and the limitation of the current code a lot better than I do, so if
> you can please send a final version of the documentation update in
> the coming 18 hours (I have an option of using what is already
> queued on 'pu' as a fall-back-good-enough version but I want to keep
> the last-resort option as that--if I know a potential source of a
> better version, I'd choose to ask first ;-).

I'm never good with words, especially in a rush. Let's merge yours.
I'll fix the bug and update gitignore.txt in one go.
-- 
Duy
