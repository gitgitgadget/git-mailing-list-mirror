Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D712C636D4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 03:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjBCDCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 22:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjBCDBw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 22:01:52 -0500
X-Greylist: delayed 2451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 19:01:49 PST
Received: from fallback23.mail.ru (fallback23.m.smailru.net [94.100.187.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FB31A4B1
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 19:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Vbp604g+rgactw88rcFKv50XsL81rZjvHL/rabLK7Cs=;
        t=1675393309;x=1675483309; 
        b=kYVka2f+hXEQQYxS46yQI2OR1HfkCLPDTcy8NSdeRw64JowoWiioWUrYTD5BDOrfAS7j/yFAdLgmoZtL07SrtAbQ4SogTGKD026JJVhko4rfc610gXKMTDn3bHcOs7ERfaTW1G5vuOFa+nSMag1gtOgIMFAJpRZRmbE7XCuNJia1zt1kWhNWTm399YRBeW2I5TeLGG+y4ON0Wyh+0GaIa603XbqB/F2MEn+Tju4WaGB5x7Ro9Df/z9eNZupRVg0sfsPt7FsF1PKfEmKAJUbgNvggC2fk6ri5D2aWr0HvkXAI1OqI1fic2lprSYyJ5bMeuAcd4S4yH120b3QTqYPXwA==;
Received: from [10.161.25.37] (port=51832 helo=smtp60.i.mail.ru)
        by fallback23.m.smailru.net with esmtp (envelope-from <andry@inbox.ru>)
        id 1pNlh9-0003ix-P6
        for git@vger.kernel.org; Fri, 03 Feb 2023 05:20:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Vbp604g+rgactw88rcFKv50XsL81rZjvHL/rabLK7Cs=;
        t=1675390855;x=1675480855; 
        b=p8a6Ui+FEVTiuHuxLiJEJp+VoU3g6bAQSVkwq7pn50z5BYY6dkXWANvhx9DDFBTvD+Mu3naoScX/CyXC/g+2b4sNfHMoAflHLjPomhMgyesHa0oD5LJMC6e5zdDpm5YepoKNPF6QlPW2oQvICk1TK2jqoi81C+beHbmMCb17K4MomLP77Mlk4TWa3Zkf5Y3lkRohAINib7eP5RvvXALHqfPPDZC0Eara55TP95va35RwsM8Tg+i1yFatzriXS6I13DoQ+bP0YMDmEtG9Axr9Xb81B6BPnhWywnEne5jLacrb25yuZ1aq+0Zod5WoIksB7HpzYUzzIAxWkCooEQmcXg==;
Received: by smtp60.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pNlh7-0000GO-CG; Fri, 03 Feb 2023 05:20:53 +0300
Date:   Fri, 3 Feb 2023 05:21:45 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <563617028.20230203052145@inbox.ru>
To:     =?windows-1258?Q?=D0o=E0n_Tr=E2=CCn_C=F4ng_Danh?= 
        <congdanhqx@gmail.com>
CC:     git@vger.kernel.org
Subject: Re: Hash for a commit sourcetree beside to a commit hash
In-Reply-To: <Y9xq5VAMjzUqTb6X@danh.dev>
References: <1798489336.20230203042837@inbox.ru> <Y9xq5VAMjzUqTb6X@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1258
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9D919194CF4FC660488DBEAA600CFE3E750760201CE27B4E7182A05F5380850404F05CAB6E3EAF2C63AC6A886E0C5CF7E3EF8A60B24ECDC9749BAC086A5B4E5BD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7922E451CE6E839B1EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637DD7A7F9003AF293F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8851FDEA48B9E292A416273DC83061A466F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE79FEEBCD9E13F050E9FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637200F62B2C1E683AF389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F79006372FD54AE4BAD6E1B9D81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636D81D268191BDAD3D78DA827A17800CE76D34D896D818D822EC76A7562686271ED91E3A1F190DE8FD2E808ACE2090B5E14AD6D5ED66289B5259CC434672EE63711DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3517AAFC1974B5A1735872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3450C5E6D685282BA1BE0F77E74F58E93DA3D841B2B4632628EAA7F099BA1829DB764EA0E975CD2D1F1D7E09C32AA3244C0E113B8C2FB098AF72FF87B2451ABC4530363D8B7DA7DD44729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojUCXb8yEWKAn14h6xe61moA==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14EA8347440BBC4A7A03AC6A886E0C5CF7E98C36B72C391314758EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4CF848BFCF0E6F430F1E17D0F5332DCF36F99FA8B2702F54D049FFFDB7839CE9E8C60D7A845AC12CFF227D883A2770312DF3CE5DC54C2249C8B02EF8AB8510C22
X-7FA49CB5: 0D63561A33F958A5E90BC8A2FCE4B93E6B0FF57EDD8033F6E8D75DC3630AB28FCACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006375A3B25A3A11CE7E4389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC86633242DC0339950F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CA816C540FC8EEC306E0066C2D8992A164AD6D5ED66289B52698AB9A7B718F8C442539A7722CA490CD5E8D9A59859A8B6505CD8581A3881E7089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojUCXb8yEWKAn58fYF87avsQ==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Ðoàn,



Friday, February 3, 2023, 5:01:09 AM, you wrote:

ÐTCD> On 2023-02-03 04:28:37+0300, Andry <andry@inbox.ru> wrote:
>> Hello Git,
>> 
>> Is there a chance to add this property to a commit and a set of
>> commands,

ÐTCD> Does `git rev-parse commit^{tree}` works for you? E.g.
ÐTCD>         git rev-parse HEAD^{tree}

If the `^{tree}` does calculate a commit internal sourcetree hash without other commits, then yes.
If it does rely on other commits and accumulates the sourcetree over the chain of commits, then it does not calculate the hash by the difference and can not be applied as I have described.

>> for example, to search a commit by a sourcetree hash?

ÐTCD> I'm not sure if I understand your question correctly, but does this
ÐTCD> work?

ÐTCD>         git rev-list <a-commit-tish> |
ÐTCD>         while read commit; do
ÐTCD>                 if test $(git rev-parse $commit^{tree}) = $hash; then
ÐTCD>                         echo $commit
ÐTCD>                         break
ÐTCD>                 fi
ÐTCD>         done

Nice, but I can not apply this over a git hub or a web interface without a clone.

