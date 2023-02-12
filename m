Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52DBC636D3
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 13:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBLN1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 08:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjBLN1b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 08:27:31 -0500
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F85E39A
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 05:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=IzSa+FhQt6UXCrjpuPDT0OhAUyV9TCKrkE/+XOUImCM=;
        t=1676208448;x=1676298448; 
        b=gROGEFVbih40lEtZWCfZz1YxVNDbK9X9IPEiyF6GEGQa2p3wvZOvo7AD9QYtx3IDiyoBIooQ3Ok2cQP9qhn4F9jC8WsyClpAexVlX3LTSwUArEPYXKdoeghARk+sjYpDSivK+wlqKWl4MpSI8xjzT+FaHTNZknuB+Jvd/Se6k1y535Pn3y7zMg5M9aJuwtwpvc95ci3AUrLBxnYYCUKi/BIex6Bndd3IlcY1am48jwzX7Xeg4gx2ySCuBcnL8cjblpvT5CdhCuTm3XOIpR9Dhgq/5Dpj5SoDHDnKh+4SUsO3h8nbUmDsfU+9xXPX5LKeTDKByEKbGa85Lau7C2WhVA==;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pRCO6-003q3t-6v
        for git@vger.kernel.org; Sun, 12 Feb 2023 16:27:26 +0300
Date:   Sun, 12 Feb 2023 16:27:59 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <7910309440.20230212162759@inbox.ru>
To:     git@vger.kernel.org
Subject: Re: Hash for a commit sourcetree beside to a commit hash
In-Reply-To: <1798489336.20230203042837@inbox.ru>
References: <1798489336.20230203042837@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp39.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D919194CF4FC6604BDCFF1ECAF5FB1B47418EB9CEC5E82E1182A05F538085040CB8F2B539A98AF0AB93232DCA194ECE7D9F330D712E2E74130A1381B58F2E3C4
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70CB15FA6C489297DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373880C950E4B364568638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82C8B71F4A565B5312980F0C5C501B2D86F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7A46ADF0C403417779FA2833FD35BB23D9E625A9149C048EE140C956E756FBB7A28451B159A507268D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BED943DBD20860CC2A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC094096F05B5C7A103AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F7900637F8DB709AF5FDCF73D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F0A35B161A8BF67C1CE5475246E174218B5C8C57E37DE458BEDA766A37F9254B7
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34F0A5F58274334C95EFAE6B7C7C5DC7253BEA5317E427B2D7505EA297FB423FE895C37701B21A37EB1D7E09C32AA3244CFE37036D2B5AEAA069493DE864F368F960759606DA2E136A3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojukIRxTCPvFsM7+8iggw8Tw==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E2DA11276DDB76B71B93232DCA194ECE7EEB408C63A03954D58EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,



Friday, February 3, 2023, 4:28:37 AM, you wrote:

A> Hello Git,

A> Is there a chance to add this property to a commit and a set of commands, for example, to search a commit by a sourcetree hash?

I've suddenly found another interesting ability of such hash. It could may restore a commit submodule add/update reference hashes to submodule commits after submodule repo rewrite.

Lets say you have 2 repositories.

```
[Repo A] of Owner A

  ...
  |
  Commit A1
  | |
  | +-- submodule add/update hash B1
  |
  Commit A2
  | |
  | +-- submodule add/update hash B2
  |
  ...

[Repo B] of Owner B (submodule to A)

  ...
  |
  Commit B1
  |
  Commit B2
  |
  ...
```

If owner of [Repo B] would try to rewrite repository because, for example, of a mistake in the commit author email address,
then [Repo A] becomes broken and will reference invalid hashes.
Hard to rewrite hashes in [Repo A] because of unrelated histories and tricky algorithm with the hash mappings.

But if add a second hash into a commit property as hash of an ordered sourcetree diff, then
we can automatically map such hashes even in unrelated histories.
Because basically a commit hash changes because of change in a commit properties instead of in the source tree.
And even a change in source may not lead to trigger changes in following commits because depends on the context and
the sources intersection (including source movement).

So the git could suggest with these hashes a semi automatic merge even if a repo was rewriten.
Of cause this needs additionally to detect changes in all properties to show to the user before semi automatic merge.

In case of [Repo A] it just needs to add second hash into [repo A] submodule add/update and now you can rewrite [Repo A]
through the mapping by ordered sourcetree diff hash.

