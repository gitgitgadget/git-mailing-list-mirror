Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED98820401
	for <e@80x24.org>; Tue, 20 Jun 2017 09:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbdFTJcU (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 05:32:20 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38488 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdFTJcN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 05:32:13 -0400
Received: by mail-wm0-f51.google.com with SMTP id u195so14433169wmd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 02:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uLB+1I3e+YdtjVN8yhs2tBjhHSM9zgfMgeHmuATaidc=;
        b=HhuVAyzpc31nxNCMgMEDiwlUXSTjF466wMX0VOPymCx3rrtHQyNtzg4QkLiOIoE6h/
         QUWXkBOb5F+VjPkeQTFz9cOhqqji/5K+fC95MqJGXhkyMnMQTLcndVcf8kP4/lFwQFgs
         QMPcNUgcUO4PjReSq3gPO1oQGiu+4lAYsaeypgfQWjLlivYCwwsGcS22wGCMk8Nfo9PN
         P3N1WIRE/pfe2y351bxkxC+7MhweISIYnSOaJLOUw+sz5sMoy9NyR6Hap7xVSJifGLzF
         YgR/ILa0rb0jPN/mwZQHWXSq4yx+mxNvAKxDb1xuCrDmUy8N11052ad0VNGq+mQ56GFy
         2FwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uLB+1I3e+YdtjVN8yhs2tBjhHSM9zgfMgeHmuATaidc=;
        b=aakpOxqlh05gjffJ1NgIYSFRcZyAZYzBjkROSooi6SbRinSTq/MF8PArOWnVPkzdsc
         W0vYtT4ABe5q9M/rrKwdgBPwdugGJargVf9fMlHwQiZOO2DaU+ETBXpWYVw7MhGKZnMB
         9IgX365+dMuFiwfzAzQOaqcO33dKNdslwiyoQRpztFkhXOu6nZhpTudXyGWa762Ijbb0
         tdzHYtXRx/4r13WJKd3JDwSq9avf+0BSKbF3Ll5TVIhOF+xHQyuwdsY85ZKaQvugJHAQ
         5o3rXIspZtxbagPTOspTLGZdJyCEud92liZTcOrCpCbxZFCI5t7MvZc7biNkt8D4aU+q
         aoeg==
X-Gm-Message-State: AKS2vOwzr1+0G/8PFfpDQAvl2l/y5+Ho4hNAxzrSbfjYgmQ8jy5usOD/
        IXnu5ITfit72XOTMEPQ=
X-Received: by 10.28.66.196 with SMTP id k65mr1876024wmi.55.1497951132339;
        Tue, 20 Jun 2017 02:32:12 -0700 (PDT)
Received: from farfmmsj12.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id g7sm10283127wrb.52.2017.06.20.02.32.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 02:32:11 -0700 (PDT)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Transform log message during migration svn -> git (using git-svn)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <8ce2bf074fcf4d6181a29eb3e7fff132@GTLBML3EX0005.bagmail.net>
Date:   Tue, 20 Jun 2017 11:32:08 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAA4B747-FA00-4A3B-88CD-AF8EBE1F8586@gmail.com>
References: <8ce2bf074fcf4d6181a29eb3e7fff132@GTLBML3EX0005.bagmail.net>
To:     paul.mattke@s4m.com
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 20 Jun 2017, at 09:32, paul.mattke@s4m.com wrote:
>=20
> Hi there,
>=20
> this is actually not really a bug report, but much more a feature =
request
> (if I did not oversee an already existing feature like this):
>=20
> We want to migrate our SVN repository to GIT and will be using git-svn =
for
> that of course. Currently in SVN, all our commit log messages start =
either
> with:
>=20
> 123456 (a number, representing the Bug Id in our old legacy bug =
tracker)
>=20
> or
>=20
> T123456 (a number, but prefixed with T, referring a TFS item in this =
case)
>=20
> During conversion to GIT, we want to replace the T in such log =
messages with
> a #, so commits, referring a TFS item will start with #123456 in the =
future.
> We don=92t care about log messages which do not start with a T, only =
the
> TXXXXXX messages need to be transformed here.
>=20
> I guess an operation like this is currently not possible with git-svn, =
isn=92t
> it? So it would be nice, if a feature could be implemented that gives =
the
> user the possibility to specify some kind of script file for example, =
which
> transforms the log message in any way we want it.

You can migrate your repo from SVN to Git as is. Afterwards you can
fix up the commit messages with the following command:

git filter-branch -f --msg-filter 'perl -lape "s/^T(\d+)/#\$1/"'

(this might take a while on a large repo)

- Lars=
