Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B477E20248
	for <e@80x24.org>; Tue,  5 Mar 2019 08:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfCEIFa (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 03:05:30 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:44856 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfCEIF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 03:05:29 -0500
Received: by mail-pg1-f181.google.com with SMTP id j3so5100327pgm.11
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 00:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-description
         :content-disposition:user-agent;
        bh=x8TE1UgXlEG1jlNuvITF8j9Zxx0WOirdwYxeiA2z8c0=;
        b=U341PAuvvmBGEJNWPlz/h+NXObrt3AG8hncTQU5v1eO3alboa6pU79kwXeP2hKs6sk
         P/7tiEQfoH5jUIrTv7/YMlvX0cQcrtj1v3/7aEf0sp1zLfH/oo0K0FH/cQuGZgb9cdbd
         f0NXnku34jjf02XdTjwTbbkxzuJUMU/YW2cXb0Lky64wSTQQCHtnyK2sgnMIMPopbu5a
         lNIUVgentLeJbW/AinRHdEFvkD/Uru7sk40KN99XvlPczyiazAyFI1QTiji/yqimZwP/
         3HyJhafJQDfvrWSMX1jwf2z0GQT42vNdmDeb13dM1oLIdBw0jr5FVkOcMTmH8HrmcEFY
         h5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-description:content-disposition:user-agent;
        bh=x8TE1UgXlEG1jlNuvITF8j9Zxx0WOirdwYxeiA2z8c0=;
        b=UDbSAE8ycoVGHTKchH+s1ARoRXce+YNT0F8r6BeBeqq6hYmzOACAIuuKaqj9i46l/Q
         MWcU+wqxxS4zaj9zNrqA9h8gAWbCwzvccgSWUQNQ4uSVqrc4f4vkCSv8lumvIwHXNkcP
         JpyRTT/1FNFZCwXcS+dGOibEFkMDoagzJYZtCGxRfKgDEAcGMiThTGXrxFZq0ciNDFVN
         TEzAD06T/Is4vGU2+hqq/B2sZI/kNGAdt3F+JCj1zxH6vOJylx4DWNeLol10N/tKiNxr
         Y98pFpnO68N3C0fFoySjqLU+O3MH10iFK44CuVi+j98+u9fBj/Zda+iqQ/w0TB+13UYh
         e8uQ==
X-Gm-Message-State: APjAAAW2DdNWnp7xK2TEbRvcpAkcvy9Ah7PXcW3WjZBKwXE+Gkq8nWTj
        jf0lob0vtwhnHOGBDItrFB/wgpTckk0=
X-Google-Smtp-Source: APXvYqy8n7tCTsMZBGOVwVJP99et6+/0IBQgFQ4zAGyU8V9udg+K/MteQvYlnB7gOp9I8cljU4Jx1A==
X-Received: by 2002:aa7:8a0a:: with SMTP id m10mr606642pfa.129.1551773129064;
        Tue, 05 Mar 2019 00:05:29 -0800 (PST)
Received: from hacker-queen ([157.49.238.111])
        by smtp.gmail.com with ESMTPSA id v8sm13991704pfm.174.2019.03.05.00.05.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 00:05:28 -0800 (PST)
From:   Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
X-Google-Original-From: Sushma Unnibhavi <sushmaunnibhavi@gmail.com>
Date:   Tue, 5 Mar 2019 13:35:22 +0530
To:     git@vger.kernel.org
Subject: [GSOC]:query regarding microproject
Message-ID: <20190305080521.GB9308@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: I am planning to do a microproject on using unsigned integral type for collection of bits.If anyone else has not taken it up,I would like to work on it.
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am planning to do a microproject on using unsigned integral type for collection of bits.If anyone else has not taken it up,I would like to work on it.
