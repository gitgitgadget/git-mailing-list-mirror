Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0621FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 21:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbcHTVlo (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 17:41:44 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41710 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751147AbcHTVln (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 20 Aug 2016 17:41:43 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D4D1520383
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 17:41:41 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Sat, 20 Aug 2016 17:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=+qGtLutq0gSIkP9mElhcr2cyY34=; b=Wq/nW
        viIr7dQ8BWoKfgcsPbnPRvTpqgpZ0jUL3Bc0lqqJdyjkgk+C/dsKoj+W3Dj7F9UF
        KUbV63KocOMXUWfbRx+Av6JrBTUXqKw2HedPG3H4Vrqt5B4zLYK8yf+3pM0ZTr57
        axkze+oBzbOf/z16iBtKTy1s42dKmKlv1crQrg=
X-Sasl-enc: sTlmH+ukhe7EsQd+ph2c+OCCk3VD/pn3KD7cF1tF6QW6 1471729301
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89115F2D2B
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 17:41:41 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
        by ebox.rath.org (Postfix) with ESMTPS id 21C353925E6
        for <git@vger.kernel.org>; Sat, 20 Aug 2016 21:41:40 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
        id 6F537BFF6C; Sat, 20 Aug 2016 14:41:35 -0700 (PDT)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     git@vger.kernel.org
Subject: Most recent revision that contains a string
Mail-Copies-To: never
Mail-Followup-To: git@vger.kernel.org
Date:   Sat, 20 Aug 2016 14:41:35 -0700
Message-ID: <87d1l3ce40.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

What's the easiest way to find the most recent revision (of any file in
the repository, including those that have been deleted in the current
HEAD) that contains a given string?

I was hoping that "git grep" would do this (like in Mercurial), but as
far as I can tell it only greps through the working copy. Or is there a
trick that I'm missing?

Thanks,
-Nikolaus

--=20
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
