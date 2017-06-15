Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C45011FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 06:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbdFOGuZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 02:50:25 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36804 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752053AbdFOGuY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 02:50:24 -0400
Received: by mail-it0-f65.google.com with SMTP id 185so994276itv.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2017 23:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=Wb7jn3Sz7KT5zMQg7UwQ0SNaf7eJvnetbI/tQcP4g6M=;
        b=MRx5B5ymptw9dTXQ7lqtPpynLYzI1eXcOXc9zCE/gYIB18Y16TcsedwJz4edK55Vvu
         eEXw8fAs+Dj3bYjd6giAKr0DGwKsDlt/2gNa+9fToB8TtHJBkj4bqN8fg/w2FwSHARhJ
         zyMIgUNCGl/fYbPP++ZDbnqOgYBWLjcpxPqA+QE8yp9r8hI9l8Qpr1czeV0kxv63c9GD
         5tiiKz+o0kWRdWsd99idzGYCK1NgbgDInQaaUSr/er/giczx+gRFy0/Sen6KKr/GpSjI
         HZXotsIitkyt41PNSOQ3DwYADUH6BOa/SNZB8qccWdCOdEmrZUNeecY7HYQLGSSn5MEs
         ty6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=Wb7jn3Sz7KT5zMQg7UwQ0SNaf7eJvnetbI/tQcP4g6M=;
        b=fN8N+hoN35V8ZrReVfoO5VAV9rKAsjKqdtfb5bhXVof4Syj7wjt55MxrMLE2mDh2JG
         7OMdeRjyuh9yNtsaDGrHLTi47tTJAtIi5uK5LCYdvW7+WBHDUeqhUPnpTsSBIB0jHHFu
         69NsXGv9zkKS+2QdVD+jF1S5jjXNj5temH4wzP6/LnQAcXkjJutbBL69ZqfaB7W3jiV1
         rpMSKTvKnLS4znFtkoFjgOCZJV01/If5swlSDPEXNvyGz9h5SiXu0mi8ZPtpFh9RLgwS
         cIMBV9Nrc7rtF+tRMeCTfiuOEzbV9vUsuvBYq4tyg+IwxrkRpXhdj09iM1BTx41kX8VR
         wStw==
X-Gm-Message-State: AKS2vOztlg1PNzn9RhIKbrNDr6lLE1OajGoAqz9i2Lwmxl/Z/bAzkqMo
        lxmxYEu/YXs8VQ==
X-Received: by 10.36.44.211 with SMTP id i202mr3868189iti.46.1497509423938;
        Wed, 14 Jun 2017 23:50:23 -0700 (PDT)
Received: from unique-pc ([157.50.10.250])
        by smtp.googlemail.com with ESMTPSA id y79sm1208157iod.13.2017.06.14.23.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Jun 2017 23:50:23 -0700 (PDT)
Message-ID: <1497509403.2394.1.camel@gmail.com>
Subject: Re: Small issue with "add untracked" option of 'git add -i'
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 15 Jun 2017 12:20:03 +0530
In-Reply-To: <1497445448.2678.1.camel@gmail.com>
References: <1497278015.7302.13.camel@gmail.com>
         <xmqqwp8hnm1v.fsf@gitster.mtv.corp.google.com>
         <xmqqshj5nl3o.fsf@gitster.mtv.corp.google.com>
         <1497445448.2678.1.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-06-14 at 18:34 +0530, Kaartic Sivaraam wrote:
> That's right. Though I'm not sure of the implementation, I guess the
> following patch would make `git add -i` do what I thought it should.
> 
A possible, probably better,  alternative would be to make the empty
state output more interactive. i.e., making all the options of `git add
-i` to output some useful message (something similar to the one printed
by the `add untracked` option currently.

-- 
Regards,
Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
