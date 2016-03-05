From: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
Subject: [PATCH] fetch-pack: update the documentation for "<refs>..." arguments
Date: Sat,  5 Mar 2016 16:34:04 -0300
Message-ID: <1457206444-26134-1-git-send-email-gabrielfrancosouza@gmail.com>
References: <xmqqd1r8vjqi.fsf@gitster.mtv.corp.google.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 20:34:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acHyI-0005lJ-OL
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 20:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbcCETeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 14:34:36 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:33167 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbcCETee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 14:34:34 -0500
Received: by mail-yw0-f180.google.com with SMTP id b72so65698554ywe.0
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0CAHTg1brAt0w3mSMk7f6AbPfT7hbWfJxldizR7Hstk=;
        b=DOOP8IN+jkwjT3o9XC6HJVkAZxV2Q8w3GHXVY4K3ZdXkDlsqk2/S481tCLyOI4s2g7
         DO/90C2pBCiPpPjqu8UhyiiWDHufWT38rLUSbgFa9prYLtxBmZHbQi2suvT7bdodwce2
         Q5n44D8fExjrvqMGWZwEzCyqpWzyfKXF8rCb8Li2iLXREw8MZWo+c2h77veQe3mC7cwN
         rYOCx3IBKLmApzERf0Z4/NOozDKllCAsRCJ2xOedgcE4E4P5ROi4OyBXU+hZH97PgkKK
         /8BiN4Z3vv3Pw1w+PmZhIr/R0/aaOuEUhPOytNhzKDOY9tyT1GZnPuIKkiIOnpJlM3R9
         2l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0CAHTg1brAt0w3mSMk7f6AbPfT7hbWfJxldizR7Hstk=;
        b=kb3ccN6solLgQ15ZDfmIyphCu4hX6UvRcVbDTF1GFtDbaCDWFdc2AbKyL96yAKyjkI
         rTjxbPOvyC7jYRpKzXXDiQWRSNpL7S7ZUdO0ge5+dVLt6/uWrcOARHWpdtDRDpD2qVXC
         eP6zs1GJVwblnq4M/HOdC8xDdBZ5cw31Fl9VqhMajQneND/bWTDreAXnFlvtpMbj2WAu
         mmtu5kfwVndXyCMzQqwN/ASngH7DDcLvU31KNl9DKgfNGiBFT15xbd87Mvd3YR2S3ni1
         DVmyjjCUUe4GyGjnQJ1hrjxo9VhiKgvwhKF1nPJbZeoPYMFUC4JZgPAWpgLMAJP2R3lP
         8DaA==
X-Gm-Message-State: AD7BkJIVdYfpgV7ZcPvQAq7BhXGtdCu+ogcWh5kird+xA1EAFlKoGDsaKpA5GmekFu2tgw==
X-Received: by 10.129.17.66 with SMTP id 63mr8541994ywr.122.1457206473727;
        Sat, 05 Mar 2016 11:34:33 -0800 (PST)
Received: from ghost.localdomain ([201.82.54.180])
        by smtp.gmail.com with ESMTPSA id u134sm7022466ywf.48.2016.03.05.11.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 05 Mar 2016 11:34:32 -0800 (PST)
X-Mailer: git-send-email 2.7.2
In-Reply-To: <xmqqd1r8vjqi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288323>

When we started allowing an exact object name to be fetched from the
command line, we forgot to update the documentation.

Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
---
 Documentation/git-fetch-pack.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 8680f45..239623c 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -104,6 +104,10 @@ be in a separate packet, and the list must end with a flush packet.
 	The remote heads to update from. This is relative to
 	$GIT_DIR (e.g. "HEAD", "refs/heads/master").  When
 	unspecified, update from all heads the remote side has.
++
+If the remote has enabled the options `uploadpack.allowTipSHA1InWant` or
+`uploadpack.allowReachableSHA1InWant`, they may alternatively be 40-hex
+sha1s present on the remote.
 
 SEE ALSO
 --------
-- 
2.7.2
