Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA6520951
	for <e@80x24.org>; Fri, 17 Mar 2017 16:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbdCQQlJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 12:41:09 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35724 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbdCQQj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 12:39:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id g2so10693956pge.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=03Np8rKFptrxRb8I8dTw6HFQmsl3+K/Q7qSJtT4/1f4=;
        b=tQ3g+mdrx/FCJbKPvGkdwWbom8U1Vp+ZhD+H9P9WvG03dC0qQXh6LZkRVtjcgCh8uZ
         Dza4pCXGJgY/LdHVO8Taq+zItO22s4bx6zNCnBIjtB27RV3f2/riYeExndoZqZyyJDJn
         mzNJ8jSYxj6BIJuRPxVng6uYZOKMXr+nYwewmrF00KZmnrnyYm6NH3P1cKn9M2dfgzuJ
         H9AO2JkYZigF6ZO36NFAPaUFcW9J2j7O6RwnPO5Q/731inzhPQgEhfR/hQvN+V9U4k7B
         aj+q+upfoujBHHxWHs1U9JzHylzS+Vwubh0ezmED0JTfiYCaQgf5titV2WsIjWlz0SM7
         /gHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=03Np8rKFptrxRb8I8dTw6HFQmsl3+K/Q7qSJtT4/1f4=;
        b=h4zVU4QZnhz5Qqw/JKdLqUeMwOlLnm44Ny0f9MJbYSEc88mLnMgiC9f7AUmaMYT0UV
         PPfv7EiPEieHR4vhBggyTApog72fTf3TGPJ8QB2oOa4gsxkhK4Vb0Q7cfDBvZXhE1dXa
         BMh77dToDi6wlOvFSFEl1ew6PqID8WBglCG4auhqIz9jxDBAptaSHT+H+PJ9wSMrnbOt
         vSWaNyYW0DFjEi62x2L28kzsoBcndtq0yNsQZ8r1HT+tpk9g2xJqgfqbVUfZgtGCuNEc
         CIkTfGpyHf6ZkLfsSiWvHJg3fwkOIoZrw9Pe1D8evKTRwtgKkndA9q5vhBEpv7IZurlR
         vmwQ==
X-Gm-Message-State: AFeK/H3V7mt7xoHw/UpWEXYGozmvOi7r+JIcD7PX51v2X0l4ZwLUGdJwS2kjLFLunjbbSA==
X-Received: by 10.99.130.193 with SMTP id w184mr9599414pgd.157.1489768759845;
        Fri, 17 Mar 2017 09:39:19 -0700 (PDT)
Received: from LOONGdeMacBook-Pro.local (144.168.58.55.16clouds.com. [144.168.58.55])
        by smtp.gmail.com with ESMTPSA id d10sm17843787pfl.59.2017.03.17.09.39.17
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Mar 2017 09:39:19 -0700 (PDT)
To:     git@vger.kernel.org
From:   yanke131415 <yanke131415@gmail.com>
Subject: why patch to the gitk no replay?
Message-ID: <e7d6f518-51aa-92fa-e685-7cde019d6e5b@gmail.com>
Date:   Sat, 18 Mar 2017 00:39:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

     I send a patch to gitk project(git://ozlabs.org/~paulus/gitk)with 
the target email address paulus@ozlabs.org. But several days later No 
replay of this patch i receive, is the  email address i send patch 
wrong? Anyone who knows?

