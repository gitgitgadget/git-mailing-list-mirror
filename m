Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657DB1F829
	for <e@80x24.org>; Tue,  2 May 2017 11:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbdEBLyF convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 2 May 2017 07:54:05 -0400
Received: from mail.gea.fr ([89.225.222.218]:36019 "EHLO mail.gea.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdEBLyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 07:54:04 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 May 2017 07:54:04 EDT
Received: from SVGEA-EMAIL.gea.fr ([2002:8526:28::8526:28]) by
 SVGEA-EMAIL.gea.fr ([2002:8526:28::8526:28]) with mapi id 14.01.0438.000;
 Tue, 2 May 2017 13:48:36 +0200
From:   Delanoe Eric <e.delanoe@gea.fr>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Could GIT manage revision headers embedded in code ?
Thread-Topic: Could GIT manage revision headers embedded in code ?
Thread-Index: AdLDNoNKrV9VmwHgQBaB7bZ4RuR4nA==
Date:   Tue, 2 May 2017 11:48:35 +0000
Message-ID: <135C7A92C7D64E488B830ADC2970C70132AE6407@SVGEA-EMAIL.gea.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [133.38.10.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

We need a great deal of traceability for our source, made of many scripts in interpreted languages, spread in many "independent" modules, as far as can be ;-).
In particular, somebody troubleshooting a script in production should be able to know exactly the revision or commit ID (or tag label) of a given file, and its location in the GIT source directory tree.

Our old CVS... let's say it was its only advantage... was doing this with keywords embedded in code comments: $Header$, $Id$, $Rev$, $File$ etc... When a file was committed, its $Header$ keyword was expanded into a rich piece of "version" information like '' $Header: /cvsstore/SourcesOracle/Install/COMMUN/CST.sql,v 1.69.2.10 2017/04/14 09:38:48 edelanoe $".

Could this kind of "keyword expansion" feature be added into GIT ?
Focusing on the goal: enable the identification of a file and its revision(*) inside the committed code itself.
(*) the "revision" information or a commit ID. The tag(s) attached at commit time would be less reliable, as a tag can be moved between revisions.

Thank you in advance for any answer,
Best regards,
E.Delanoë

Grenobloise d'Electronique et d'Automatismes
Inovallée - 12, Chemin de Malacher
38243 MEYLAN CEDEX 
FRANCE
