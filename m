Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9B22022D
	for <e@80x24.org>; Thu, 23 Feb 2017 15:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbdBWPuz (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 10:50:55 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36056 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbdBWPuy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 10:50:54 -0500
Received: by mail-qt0-f179.google.com with SMTP id r45so12718420qte.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 07:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=LtUqJSWGFWkExWIXnG4xyz3oHbulLr+MLBPAp+NZuYc=;
        b=zCGl6OoL0292D9H4bgpfg0+Vz4dLQcWD0H7k5rECtZUWVFZdMZ6vaCVB9bVN4RJDdU
         fqZN3vLIyLnOY4kV/klJ4UaZ9BKAACAJISMMai71Z37EaP9GPBdpmcsyPSFRiXW8eoZ5
         hH0WxLZhvMRWoVpb+jNTAM/GKeJX/B1s7okLo1Ki42EpGBpApTh3e5eHfzLjmRWBqIA4
         sndmZhVNQ9ZnghzRo5nB34WESdoC7vMrgSbPhmOn04i6aw5g6pV50TVkCMinC3KPt0fy
         nr9Zqv2bogoeBY7Qvg8TaSAZWcM5sRyHKQAT8Z/DecA2G81d3/sYvnb1A11HWwqDGWtH
         R+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=LtUqJSWGFWkExWIXnG4xyz3oHbulLr+MLBPAp+NZuYc=;
        b=JknpnSHLdBjmHn6o0hZ+s2z4/Ga656WyAG9Rw/mxJGNIsyuFf8PtznxW/hIeYSJouF
         b1mcgrGgKFCD0yn0O2PXlb5Pt3BwMUquH4bp22HpPcNWD04zwEzQGHphGw1J/9r7xeGC
         Lnb6EbbbMQWiH2m9KSHz80Hn77LjnakHs8720w3sVlSu7vdiCq8qFmixspE3r3Y0y9ha
         0/I6jFhUMCOjyIqSq/3NYZgkxMNOgdu9a080AWMXn9NtoDWqu+hnaMiNBs2eGIM6lrtY
         K0zd3h2Ph9GzuSZxwFIqgGSMPmItQ7R8T1ftiibcEQXlWKMm7vuW1AiveE3lHRhdri0T
         EWwA==
X-Gm-Message-State: AMke39n2tzluP7sBZbtl3HnSA/rLowsPTYpYAu0asl0d0MOtObgGM04uZW4PBvb04tdbx3pa
X-Received: by 10.200.48.54 with SMTP id f51mr17779943qte.164.1487865048349;
        Thu, 23 Feb 2017 07:50:48 -0800 (PST)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-06.NATPOOL.NYU.EDU. [216.165.95.77])
        by smtp.gmail.com with ESMTPSA id h56sm2934911qte.24.2017.02.23.07.50.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 07:50:47 -0800 (PST)
Date:   Thu, 23 Feb 2017 10:50:47 -0500
From:   Santiago Torres <santiago@nyu.edu>
To:     Git <git@vger.kernel.org>
Subject: SHAttered (the first practical SHA1 attack)
Message-ID: <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b2puae6e3ukpczbg"
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--b2puae6e3ukpczbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

I ran into this website presenting the "first practical attack on
sha1"[1]. I don't recall seeing this on the ML, so I'm sharing this just
in case. I know there are proposals to move out of sha1 already. I
wonder if this affects the timeline for their adoption?

Thanks,
-Santiago.

[1] https://shattered.io/

--b2puae6e3ukpczbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkDurc2QOttZVM+/zRo8SLOgWIpUFAlivBNYACgkQRo8SLOgW
IpXgcg//fakThyCuzqv3miO+t/jzyKCYY+lFHHzsyTrq/sZMljsdECpWZJGD3Lj+
JJpms+ra0lvj9JTBMLxo7Y3i3NjVuxnUWiBeu4NO3aqMec0Y9mw2C3HlT6vR+be9
pJDaqmLYA1L10GG5E8urdELYeFzGXYd8mieDgPtbadSdwa1qV7G4zEskA+NjOMwm
CVxMEm20ZNLRorybHePBnl9hT1hL7EM689JZlX2f5zftcVGszRdOMWs3bzPvQCm9
m1A9dU+HL04G6IXCH53pw5QSXEwPeIg5j1bSq13WKzd67faB2ALEDMM2nhklGWBs
OJP5pF1kcR7Un2vWRx1tl9ENjFgdkfxWCi3cOgHOhVtChCKZJaDMuvo/PXoHe9Xk
FvbCj3G/WHrBtfQlqM2BC3VPbIkQh+Dq6i9A18AAM43QzoOoL7WYjb9l2g8F7lHl
TAxJF5GdXWy22F0uZMVJ0geBRprDCcdOhSf/zENBUJsrxo7uwkOqtwjs4NQia7Cn
igrX/GTQ9vlbEuHB6f0mq6Pp7B1IyonIPsmTxc0mkBv4kuMfVcvCfb1kb078M5Hv
+xBLj8Kvllat15GwrjNh6Z4j5FjkDoCm6EjVw0gAUghEYfmexHEiA0J8qq0vzQok
+24v1fWJQYOJIqXZhP0O0Tn8kx2S8ieBAz0nlqqLxEiWm3R03dQ=
=UVrd
-----END PGP SIGNATURE-----

--b2puae6e3ukpczbg--
