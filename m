Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC3541FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 16:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751631AbdC0Qvh (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 12:51:37 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdC0Qvf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 12:51:35 -0400
Received: from localhost ([178.11.46.195]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MC1IG-1d1NWx3flo-008q0C; Mon, 27 Mar 2017 18:50:08 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH v2 0/2] describe: localize debug output
Date:   Mon, 27 Mar 2017 18:50:04 +0200
Message-Id: <cover.1490633145.git.git@grubix.eu>
X-Mailer: git-send-email 2.12.2.584.g7becbf139a
In-Reply-To: <xmqqpohf7opl.fsf@gitster.mtv.corp.google.com>
References: <xmqqpohf7opl.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:jpJ24FVOCjDvZco72tT5G1le93jLBwv6a51xogWFSHhkSqKdXDE
 BAWKrG76nDXZiZKhqhSZNdO4m9cOJlFPHZUYHBWuqUIgWy7gKmTc5gFYas0M5IR9ppJSYc5
 XY9Oj0qkDQ3x34Z8qYhbY1GzEQayAUYkp84W72GJlaLR79Z0Oe6ToyPy48Yx4K2JXJBaVYr
 KGyyEij3W3ZRPezMGReAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tlk0IlFgccA=:XBvqE4mM0/a0UZdCNSCtS1
 Z17SWQo0JJwHyz8fvFk8pK1KGlrhGh3PsV8h6y//xZFSC3S1tCNLtuuW35lbCxZebjJvekNuG
 CjNnIOVC5N19iJahx1m+9VgcdSWBhy+Jgqjxl5U79JbrMhqQtYr6wteZPjwB1K46AyGSQHG3g
 DS+SCKwU9AmEFQvubvPFfygKsBOFFreZUDeDIIQjSxtanGYma6Vj+5ciDXvgPOOzilBXZSb/q
 V9H92dMkPrN2QgKG0O2vDAPu7pFo79EMRJneKimrRe1kmmMjjwqp10Jdcqvp/MpzlWuNThbmH
 B3nmuoq5MlR6k2hggpdScRbLcXiT+ikHHsXc0yDCEEY6citVL3+I0iITL+8j5nQW/+3pkJql2
 FCKE3LPP9OxerwBz5HShYXjEQa6TTHvOnSk4FEXBxYFfftzbYyy6EozPI4b/JA7ByXSxSiyYn
 /oWBzybjki7cttnzZvow13Ty8TUjn72ugBexgjz72NcXBNYRR0Y/kxDMLowjeRFXnPD/gdsKE
 /4MHIF37E5tdkKA/Ovp9/CWMAivFdg6LqhFVigCeLUXIYl6M5ZNIJv+xCMZqkyWSrXtZ1JlBH
 ra6hpGLObJVPBBd7QVPV1t0hpplyLppxk7Y8/RnGzeZykWbSeeRTN7bmHoBVfX+MnQtffk4xN
 kFai1V/jN+Jsv5Bo8CewmOFppEU8bHEc0bAFsrEpCiMdn2IxtbyuLwMfjAEVFYI9ERQE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 computes the width for the localized output dynamically.
In fact, it might overcalculated a bit depending on the encoding,
but this does not do any harm.

Michael J Gruber (2):
  describe: localize debug output fully
  l10n: de: translate describe debug terms

 builtin/describe.c | 15 ++++++++++++---
 po/de.po           | 14 +++++++++++++-
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.12.2.584.g7becbf139a

