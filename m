Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7118A1F462
	for <e@80x24.org>; Wed, 22 May 2019 12:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfEVMDx (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 08:03:53 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39306 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVMDx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 08:03:53 -0400
Received: by mail-oi1-f179.google.com with SMTP id v2so1372341oie.6
        for <git@vger.kernel.org>; Wed, 22 May 2019 05:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=informer-com.20150623.gappssmtp.com; s=20150623;
        h=sender:date:to:from:reply-to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=qLpSLyuEZxIUfINSscb7Buj7YwWnZ9nIMH+igN9fxiI=;
        b=OyC08drAFmMfKwxvZJpXF0KQcqVNkTIcNEleCzyQMX/Ojb9jJiBUJF/GxI4l/i7qw1
         pK8r/1FRJEBWIJ15VDEmEgmY6IqFbGc0DESldU67FFsgoN/oTfrpqfc0DmQqNiTOfVe/
         4IMwWLqHnQrocZ57KP40TsWaxU8SItpAIntU3kUs4fyKVrYiP17olZruVtKJ/H0xk1gA
         lFBuGzmjfenMg6PDBc105QocGvunlFip4fxG/9tiZ4hLAzUepcZYcsGL8wdLOjciv9yd
         krptUqiBluigoDBTm1wq2z+OfnxGeXlzOPtCt5x2iy5icpeMEjru3ZRrg8zOkTwZ5eI5
         NyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:to:from:reply-to:subject:message-id
         :mime-version:content-transfer-encoding;
        bh=qLpSLyuEZxIUfINSscb7Buj7YwWnZ9nIMH+igN9fxiI=;
        b=Y9WNB8yAEiZbuTuU8muD863UZds/hDrjzvEbcFkd+gBadmP1l1YL6f59Uaz84BGaMh
         KFdBEJY2MZhgnhjn/RxovnlvlvPLBLcbONryi48NoP3sq8x5zY+fd88jFVhyK4CS6MVj
         XQ48KLWKwNXDEvU/a09H3knVPbjzaNXhtTno89xazumVWNUbnFEuF8R/3CypU1xor9y3
         SGE3TEFmSqY+Xn0um3cRQObQFdZH8ColkJXeldj5aSv60gKacI8OcpxPKn0zS/v/H+iy
         5lUbLtIiNUNfmYyhs9+UirNB7Wv+dmYwaXeG3MUkvAxpXJFQduldwPRK7G33Y55ztgRB
         uuVg==
X-Gm-Message-State: APjAAAXkHmFUE9bXvSpgPM+wX9JxRmPV4BjJjGmt+M+SwWnkGOPGrsuU
        7VaXLes8KX8uFlNCmhKOUo7+K6GyUUA=
X-Google-Smtp-Source: APXvYqxLkUNTLOvKb7pEJZxTaPFXabbM8OGoJRq+7WGZ7AXZjBjuM3rDUa7hIQi13ZYRv4040QeZJw==
X-Received: by 2002:aca:d40b:: with SMTP id l11mr699294oig.132.1558526632341;
        Wed, 22 May 2019 05:03:52 -0700 (PDT)
Received: from software.informer.com ([208.88.224.100])
        by smtp.gmail.com with ESMTPSA id u8sm8600355otk.53.2019.05.22.05.03.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 05:03:51 -0700 (PDT)
Date:   Wed, 22 May 2019 08:03:51 -0400
To:     git@vger.kernel.org
From:   Kasey Bloome <partners@informer.com>
Reply-to: Kasey Bloome <partners@informer.com>
Subject: GIT by github 2.21.0 got reviewed on Software Informer
Message-ID: <787cc1158404969e56c6ef3787457cf9@software.informer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good day!

 would like to inform you that your product GIT by github 2.21.0 has been reviewed by our editors and your program got "Editor's Pick Award", "100% Clean Award". You can read the review at https://git.software.informer.com/.

We would be grateful if you place our award with a link to our review on your website. On our part, we can offer featuring your program in our Today's Highlight block. This block is shown in the rotator at the top of the main page and also on every page of our website in the upper left corner.

You are welcome to order a free video tutorial for your program as well. Once it's finished, you can add it to your website.

We also offer you to take advantage of our free storage by hosting your installation package on our servers and listing us as one of the mirror downloads for your program. There is a selection of predesigned buttons available to fit the look of your website.

Please let me know if you're interested in any of these offers.

We are on the list of the world's 1000 most visited websites, so this could get your program some extra exposure.

Kind regards,
Kasey Bloome


