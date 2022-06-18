Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F052C433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 10:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiFRKpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jun 2022 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFRKpg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jun 2022 06:45:36 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9EAE0A6
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 03:45:34 -0700 (PDT)
Received: (Authenticated sender: contact@luigifab.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 3EA1740005
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 10:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luigifab.fr; s=gm1;
        t=1655549133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Trp6TjBMxULQ6+JDN7OBNRMqRDdqjNujwV8UIU4OOh8=;
        b=pEYu4XYoVh6eJb1lFHY9NFy6MUKEumG5uVtdw5qLgB3mWI/12440LqmjOxZ6BJgtdOGAys
        oGIa9u5tr7vqVFeJ89V5QWfYi11yZm1m/SNfd2flk60WmaxZs6Ywj5SxjTkLfSsqKVudtR
        3IvPIv/VP9DoOCrOHVh4zsjHrKp1viM6CBKNy+RNr/1CpD4XosxrpZgpRWSu2LGwGxDKkg
        GLQoUmhYOHVgQyeV+ZDQifB8l14XR6QRKSwWbV1RlzPLJ2OXdaBcHdyOqE9zlrp8EMKZGN
        sW58DgX4l+1LoWFo3auK4EZ0m/xKH2qe3l2A4ck53kxpuhUu54nKlKf+y8Mzkg==
Message-ID: <b4f40821-8592-1a35-8b60-219fd7e29e9f@luigifab.fr>
Date:   Sat, 18 Jun 2022 12:45:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Fabrice Creuzot <code@luigifab.fr>
Subject: git a/xyz or b/xyz
To:     git@vger.kernel.org
Content-Language: fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

When we are reading a "git diff", all paths are prefixed with "a/" and 
"b/". Example:

diff --git a/xyz
index 4aa4b5230..1c2b8b69e 100644
--- a/xyz
+++ b/xyz
@@ -1,7 +1,7 @@


With my terminal, I double click on the path to select the full path for 
copy.

Then, when I paste: "git log a/xyz",
  git says: unknown revision or path not in the working tree

Ok, I need to remove the "a/" or "b/".
But, is git can understand that "a/xyz" is "xyz" because "a/xyz" does 
not exist?

Thanks
