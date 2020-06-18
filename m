Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20824C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 04:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04A152186A
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 04:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgFRE60 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 18 Jun 2020 00:58:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57963 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgFRE60 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 00:58:26 -0400
Received: from ThorstensPC ([109.250.247.238]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MMXcP-1jUwIp3xlH-00JeSN for <git@vger.kernel.org>; Thu, 18 Jun 2020 06:58:25
 +0200
From:   <sopq0asmppc9@online.de>
To:     <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: AW: Git commands throw error
Date:   Thu, 18 Jun 2020 06:58:27 +0200
Message-ID: <01af01d6452d$1a91b590$4fb520b0$@online.de>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGVGxHpUbvxRIbKwyCHtdsnVORiWKlgI2bg
Content-Language: de
X-Provags-ID: V03:K1:B45J7Y5Y67psPeg6pRCGd+0urQ3TSzGH7hb6yl5f1UZKQl5YGfy
 5+TFL4rsIoBSSuWsle5F+E2TVAUlrlZUBwVHl1z/C53avLj1lVDqr7yrS0iWT+qbOBM9Ju+
 SA4KZinZz6eSCV41KbjWBotKImNn9xW+0aGvIvS5S9Okpv+n+xgUevu001R7Tnasm6G6D32
 om2o/XCbUxf5ZBjN04UYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3HElyQ0Ha74=:cELf7q6yw4PNQQHKPIsZdD
 y/Ew0VD5TdKmOa9H6JKu30u0g3S1Q+PK2PcV8wUE6r3a9Gs9oooLKb/tzDqvgpHlsvFDVAJEi
 uNPKUXcKIyBxyAk1j975DaWY0MMjG88yia5LLHuKt3zte+5pRmopaVYWqNJn4QNfZe2jAvW3c
 77uRo8UJXDrpA0Dn1et73zPk/A1fzLtQrKOV6R9VZkZ2RZKXr+freFIhxR+Km3lvhfZJ3qdZn
 b98LYx6fGNyZpsvZq9bA+d7bkmbm9kVT/h6fjDImUmR8xpBbDIeLtcrfPltR/IZCtf0TQ96oQ
 h9uTsNvULpqao3XiFvBvZVNnAqOTYQqsF4z7kKUlqf/+JAndo2HixN7yFiWA+jAyMoRviUDLD
 XuS7pp6cICmiAwhU+b1Qztb06cfIdlcG5GF5zSpdL0hBKQ8eL+YCmk8E0Hi3+QWxVa8AXX+4l
 U/R6NlBzVnt4v5NhXIyt8/z2SDYr40f2xZjRI4vdw5d+yNYG1bos1APGvfZLCAEdrsS4kvyRx
 v4RqPPtzn+7Oqb654bLHXFRNK7YJi9N4GON/t1ehsaKsTDrXyZZAorGlSWheVimRNI0anwfJV
 eYcIC2pAP/wJCUiwheVoRS9FpGaGMbdlfQ5YLD4SVjwH1/MJuqHfH//A5knHubdJNohaNRvqM
 dww5PPx0762KL9bZM/Ry9UxwTHS8O0ubZ8YujL5A7sLDvnPVB0BnVkJCRms69daLhpWJtvb4I
 UAKXZPS94HS4OzHEUEkpQe3aVzP2nHJ6IDd3+p4OhBds1TPgBzH9KRw+pYJ/65p1CdKQBEjh5
 j+Lmt/l7xGNgAuqS4QC5B/3ZU+fDALcIOhPBcX8vDxCCJ2FNPDqslwEzPSIyu1EDAXvTmoU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

I recently upgraded my GIT installation to git version 2.27.0.windows.1 

I have all my repositories on a NAS and now I get errors with all commands, e.g. 
git status ->  fatal: failed to stat '’: Function not implemented
git pull ->  fatal: failed to stat '’: Function not implemented

Setting fscache to false (globally or locally) does not help. Please fix it quickly 😉

Regards, Thorsten


