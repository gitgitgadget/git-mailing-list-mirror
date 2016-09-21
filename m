Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3791F935
	for <e@80x24.org>; Wed, 21 Sep 2016 22:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbcIUWYn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:24:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40183 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933101AbcIUWYm (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Sep 2016 18:24:42 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 80F772051D;
        Wed, 21 Sep 2016 18:24:41 -0400 (EDT)
Received: from web3 ([10.202.2.213])
  by compute5.internal (MEProxy); Wed, 21 Sep 2016 18:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=iankelling.org; h=
        cc:content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=DFJ6wR3EABrSVjFQSJV9YWiyQVo=; b=kMz/ds
        35Rbq2GrV6BzwAoYL7I4e8yRiGPA1aLV8dJMumwxRQEHP3NsnrYWyhdGmD3R4AG5
        sI2wYmyz1GAbl1mpXTjtMY6yi0MlUBltdEdc+xShDhINi/PciesgGFGBHpckwSOq
        20auA5vzUyctGjwC6DOX4YSzE6UjZi3pmW+YA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=DFJ6wR3EABrSVjF
        QSJV9YWiyQVo=; b=o2nvd7MexHMNJJf9tZKhXrf0qyUtBVSJP1ynOcGOWNZfDJQ
        If1KYetpI4Le4mJ1Jg+gTeGjakdyAby8KA/n5iy4VQdxTNNS32HqV1XiXPiHwUnD
        o0wiACXCMkC76afDMcnlzYz4UvJAc3p6V3f39GAcCK6ElZFSv4qAlGZBSWKg=
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 5754B2E6DA; Wed, 21 Sep 2016 18:24:41 -0400 (EDT)
Message-Id: <1474496681.402026.733160001.6DBB5A8F@webmail.messagingengine.com>
X-Sasl-Enc: 6aUKF/M87i2MqECIXe0BUx6z3iLOQKUqjQcd2rBj+ElZ 1474496681
From:   Ian Kelling <ian@iankelling.org>
To:     Ian Kelling <ian@iankelling.org>, git@vger.kernel.org
Cc:     jnareb@gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Mailer: MessagingEngine.com Webmail Interface - ajax-43c89091
Subject: Re: [PATCH] gitweb: use highlight's shebang detection
Date:   Wed, 21 Sep 2016 15:24:41 -0700
In-Reply-To: <20160921221856.27830-1-ian@iankelling.org>
References: <108ce713-337a-801a-6c3b-089ef25a3883@gmail.com>
 <20160921221856.27830-1-ian@iankelling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fyi: I mistakenly did not include v2 in the subject of the last message.
