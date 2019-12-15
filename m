Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CCDC43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 17:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728C920726
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 17:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfLORfu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 15 Dec 2019 12:35:50 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:43826 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbfLORfu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Dec 2019 12:35:50 -0500
Received: from app10-neu.ox.hosteurope.de ([92.51.170.144]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1igXo4-0007sU-Jr; Sun, 15 Dec 2019 18:35:48 +0100
Date:   Sun, 15 Dec 2019 18:35:48 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, ralf.thielow@gmail.com
Message-ID: <2099929548.270607.1576431348524@ox.hosteurope.de>
In-Reply-To: <20191213201522.GM6527@szeder.dev>
References: <492636883.190386.1576264842701@ox.hosteurope.de>
 <20191213201522.GM6527@szeder.dev>
Subject: german language fix: Generierung vs. Generation [was: Re: Parallel
 fetch and commit graph writing results in locking failure (even on linux)]
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev64
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1576431349;98f88a19;
X-HE-SMSGID: 1igXo4-0007sU-Jr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> SZEDER Gábor <szeder.dev@gmail.com> hat am 13. Dezember 2019 um 21:15 geschrieben:
> 
> 
> On Fri, Dec 13, 2019 at 08:20:42PM +0100, Thomas Braun wrote:
> > Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
> > 
> > (Sorry for the german text, this is not easily reproducible.)
> 
> It's unrelated to your issue, and I'm not a native German or English
> speaker... but that translation doesn't look quite right to me.
> 
> The original is:
> 
>   _("Computing commit graph generation numbers"),
> 
> where the word "generation" isn't used in the sense of "creation"
> (erzeugen, generieren), but rather as in "generation gap" or "my
> parents are one generation older than me".  So I don't think that
> "Generierung..." is the right word to use here, but perhaps
> "Generationsnummer".
> 
> But who am I to argue about German software ranslation?! :)

Your hunch is right I would say (not that it matters much but I'm a native speaker).

So how about the following patch (CC'ing the original translator)

commit 724bf68da28b75e04a9fda34b08e95259ade9ec3 (HEAD -> master)
Author: Thomas Braun <thomas.braun@virtuell-zuhause.de>
Date:   Sun Dec 15 18:28:42 2019 +0100

    lang de: Reword generation numbers
    
    The english term generation is here not used in the sense of "to
    generate" but in the sense of "generations of beings".
    
    This corrects the initial translation from cf4c0c25 (l10n: update German
    translation, 2018-12-06).
    
    Fixed-by: "SZEDER Gábor" <szeder.dev@gmail.com>

diff --git a/po/de.po b/po/de.po
index 066326a687..773e361f6f 100644
--- a/po/de.po
+++ b/po/de.po
@@ -1535,7 +1535,7 @@ msgstr "Lösche Commit-Markierungen in Commit-Graph"
 
 #: commit-graph.c:1104
 msgid "Computing commit graph generation numbers"
-msgstr "Commit-Graph Generierungsnummern berechnen"
+msgstr "Commit-Graph Generationsnummern berechnen"
 
 #: commit-graph.c:1179
 #, c-format
