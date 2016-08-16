Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125361F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbcHPQZO (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:25:14 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34474 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751427AbcHPQZN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2016 12:25:13 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 5247E206D7
	for <git@vger.kernel.org>; Tue, 16 Aug 2016 12:25:12 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Tue, 16 Aug 2016 12:25:12 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=ByYkUuvtqjnmeL0d/uczy9egAS0=; b=QY+9Y
	qohtGJqHIiKjUYN6cKrxgPPgIcVb9vbxJlv1/27gwek0PMxN2hwedw/9TgNrKspH
	yIYLw2hWUlwN7OZgJVqwgNxIApoMkfGnvahZiBFI2kIjOUI9gK5N9ZMk3eMF3Sjj
	86OWIlN9gcRhhwMvoeAa4NxfBW5E0UEMEFmZKI=
X-Sasl-enc: KZNrl3a/PQq6cpbYV/PWMPzB52B4QFsjL4kgf0zWKq6v 1471364712
Received: from ebox.rath.org (ebox.rath.org [45.79.69.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id F3537F2D2C
	for <git@vger.kernel.org>; Tue, 16 Aug 2016 12:25:11 -0400 (EDT)
Received: from thinkpad.rath.org (thinkpad [192.168.12.2])
	by ebox.rath.org (Postfix) with ESMTPS id 29BF23886AC
	for <git@vger.kernel.org>; Tue, 16 Aug 2016 16:25:11 +0000 (UTC)
Received: by thinkpad.rath.org (Postfix, from userid 1000)
	id C635ABFF6C; Tue, 16 Aug 2016 09:25:10 -0700 (PDT)
From:	Nikolaus Rath <Nikolaus@rath.org>
To:	git@vger.kernel.org
Subject: Working with zip files
Mail-Copies-To:	never
Mail-Followup-To: git@vger.kernel.org
Date:	Tue, 16 Aug 2016 09:25:10 -0700
Message-ID: <87y43wwujd.fsf@thinkpad.rath.org>
User-Agent: Gnus/5.130014 (Ma Gnus v0.14) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

I would like to store Simulink models in a Git
repository. Unfortunately, the file format is binary. But luckily, the
binary format happens to be a zipfile containing nicely formatted XML
files.

Is there a way to teach Git to take advantage of this when storing,
diff-ing and merging these files?

Best,
-Nikolaus

--=20
GPG encrypted emails preferred. Key id: 0xD113FCAC3C4E599F
Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
