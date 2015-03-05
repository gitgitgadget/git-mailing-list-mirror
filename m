From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 0/3] protocol v2
Date: Thu, 5 Mar 2015 08:03:59 -0800
Message-ID: <CAGZ79kaC2LPPDOjnn6_5Rjm=tpkP3R2NF9CpkUA98bAMxCZmEg@mail.gmail.com>
References: <xmqqsidtoojh.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZE2+tCZgDzeTrQBn6JQv1OWJ7t_8j4kYMQgVaAbsnnxw@mail.gmail.com>
	<CACsJy8ASR-O-7tozw=p1Ek0ugct5EVZyWtxY_YA2nqcUV_+ECw@mail.gmail.com>
	<xmqqzj80l9c7.fsf@gitster.dls.corp.google.com>
	<xmqqioenhs4p.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY6B4BLvLVS-J50SqCz+t9uGd93WHxCYKmRU1Ey3qVg+A@mail.gmail.com>
	<CAPc5daXJ6s2oNvqSmtp5d-Dgm-EX6Mb8kY2nOLQVxAT-3wjAmQ@mail.gmail.com>
	<CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
	<xmqqioekawmb.fsf@gitster.dls.corp.google.com>
	<20150302092136.GA30278@lanh>
	<20150303103351.GA4922@lanh>
	<xmqqk2yy80mq.fsf@gitster.dls.corp.google.com>
	<CACsJy8B_r_0nP9NyKFBnr9bXgwjx8dJkSVkHbZw+Mxin_YpZZw@mail.gmail.com>
	<CAJo=hJtgda4ATtPeLWbhgDPiTm9h-gzBkpknxsOdRddueUgTbw@mail.gmail.com>
	<CACsJy8B=MN412dZYYc=NwpXHVz=Pxv+8wWMT7JNurVgqKrWn8A@mail.gmail.com>
	<CAJo=hJupr=07+r6z5s9RiT_v2LYtdioiVS=yNfMag+mKfH9FhA@mail.gmail.com>
	<CAGZ79ka0TFO6ZUd-vcxoDNAOyYPYdkLicmObTGhHb_hcDUm4-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:04:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTYFs-0006qQ-Qf
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbbCEQEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:04:04 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:42337 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757433AbbCEQEA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 11:04:00 -0500
Received: by igkb16 with SMTP id b16so46989083igk.1
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WwHsb5OMQExlfFQm1MdafFiPyimBRUtxDp3nDc2AJYc=;
        b=mRNnLZqg0AJ+CAMAM6dyDQ+le0/DmWo/qCFUisUEUVckVFEcLe8T9ChEtPgum6Bsiu
         L4XJIffgeglMfk+VJegytNAA2NIaD55nCwUf3hQraxlHDzP0dDwvdjSnodyPPHcFGbWi
         m+Qf1i343DusqamQEEOeTJ8nuUaOvFMOGfhZqck1pZGdV9IfCn7hutFkLXw8tXvp01I9
         Zhzivrah6W+dFu9bk5B7Nlv7XVw/85g7tUhPRFrdvTtsXbUigbCwac5XWeVkCNENFGRu
         NAbYj2/e2R+bef6tT4c+OHdFZQjSAa3YUy02AuvFXr50EijUK8YUBrC9GeebE5rHUf2R
         eGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WwHsb5OMQExlfFQm1MdafFiPyimBRUtxDp3nDc2AJYc=;
        b=kAdCRmQQeYZkWvJp64Vw+wMd6XVTUhp/q1i/Ek8Eaemdkv68Hr9NK2s2yHDVycB1zV
         1VKYfi4QdMbyoHH1qULR3CHKKDryjmch+3gAV0LOwo3G4saxRp/20KHz4evvaAH5OY0J
         lAxPqEd3fssh+tqt03RXa5NVdV9Qj8sUDC1eVFXhGu/YhHZBwDTwkQvNwuftZ0zfz7Yo
         tZHrpdNpsYKnRgLw1kOTWHaaoGulPQiyKNRVcxlIoVlUaTR1DRjneVNMPDWDBV0XRcd0
         QdK1oWHBf7oo5t45AwZu0SXi7Zeu/v5o5VFrXRjcwx4xvAMnoWdht+J3KqLtQNmVOZY0
         17cg==
X-Gm-Message-State: ALoCoQlOtlNwVVPekJNGruBuLqJvOcm4zZUWPbqzx0PIADOhvlJ0cbXezfSxbi0vuC27Es/dG4ve
X-Received: by 10.107.36.9 with SMTP id k9mr21386001iok.2.1425571439874; Thu,
 05 Mar 2015 08:03:59 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 5 Mar 2015 08:03:59 -0800 (PST)
In-Reply-To: <CAGZ79ka0TFO6ZUd-vcxoDNAOyYPYdkLicmObTGhHb_hcDUm4-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264843>

On Wed, Mar 4, 2015 at 5:03 PM, Stefan Beller <sbeller@google.com> wrote:
>
> If anyone wants to experiment with the data I gathered, I can make them
> available.
>

All data of `ls-remote` including the gathering script is found at

(112 kB .tar.xz)
https://drive.google.com/file/d/0B7E93UKgFAfjcHRvM1N2YjBfTzA/view?usp=sharing
(6.6MB in .zip)
https://drive.google.com/file/d/0B7E93UKgFAfjRko3WHhtUWZtTEU/view?usp=sharing

I also do have all the object files which are referenced in the
outputs of ls-remote, though sharing
them is a bit tough as I cannot just git push them (forced pushes make
some of the objects
unreachable, so my local gathering repo is explicitly configured to
not garbage collect), and these
are huge compared to just the output of ls-remote.
