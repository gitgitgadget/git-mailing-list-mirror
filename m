Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1C7207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 14:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbcJCOtH (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 10:49:07 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36107 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbcJCOtG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 10:49:06 -0400
Received: by mail-qt0-f179.google.com with SMTP id m5so24260414qtb.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 07:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/sJDjCyrogo95vDrvsV4HpQSQzEN/kKOv548yWgE5ak=;
        b=kJKJqP/HFNbGSaFRJgJpGdY8Um+IycDCRao5ViR+MF8E66kMbIqjiRJXG4A8cKevco
         g6cfPNCqmsmeRpXvOr1eFjBXH2Ft0m1RlFp/UzPZcwuqS2OKMTM5q9dAlWW59/d/ooVl
         jSZPLx7PsNTxtjN5YXsgsgP56hlSCB/FkMfRzYZEDevp80wBFpOp+Kx9RbhZ36fuSYYa
         MieYwxHkGh9hqZ8WeeeoMraQBH+j8anRtELJiCi4Ri6Z9QK8GkOfVCUhSLI6+ysO2y8u
         +dZLwN37SAbll+7RoWzY/y6pEs9bnjyDO/o+sEYx4aMtSDEhDCkwooSKA34Lte1Vuc91
         ILmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/sJDjCyrogo95vDrvsV4HpQSQzEN/kKOv548yWgE5ak=;
        b=l1q+0stKkssVfzfAU2z4o/vYHxewHIIQudRzMIV+EOKfAQkCnpD2GaMW+q/An0ndrL
         U7lzYFmdZeiriYQa2xfYck4Ah2/GV93dDPApdRDtfAF9r8yhqkQOX7ad9cbv+zxP8fsu
         aw3Ck4mnWixQ/FNSXFQDjhi9RqwCVz9iwmOC0x5X3ZQNk9/es4u5xj+7qGI9Dozz3eBR
         lYJVjwGmU97/WPgenG/rbR+Ud7SCyz0MaIlZSmKtdoIrkjozUA0d5a8gleeP6uvZRXvv
         x+waJskSR90QxDMLqLh2pEp0XSmZgHZSucfHG5LTXky+i2Ubp8TNO3k6atI2ZkijQslj
         dn7w==
X-Gm-Message-State: AA6/9Rm7O6sHv1dNQNXLT+IJDCkOffDxX597M/HtrqfrAekmRaQcFxvxX9hsUiLMbC27G3Nv
X-Received: by 10.200.36.66 with SMTP id d2mr21241014qtd.34.1475506144416;
        Mon, 03 Oct 2016 07:49:04 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-08.NATPOOL.NYU.EDU. [216.165.95.79])
        by smtp.gmail.com with ESMTPSA id s23sm17240251qka.10.2016.10.03.07.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2016 07:49:03 -0700 (PDT)
Date:   Mon, 3 Oct 2016 10:49:03 -0400
From:   Santiago Torres <santiago@nyu.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v3 0/5] Add --format to tag verification
Message-ID: <20161003144901.4yainza537g5bujz@LykOS.localdomain>
References: <20160930221806.3398-1-santiago@nyu.edu>
 <xmqqlgy97ys0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g33plddxxttvqqh4"
Content-Disposition: inline
In-Reply-To: <xmqqlgy97ys0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--g33plddxxttvqqh4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Junio.=20
> I however notice that there is no new tests to protect these two new
> features from future breakages.  Perhaps you want to add some in
> [6/5]?

I'll be working on this. I spent some time looking around for example
tests for format. Are there any that I should pay special attention to?
(I'm looking at t7004 mostly right now).

Thanks!
-Santiago.

--g33plddxxttvqqh4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX8m/dAAoJEEaPEizoFiKVDJsQAM1DKRlZhnDUp2uAwpoKxnsh
PRXFvi6RA9whc41lsawqpDxNwyzx4ZwMXuVXivxi0PaKBjd/C5BPbUAcLT6Ox6CA
y1ArIOQO2kK7R304ryPAyXYci+wsl1A2KJYlCTwR+txTPh04TV+YbSPCWH1e7G21
XMlTEgWrm0fAaoCg4yryS8pG7+cNpuBzUFpIT2hBkg1P6aAV/DJxGdklE7p7Ens7
rI1BrMYz2FXqODMG7D1BNCk3jhgad+IKVFjOlvSH3MZvcRCfvoMVBnhhS98yPdCd
0aj1yzvDrCnkNKR5ZDv6+3/X9Y9XtoSEFNRnyy03Cz5dFjtsOClrnDsGeLbnTCic
WJP19xUoRbvOLTDYJicH8hsvaBUQBsxv3rBvsJ2sRfNGiRWtv+a8frq4K/vL7yN+
V5c9PE+WYuGoEvNTuLjUdj1/VVs7b6iJjqpuxSV/HMtlZe7Q1PwqfIT/KbsJN0e6
msqydh1jlAHz7nXnjkKtX9IxhCPM2yhCMx4T0wbivpFiCHpD5qoSe+BmVU9/JKKd
aIdePoWA3y4GNOEMAQtbtljqhnwxGXPzURw6pTBEyKdcap2oQ6D0y+aWDvuHMn33
1MmWUMKdxXWGuekSXeaZ2KBKx2z5AttJcEcldZAwZs/ZysNfIYREGd9TaJ/A9Ew6
7xEGYCp7dHnOWwULk6QJ
=ahXl
-----END PGP SIGNATURE-----

--g33plddxxttvqqh4--
