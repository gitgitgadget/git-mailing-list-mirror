Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4FAC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 18:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGUSBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGUSBU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 14:01:20 -0400
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [94.100.177.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DACE8AB34
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=3N4huf1bQeTcGuDU60oB8WFzLtKWAy8Up+F7L6wLxKw=;
        t=1658426479;x=1658516479; 
        b=ySRGPOMtOVR9QPcfVYlziqaf8zwlfhX75JuVeb4NCXeKWWbBmyhb3ve4SiW+euZihvgs/DbUua4CoNmkEeGy039ttkMg9ueIe9efYnTDsRrf6LKDzRTY6NJU7WJOwQPwh6cGYt+OmlaDjNzEBSBTd1LVgMhXEF6aerlz38/G+5E=;
Received: by smtp42.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1oEaU7-0002U0-L1; Thu, 21 Jul 2022 21:01:16 +0300
Date:   Thu, 21 Jul 2022 21:01:14 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Yuri <yuri@rawbw.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What is the URL of git's bug tracker?
Message-ID: <20220721180114.xruauebr3sbhd5pm@carbon>
References: <a5f48218-94ad-195e-97bc-b29c4a588903@tsoft.com>
 <20220721101948.2i3nyroxrexg4voi@carbon>
 <98dc2e8e-58b6-80ad-65da-2bd1cc5dffc2@tsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98dc2e8e-58b6-80ad-65da-2bd1cc5dffc2@tsoft.com>
Authentication-Results: smtp42.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD97CF746166DCF1A14175DB02E8104EEF6DD7BCBC51A1D3769182A05F538085040FB3B6A0CC338FDC9E847018880549B1E86C47754ED4DE6BBFA7B540623652973
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77E216A0E97507353EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063745476ED688D943148638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E7C2744839A4BC01153B96E2A0752186117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCC493A577044FAF45A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FC26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE902A1BE408319B298FBB52F5C7ECD1BBD8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE3AD74539164518AE5302FCEF25BFAB345C4224003CC836476EA7A3FFF5B025636E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006371F24DFF1B2961425731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E142185AC9E3593CE4B31AB1881A6453793CE9274300E5CE05BD4401A9E91200F654B08B38D1BE91256DA7FA8BF14A15ACDE885CDBB0B204FCC5BB65062D4210B136E09C2B6934AE262D3EE7EAB7254005DCED8DA55E71E02F9FC08E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34AC632F0BE69382F3B5A3EBC6286684048F1930118152D2936F9C0E1F99475D85B664D2A94EB83D7D1D7E09C32AA3244C1415CC607CCCBDE2F9DC95A983EB347E33C9DC155518937FFACE5A9C96DEB163
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj3bHwMIIbugyLewBpvSOq8g==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1387FFEEF6EEFDB8A18D987450BFCBBFF61D13F9F2D60A37E3C13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 09:49:22AM -0700, Yuri wrote:

[...]

> On 04-09-2021 I reported to this ML the bug that git-2.31.0 printed stray
> messages during 'git stash push' command.

Looks like it's [1].

[...]
> Now in git-2.37.1 this bug is still there,
> Is it forgotten about? Is the fix planned? Is it fixed but not yet released?
> 
> It's impossible to say without a bug tracker.

Well, I'm going to share your pain on this but honestly, from personal
experience with F/OSS, I can say that a conventional bug tracker is not going
to help much in cases like yours: if this problem has been filed as an issue
the only things it would gain is some ID attached and a web page available.
I mean, it would not somehow move it closer to getting fixed - simply due to
the apparent lack of interest among those familiar with the code.
Hence at best it would just sit there, and at worst - closed by some bot due
to lack of activity.

By the way, if you're interested you could search the ML archives for past
discussions of this topic. For an example, see [2].


 1. https://public-inbox.org/git/e493ca9b-c686-68ea-cd8d-c7b13766d65e@rawbw.com/
 2. https://lore.kernel.org/git/211023.861r4ck8jw.gmgdl@evledraar.gmail.com/

