Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEABE1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 18:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeKTFMe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 00:12:34 -0500
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:44894
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbeKTFMe (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Nov 2018 00:12:34 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2018 00:12:34 EST
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id OoT5gz09nSuJQOoTBgcVvM; Mon, 19 Nov 2018 11:40:26 -0700
Date:   Mon, 19 Nov 2018 20:40:18 +0200
From:   Max Kirillov <max@max630.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
Message-ID: <20181119184018.GA5348@jessie.local>
References: <20181119101535.16538-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119101535.16538-1-carenas@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfE2eZFx5D4THP1rT40ljIJL3g4WmwEXYEJz6PLTKReligOXamC/PCL3WSlLhBjW+sUeSyAkBOGGUqw4qjj6efaon3UpcCPUJ3oXEAwkLkJxyOglGxk9F
 +WfQZxQJ6kw85pOa91J7bDhpeMs8ckKPP3KB3YDK7Hzzf95UyTDLaGWDVN5e2PHkeTJu79pbLceKMw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 02:15:35AM -0800, Carlo Marcelo Arenas Belón wrote:
> 6c213e863a ("http-backend: respect CONTENT_LENGTH for receive-pack", 2018-07-27)
> introduced all tests but without a check for CURL support from git.

The tests should not be using curl, they just pipe data to
http-backend's standard input.

-- 
Max
