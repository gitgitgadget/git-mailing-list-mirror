X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: warning merge message
Date: Wed, 20 Dec 2006 13:34:44 -0800 (PST)
Message-ID: <100025.61738.qm@web31810.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 20 Dec 2006 21:35:00 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=h7z8G3J56XU9CUbmpP0a5hwPDoWSkiicaJtLlyTrTOhkLnPtAnxQbMmsQ+8jSxyR+c9dko3UKsfRsB7JrDTM0lq3qPJ2rMiFU9AW4G0u4ECeeKWWBN7pCpLx3nr0CQJ06cZQo12zEFSD2mUFayvwrqH7AKotVruAGdAuHQGXP2A=;
X-YMail-OSG: UHg9hzsVM1k7BmMyIjEiWgZ5DfnjGaFK1Rpb7qY2KZmmj2Qgot3brEiRaVWABjjoMpigxxDWqTPeRTsvPocGT_D0vq8t8ZrI.kbB2VsJ8yQSYVWIRbxmaK_gICEE00HEr52F3GBGOQ27JUk-
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34964>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx95O-0000tB-9n for gcvg-git@gmane.org; Wed, 20 Dec
 2006 22:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030357AbWLTVer (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 16:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWLTVer
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 16:34:47 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:29721 "HELO
 web31810.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 SMTP id S1030357AbWLTVep (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec
 2006 16:34:45 -0500
Received: (qmail 61883 invoked by uid 60001); 20 Dec 2006 21:34:45 -0000
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Wed,
 20 Dec 2006 13:34:44 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Furthermore, isn't the local origin fast forwarded to the
remote master, and then the local origin merged into the
local master and then the master checked out (presumably
the user hasn't edited contents of their master branch).

This "warning" message is confusing and the branch.<branch>.merge
config option poorly documented.

Can someone clarify these things to me please?

Thanks,
    Luben
