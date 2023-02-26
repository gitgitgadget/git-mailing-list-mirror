Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65BBC64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 09:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBZJfm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 04:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBZJfm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 04:35:42 -0500
Received: from smtp49.i.mail.ru (smtp49.i.mail.ru [95.163.41.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C593610267
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 01:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=FjxbMHMbuxoZmo2zvFZMaLSCG0wd9iBDQ1QTTpRiKN8=;
        t=1677404139;x=1677494139; 
        b=YIHSXmUR6eGvQWc63jufJZ7qKqe/b80fLYOSu/1pyJwdKogUT5KcQoKvbjYj8nAyK4WpxPezg7J56lda36RgO8NUaq+nSTPI4/cEk4JVqbrREO2pzABRZrWqzJHr4dqJf9wfB+kYwRt+Wx1T0MYZKipGPEuS1ef3hf/UhAlpRZJbGweY49cZAJnysvUEE16CMOPT+q8PKCHLEay4/KuyJXwFMvhuZ90ZqBke7pPfyFM0mvm8PubHb3pYL5Kc/S6z3ebQuQVWNfvp8CZNxTPSonVOlez6aHAqES7iv18YUVHtc39+b23dPbKrqIbj7nhvhCtzcg63n92CN2ShTEMPkw==;
Received: by smtp49.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pWDRQ-00DGLs-S4
        for git@vger.kernel.org; Sun, 26 Feb 2023 12:35:37 +0300
Date:   Sun, 26 Feb 2023 12:37:30 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <93307185.20230226123730@inbox.ru>
To:     git@vger.kernel.org
Subject: Re: Hash for a commit sourcetree beside to a commit hash
In-Reply-To: <1798489336.20230203042837@inbox.ru>
References: <1798489336.20230203042837@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp49.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9806C989EC2150E33F4358D0D08B70F42B7087717838FB7B6182A05F538085040E4CFCA22681785C655D4BCA8496310727E3CF20B1427F433331388BBE5F8DC03
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BC08626EA5717D14EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CF05F7050DCA185A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D85ACDD376C94E48AE9F13AAA57CF1A5916F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE74E6249692949ECEE9FA2833FD35BB23D9E625A9149C048EE9647ADFADE5905B1618001F51B5FD3F9D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B00E8CE3DD197987DA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC73AB4971CCA24CF23AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F79006375D83FEA6884D90AFD81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F9FFED5BD9FB41755262FEC7FBD7D1F5BB5C8C57E37DE458BEDA766A37F9254B7
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34B9F55CA4D2956E30B666C52F9DE42BE31C80842D89138D197802C2FE9569AC04F636601483EDA7931D7E09C32AA3244CCA841C13F1BD48412DF9554867BA9D907101BF96129E40113EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojY+HhiuGRi+pvIJscg8mQRw==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E54F48C4A9B4E86B055D4BCA84963107206869FDE987C96F758EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,



Friday, February 3, 2023, 4:28:37 AM, you wrote:

A> Is there a chance to add this property to a commit and a set of commands, for example, to search a commit by a sourcetree hash?

And another interesting ability of such hash. It could optimize upload/download of objects, for example, after commits rewrite when non sourcetree change happens.
For example, user email and name is changed. Currently git retransfers all objects to the remote repository on the push. In case of new hash there is won't be a need to retransfer the sourcetree if it didn't change.

