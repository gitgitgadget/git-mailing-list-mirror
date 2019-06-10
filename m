Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB871F462
	for <e@80x24.org>; Mon, 10 Jun 2019 18:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbfFJSmL (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 14:42:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:45147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbfFJSmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 14:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560192115;
        bh=LzLdNJrbzUCDS7PCDwpFLmd0iw050qkVQJEPday38fg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=T+2B8rw+wFDI62cOXNgr1keh8ye6qAewVzl3gb3hXwpSaaXTDknCK3GxYXQ62XW9y
         9u+j82xYUgojpQsDf/uTxeP2hb4kwwqXqUOxYpVeU9eF+uUs+bUL5ifFfbJMz5TwFw
         yvH7x8bXF9nVXWRGLj/KPRsPjvZ5yksn36jbG4Pk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.215.76.8] ([46.142.197.184]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wpt-1gYn9u2281-012GvT; Mon, 10
 Jun 2019 20:41:55 +0200
Date:   Mon, 10 Jun 2019 20:42:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: RE: [ANNOUNCE] Git v2.22.0
In-Reply-To: <018b01d51f90$4d394c10$e7abe430$@nexbridge.com>
Message-ID: <nycvar.QRO.7.76.6.1906102032450.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <xmqq36klozfu.fsf@gitster-ct.c.googlers.com> <018b01d51f90$4d394c10$e7abe430$@nexbridge.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vJx6lKycpiLSsjCyZ30KQQ7UNmBkywfaza/lkxvDGoINNNcgmAL
 GeZ01Xaq9mnHKs8aBbDyUIxyyca2BNtLlUkpT23NNnA9dZXgKaCCip3ONKqH6TGTAhgeP3D
 xPFQ3b6LGsuPMdfj2idXPYlbmRgym3NKmOm+OGM5bE4Zfj7uz2b8SMvv/rgfqUppyEDM/Hq
 kzOrAcS8GOiF4uf6iZEdA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:97PPFUdxvRs=:hxIQKvvh3fkvLd28jWQ9JF
 fnIPnVE0hBkgzzk88p9KzFdy/1t3tkR/FXAMJp7MQ5PxEfuWH2dszPRdtK7u2TMFKOMc46TEW
 W1QH1dwQcOT+XcpqIQz4aOBgTZyRR9XUGISQ/x2Je9mV9nMpP9Ld5l79iHLuQppjPt7ilVwgT
 UoA0PrVYFKgrAuYl+ISjSdCGd3phy3VohzxEJ4XJnxgFKUPcEijr+R84SmcSSTM7jJ+nQdnjK
 YSbOs3LO0lbeoasnw+LgsOimtksfrX/NuVUFs0o6lGISNIZMQSJaVCgUP1dsy1nV01HghEgJV
 BwcCMVBGG41E7DbDiEziGDTHAJraIrdLmO5Av1gQ8R5AuRlAP2n2FEnWZ4FEkC8Kkh56revbR
 mCO2ooJNPNZhH86A2u5CPxVqhLEWHFGygiE4zZtSVFe88McH7JBAHrizBOMl4arOpLm16AHzz
 8kN2iVQ/nMytqC/fKfbcWYN1T6+TwW5+8g/hj7cf/mYDx5QdtBujpgde6ebJd7B6GYuMYQhRW
 rdaUitqufVMeFyt0cwoMry0PBhJtMEcLuiTtzXZZgO0eNDBMELcKb6lPBRI9Xp2SWhA6GnpVt
 +gsVjzOWvXmNpYQFwJZxw4yJdpxG8bqh00UGNdnG8LBPSZkIt/oG5eEdbBpeAvylmmZbB2WGe
 wNUGT5A0ST2rA9wes1uCHmkgz0l2CKBam7znlF5GcVLbOyVexMlwxQZK4Mz5VgeqyAtRfPnsQ
 t8OumBQkQ4POXaTyc4Gz2OlICMZVhy41o58gqqjye72/NDSUpHx2sGMU686BvY9sk/7ZRXRfA
 U9fC+K5NjD31Wwzpn8w/jaN8ToV6+4WxbfBGuBlcu3xkKThskIneg7As8jsGcsjKQYIFvPxMq
 vyUwKbcYND7XtcEFhWEc88pSr1xmJcJJBDlLo5wcwiwz7KBcaV/2evC63/WfP8UQfYetY1V5V
 fYa3vGm428YkEmKba0YIwGaxb15Own6vJdcHGxoQWaLejdj9r2i3Q
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Randall,

On Mon, 10 Jun 2019, Randall S. Becker wrote:

> On Friday, June 7, 2019 5:31 PM, Junio C Hamano wrote:
> > The latest feature release Git v2.22.0 is now available at the
> > usual places.  It is comprised of 745 non-merge commits since
> > v2.21.0, contributed by 74 people, 18 of which are new faces.
>
> Report from NonStop tests:
> t7519 subtest 25 still fails on first execution but not on second.

As mentioned previously: known issue. The patch to fix that is in `next`
(1aa850bc59 (Merge branch 'js/fsmonitor-unflake' into next, 2019-05-30).

> t9001 subtests 33, 82, 118, 119, 146 fail. We have no normal sendmail on=
 platform.

Maybe you should craft a patch series that adds a new prereq that verifies
that sendmail works, and contribute a patch that marks those test cases
with that prereq.

> t9020, t9600, t9601, t9602 all fail - we have no SVN. I may be able to
> handle exclusions for the next release.

The question is why they fail even if the correspondig prereq should have
triggered.

Another opportunity for you to contribute a patch series!

(By my analysis, you rank #277 in the `git shortlog -nse --no-merges`
statistics, and just 17 patches would improve your rank to #150 or
better...)

> So essentially, no change from previous releases other than t7519 being
> wonky. This is a pass. Thanks for all hard work from the team.

Yes, t7519 became "more wonky" as a consequence of a bug fix of mine that
made that particular bug a lot more prominent.

So prominent, in fact, that I contributed two patches that will improve my
rank ;-)

Ciao,
Johannes
