Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239B0207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 16:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S973049AbdDXQIg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 12:08:36 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36563 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965377AbdDXQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 12:08:34 -0400
Received: by mail-pg0-f42.google.com with SMTP id g2so15208246pge.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WdU13G8h7MnC805QZ0e5ZfU81s2CWkuANhovWAJPT4U=;
        b=hITKJEb0rN9TMCUlohF+ttXmssPexRmPFXc8jHJ5b9sSgAlg2mOmiFBrkbgLhJGcvU
         y9vB3dl3sCOcdJccRs3r96hGK6bgLlYC5LF+U0FKq1alxV4vqOvdnREqJPswr9UoTw3j
         mQk5MawOt0h+l3v1rsq2yEiMBR2psIoX2xZ7w49Ys74QulX+Czs+6gjPmZlYneMeF7VM
         1BRu3mgUK5enyEmWkyVjcAOUhqOZtSXbRsbvCFmaxLhGBoPVf9r003MkXMR+FxX3AGmk
         0N1SLQiBUSrtw+bgYWlWqFFYAJOiNoWiItST2eIarKEaCiAcASbrGjovDZkXg27uAFNv
         BnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WdU13G8h7MnC805QZ0e5ZfU81s2CWkuANhovWAJPT4U=;
        b=kmS+VZZp3I4zn7aQm1NiNZHndx0iyMJ8cEE3vZ6A7EwCLWJkvEZOur5YwaYCh5nD8Y
         ZCeuAFAQTos6FtUBgBkXZmg002MluuGsSx5Zdkd61DSQ+uQN9m3WFuPUon+cH+Q+Jny5
         IhZ8vii1j5UVLNA+qZKSNHn0Ibs8h5XXTK+vkaP4JryzIEEGXN2dUMRyviEhXfcxJYTH
         m6l7jxf7T8x2cWW8L0bYSCx9rIbCjl6fk3CJZoi0nTsg14oSSKE/U7ntGw4aJCIqBdKM
         Fcab6GvA5og0L/aAkm3hD40cQbOxG6TkKt/NOzvsj8rYpiHB7k63XTQWcQqRk3ORRLs1
         jSHQ==
X-Gm-Message-State: AN3rC/5S0NAF9QKDnorzjLSuZiNKbXADTBhA+7crc4T61L0Y0Qfc0R1Q
        ypQR2aAXTH1VK9sd
X-Received: by 10.84.128.66 with SMTP id 60mr22385198pla.167.1493050113456;
        Mon, 24 Apr 2017 09:08:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:fd4c:a29e:d4e5:1c03])
        by smtp.gmail.com with ESMTPSA id q85sm31785433pfj.112.2017.04.24.09.08.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 09:08:31 -0700 (PDT)
Date:   Mon, 24 Apr 2017 09:08:30 -0700
From:   Brandon Williams <bmwill@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/53] object_id part 8
Message-ID: <20170424160830.GA195761@google.com>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/23, brian m. carlson wrote:
> This is the eighth series of patches to convert unsigned char [20] to
> struct object_id.  This series converts lookup_commit, lookup_blob,
> lookup_tree, lookup_tag, and finally parse_object to struct object_id.
> 
> A small number of functions have temporaries inserted during the
> conversion in order to allow conversion of functions that still need to
> take unsigned char *; they are removed either later in the series or
> will be in a future series.
> 
> This series can be fetched from the object-id-part8 branch from either
> of the follwing:
> 
> https://github.com/bk2204/git
> https://git.crustytoothpaste.net/git/bmc/git.git

I still have a series to convert the diff logic to using object_id.
I'll rebase it against this change and wait to send it out once this
topic has been reviewed and is stable (hopefully it won't require many
iterations).

-- 
Brandon Williams
