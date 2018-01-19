Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75FA01F404
	for <e@80x24.org>; Fri, 19 Jan 2018 18:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756128AbeASS0o (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:26:44 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:40014 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756193AbeASS0n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:26:43 -0500
Received: by mail-wm0-f54.google.com with SMTP id v123so5336384wmd.5
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mcquay-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QHfNyiwfcXwt4zM0bSLPHHh2yZCDKGLJgS+3SN4V0WI=;
        b=qScs7o+jmq+5ASPgh2Wdt7eplte56io+mfduRtk4MM1q60YryjFDaswqkkqSkxPgXT
         knamxRLQ88uWK8QKK9kHn7yBkGSJD9GA4LQC1d/mmZFLKjgXqcl7q4RCPQnhGFhGildu
         rICDJHXu8RIRdeeWrcFZTRJin06GnGsepXAVUZnmTg5+oyiubDdoPtnfW1W/vYqDr/g+
         TozA7F0VLoEZvQSM4LstxnGB67rstDf48riz7by3X2pb2dq8AcBi9BPBRIogrTWK1q9H
         RGBAhzbXHC+npkD7exo/xqnzaDm/SiitYFGZmhRoPMzZ3e8MjtbI0WQd3+yQWvsODlLY
         nW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHfNyiwfcXwt4zM0bSLPHHh2yZCDKGLJgS+3SN4V0WI=;
        b=nkDWfeEJnSJpal5QGCf82E9RPqF77YnNufdN3sC7kvCmuIk15KhBBRLp3AwGVSK5cM
         PiF2PyIvgoqMndUYESVigoW62Lt7USBHs7izb3Cq0cOZnp2cOC3EY+WzEZHbxM+jc9OU
         SsactGxxqRyUm6b6g6JhtfsOpPt+xeZR6PhOpXzk4+EnNlHW/3oDFy0KVsE1rHL1jYvT
         4TpnEFD+0l1n2+kwz9nyY7nPpku8WPSbzzFLXiySe4csRbHVFiTir9f4ekp+XQDIqtFq
         IbfXmmFDeY1717awQvi4vleZiOHLO7Mi5/F5xYp9kG+DG8Z0jFN2ui7S+ZPvang7i3Qr
         s7vw==
X-Gm-Message-State: AKwxytcBD541LYDmuV5S68UmvAkasvA0uLotXnJvZuXh9VHd7IVaFhQN
        d1CgHvgKWh3Hi2Onk/TAL+MC9w==
X-Google-Smtp-Source: ACJfBosjQATwmoyGtOCmgJrMqT0jPpr5+fZLUET83GaetoZyUP6xXO512BCZyCy7ag56BI6h2THrMw==
X-Received: by 10.80.177.67 with SMTP id l3mr13868953edd.267.1516386401698;
        Fri, 19 Jan 2018 10:26:41 -0800 (PST)
Received: from smm.local (ec2-54-153-88-228.us-west-1.compute.amazonaws.com. [54.153.88.228])
        by smtp.gmail.com with ESMTPSA id h1sm4199885edc.57.2018.01.19.10.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 10:26:40 -0800 (PST)
Date:   Fri, 19 Jan 2018 10:26:36 -0800
From:   "Stephen M. McQuay" <stephen@mcquay.me>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Segmentation fault on clone
Message-ID: <20180119182634.GB98561@smm.local>
References: <20180119180855.GA98561@smm.local>
 <20180119182204.GO1427@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20180119182204.GO1427@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 01:22:04PM -0500, Todd Zullinger wrote:
>This seems likely to be the same segfault as:
>
>https://public-inbox.org/git/CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0=
V6K-BA@mail.gmail.com/
>
>There's a patch in that thread.

I've verified that the patch fixes my case.

I'll back off to 2.15.x and wait for that (or similar) to land.

Thanks for the pointer,

--=20
Stephen

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEVnuBnnGQMCaGOsqiTkty9Hm6POUFAlpiOFoACgkQTkty9Hm6
POVftxAAtWncxncphH56ftH+MJck435GtXOobY6k6Ay9XDPCToejaw+XqE+srHZ8
R0oiJd14bbbA1OqPTU0P7JRIiyidnLnS+x9wY6mXnqj/OAbRq4chsCLJGQ6QtJ7C
ZGSCCGJzdd+e93yVm64Z9/JRw4G6lhmNLZpBz0x78L3/xvvQc+R8dc32X+dUMGJ0
OPG40hxlLHwjzEZ/VOHZZ+0Uh4+ztvkPYWmXhmtbf1WLqHrCxS8O5i4K4mHbf4wu
7WVd/wH76UPVzOMqx87inhX0978IVsWiEkJtsmX7DXqG1ssA/nRwjX0C3TfrUIOt
Uwi8fjfNTkTJIWsGsrCYB4Fy/F9ag9niQOz0g2DJDSMPqeRqRazLkYx0+5BQPp7a
0OueRWrLEMkb0fUCLD5jaXutWoTMro/kUXscisPEy7LTaXl55n0dKCzu14F1VbNv
kf4ibST+MDG3393ERszOOf4KpZHwSSMDVZo6DffpgX0F9czSwfh/Y2oI1+wJGxEH
8iryUUUPJomgKT0bsSzpdRxmFTqphZfiVMM+BRoQmnno+KbCNzJfjNw4T/pvA0lc
M/GC28K0B4cwNoTxkROc+x9dF2cd0aiyQHe8l1SGmVGhS2NUnJDBW2lSyCbSODCn
Gsu74kIDa4zXUJyf6MN2RR9aD9N2GC25I9yvP2+DiTAA82mIryQ=
=sMvQ
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
