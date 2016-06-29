Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A978C20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 19:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbcF2TsV (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 15:48:21 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38359 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcF2TsR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 15:48:17 -0400
Received: by mail-wm0-f48.google.com with SMTP id r201so88589947wme.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2016 12:48:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=5KxWDgNeOgNnMxNyyZ7Vkg8JecF3nM6nS/PTWZJ8cTY=;
        b=df9u1KSX5xzmZh/6qiz/e86rWA+0QnFGJB6TnuRgRjcyEXZKiye4VZ67C2TsUoRokn
         9vztEJfgHWsODNn/WYlwdKiaHZI/6mkfDM7We3LCGdHAfme0ci0gq6itOAfMlKZxoqsG
         1G+a0m5D/RNvz863fJXp8RpphzL/LLKqrJE3Jl9Wo4rL4RAgkL+89SciC64VXLdpiD45
         dUZI4y+0mett1CYFgG/U2glqA+l6NZoHFLBbeettPjLOJyv1x9AWpgFfWL+6qbT8voPJ
         7C5FWzySgaYvTjC0YfZXVR+mp04IUjDSTr2tc0ZZxApRVeCije1Dwq9SoylBGhxkIAVf
         Lp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=5KxWDgNeOgNnMxNyyZ7Vkg8JecF3nM6nS/PTWZJ8cTY=;
        b=OG3xzeV78n9jjRv3CovYN7zm1ejljNFjf6d4BiTNJ3xtqgU7PXzD+AjjXtTQoqpwZR
         +coeMu6L1uDXYcKr5VzFRhPYmBbc5O5qMSwynhHRCcnT8Nc/WkzzdRhQw/WcCY+DcgwC
         2DcbShxILhd94jmxUAMmh+bpoHxsnbUxVURkEy3y8UeVPZUqBGhgOBwyv1iMzrws2F62
         vQixUsRkYYBLN/3NfzhnNbbXk2rljSz+BlHQwPkcGPeErhPwL8uuEImzZ+01lznRXEi5
         uWJfia5V9jOcNr6QzRA7Sg9mrUU9spOoWFQ4PQOZipiOLmEvb6VtbXmshvhYwojNuTiN
         Xnog==
X-Gm-Message-State: ALyK8tJ7x08jV/9J/655r9E1gFY1/mMPk7SbYelrspdKEwQ4SRtLzMS7Z7cFfp0fjQ48jw==
X-Received: by 10.194.54.198 with SMTP id l6mr9830840wjp.67.1467229694929;
        Wed, 29 Jun 2016 12:48:14 -0700 (PDT)
Received: from [192.168.1.34] (aefh205.neoplus.adsl.tpnet.pl. [79.186.137.205])
        by smtp.googlemail.com with ESMTPSA id z5sm239598wme.5.2016.06.29.12.48.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 12:48:14 -0700 (PDT)
To:	git@vger.kernel.org
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Subject: [RFD] Place to document magic pathspecs like ":/" and pathspec
 handling
Message-ID: <577425EF.6030900@gmail.com>
Date:	Wed, 29 Jun 2016 21:47:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

123456789012345678901234567890123456789012345678901234567890123456789012345|

I have noticed that the magic pathspec ":/" is described only in RelNotes
for revision 1.7.6:

|* A magic pathspec ":/" tells a command that limits its operation to the current directory when ran from a subdirectory to work on the entire working tree. In general, ":/path/to/file" would be relative to the root of the working tree hierarchy. After "git reset --hard; edit Makefile; cd t/", "git add -u" would be a no-op, but "git add -u :/" would add the updated contents of the Makefile at the top level. If you want to name a path in the current subdirectory whose unusual name begins with ":/", you can name it by "./:/that/path" or by "\:/that/path".|

||
|I think the reason might be that there was no good place to put that
information in.  Nowadays we have gitcli(7) manual page, but perhaps
it would be better to create a separate manpage for issues related
to pathspec handling (of which ":/" is only one part)... but then
what should it be named?

What do you think?
-- 
Jakub Narębski
|||

