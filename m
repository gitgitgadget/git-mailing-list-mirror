Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD91C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 01:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjBCB2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 20:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBCB2C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 20:28:02 -0500
Received: from smtp37.i.mail.ru (smtp37.i.mail.ru [95.163.41.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8010276B3
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=xPefLwCq7rcAvnJB3VS8AsmizkzvYs8dlp2ODvbAVCw=;
        t=1675387680;x=1675477680; 
        b=Sb/Xt/m9yhS/Qq3iGx0nFjQ0lXXRy4VnkbiwZEe8OPNyjiHI9NLnGTxnx+WzcFJJmaZvzRZR8cGTaZo8WXLV5IDaF9i1H/LEMatfQoRJ3kO/kPK+ZR2iLRlOolFRVDO/cI1HvRR7fgcyiDsnFSTegWchhZPL50bkKZ3y6CNqPaTh6pb/sknXDUfDVEbv2G8hiXwljYUD51iERAxxm0SFO2BPPFxDSZ06aUX+A64laPKzlj2WPNh2C8kqIHKYPMkAMSQaKk9ppL39hhfZ3sOwRqUoWg/eIcC1dJna/phM9cOw4FKkW4EipKgknniasaYxYEqBP88cGAfYN+mOt4Bjyg==;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pNkru-009jfj-2f
        for git@vger.kernel.org; Fri, 03 Feb 2023 04:27:58 +0300
Date:   Fri, 3 Feb 2023 04:28:37 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <1798489336.20230203042837@inbox.ru>
To:     git@vger.kernel.org
Subject: Hash for a commit sourcetree beside to a commit hash
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp37.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D919194CF4FC6604F4B6FC15EC321A30982183F3DC96EB15182A05F538085040BC67B84361B72C87F2ADB3C1BFAF7925C19D5FA5FFA582DB7076E36C6BF2CA4B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73B2A9F8A35432468EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006378F586D843116CFB2EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B6F1F7B995052D5CE190DF5888BA662453848705BA18EB90220879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0CDB87A87303EAF3F8941B15DA834481FA18204E546F3947C24F796C710B8583CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637036D0B7DAED17EFF389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637087030195466867ED81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636D81D268191BDAD3D78DA827A17800CE7B7E664FAF72630E1EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C376F138C68E4EE6C935872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A5A816DC16A2D0E5CF2D9C6A11C6F0ED4676CA2EF022DFA6995A4FF58CDAEABE2AA132EA92956906CB7DB42AF402581C238FB05168BE4CE3AF
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3498910055B812BD9C54E5B8147833EBC47A88D80C94B2A1B482157BEF73603DCA72D8F0ABD43E49271D7E09C32AA3244C4261A8DA112F085B7421AAAC3ECD96EB1DD47778AE04E04D3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXhBXMu1Vc5Wtuk/bsZXBsLv
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E29D423E4D1AE1F74F2ADB3C1BFAF7925454AC7A74640230758EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

Is there a chance to add this property to a commit and a set of commands, for example, to search a commit by a sourcetree hash?

Sometimes a forked branch has edits which does chance commit hashes without changing the sourcetree, like user mail rewrite or commits remove or just a commit random property change. This leads to rewriting the rest commits in a branch or tree.

This feature will be useful to search in all commits including rewritten.

Of cause in case of rebase it won't work if is happened at least one merge with the interference with other commits in a commit chain. But if not, then it might help to search commits even after automatic rebase.

