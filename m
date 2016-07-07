Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 493EB2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 18:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbcGGSoh (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 14:44:37 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33748 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbcGGSoP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 14:44:15 -0400
Received: by mail-io0-f173.google.com with SMTP id t74so29725841ioi.0
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 11:44:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MLsejyCQjE77Oj7Wkep115VHpJy5t+opYaf3qUuPDTA=;
        b=w7Ys13X9mEoUdzX15/oFn9W9T7Y5nAMqpXNlMmI2ng7Z8PlpBy0r1dlUdt75tnuuWj
         vuE/G5ZkxcCF52gqM5+v2jchcKnlXsCQqjHw7ymJZ6I9Zm+mK4JpEQvouaVh8947J0Wu
         7l221/3R/L8M4p3DD1CLKyzwnRORy/gqLFsgqtezSsW0Fo9QrryD9cgIcO/Mn9aUolZx
         CYs+zer7cUt2LQIiBuBQk8XlNcS5btgqjuPZwJnl76Xdga1ot5mMG84cImxCrulzCm6q
         VzC6ufx9x8T3o2UFNhufA5vJMaTw45b6n0mEefTb2OW+eMzMHRASWDh8T8uhTs6ausKF
         RERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MLsejyCQjE77Oj7Wkep115VHpJy5t+opYaf3qUuPDTA=;
        b=Bi5iUiEdCnu04daQOysXyNUQGhdUm8eYgvbdlEIRIri8xFwVGsJcK53qG7Cq1vmgOi
         880/XVc6d7H0vVi3aTh0tuzOxOhAQkzw7v1IOBBYJDV9/vFZgBxwA4OPmW/I6T8cvEmn
         fjqXFqPcJYpIvQmChLOUPJhS81LVUNgub/AIrLH+TsJr6EOGKFjNjrOr/bBzUiS1i+u0
         dn02y0LOpCeZWkBbVo9xfSiE6M4Du18bEct5gColz1FZ93UTX227hBMHQJPnPmE4VQWD
         MpYZFs0KfCX6PmUcRgMZHvlj8hrgTROhTPqZwngkNUbRnvgLuFCa0SrpyFyeOlTXQYad
         qUAQ==
X-Gm-Message-State: ALyK8tJUW1KcXqYTa5gpSJvHCNHpkMdhxQEiSVi/iUFPZeI3AZlGFdw8T+ac1T3o3syjzA==
X-Received: by 10.107.148.79 with SMTP id w76mr4945707iod.47.1467917050584;
        Thu, 07 Jul 2016 11:44:10 -0700 (PDT)
Received: from gmail.com (c-73-51-186-156.hsd1.il.comcast.net. [73.51.186.156])
        by smtp.gmail.com with ESMTPSA id l185sm1217194itd.20.2016.07.07.11.44.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2016 11:44:10 -0700 (PDT)
Date:	Thu, 7 Jul 2016 13:44:08 -0500
From:	Erik Johnson <palehose@gmail.com>
To:	git@vger.kernel.org
Subject: git branch doesn't allow me to forcibly delete branch which was
 checked out in a now-deleted worktree dir
Message-ID: <20160707184408.GA1916@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

% git branch -D archive-extracted-xz
error: Cannot delete branch 'archive-extracted-xz' checked out at '/home/erik/git/salt/archive-extracted-xz'
% test -d /home/erik/git/salt/archive-extracted-xz || echo "directory doesn't exist"
directory doesn't exist
% git --version
git version 2.9.0

I know that I can just get rid of this error by pruning the worktrees,
but this still seems like incorrect behavior on the part of git branch.
It shouldn't be telling me that the branch is checked out in a directory
that does not exist, that is just factually incorrect.

--

-Erik

"For me, it is far better to grasp the universe as it really is than to
persist in delusion, however satisfying and reassuring."  --Carl Sagan


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAld+ovgACgkQXlWDxDeAjz8+PwCeJevUZDeg1c0skaNywCiVRVjS
CscAn24Qaa2GQKnZUgNZbZJML6KufnNU
=kTfb
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
