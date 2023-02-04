Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB90BC636CD
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 04:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjBDEuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 23:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjBDEuW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 23:50:22 -0500
X-Greylist: delayed 95365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 20:50:20 PST
Received: from smtp55.i.mail.ru (smtp55.i.mail.ru [217.69.128.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACBC611F9
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 20:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=6b5SivQG0/EMquL3afmPK6NF/e7BHjkBnzwZsms+tEw=;
        t=1675486220;x=1675576220; 
        b=kHFcBQFVT2G5uDNPwRQ/1WBUB3tTVE6vcidGEWUhWgrdua9ccJYbFVzUIq4xghAsWAAQb1WWS4vW9/w8ofM2vSVzjNycHIEN/9xHevraX6MsL+Iay+wq19cJ0DvX36VeQVS2pKcZMnkcIa3zdtHdEWyK+9fl9cIQaMiMItcUSfXACJk24N1Q2o9m0r5mHODkXS5PAmNIzGxSc/MSH5bWc97ynQB4vdpsgjMUiRUayis7c0SnROJ5B6NiZAx15hz76O3F9mx2eIfHsCSzCPyOI1/+aN3fdj2VtfM/cJUPPFvg63DrGtTn5Kj7/Gk8U0fBBcQDZ/SyIi3Dahdzve25eg==;
Received: by smtp55.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pOAVF-000102-4h; Sat, 04 Feb 2023 07:50:17 +0300
Date:   Sat, 4 Feb 2023 07:50:23 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <1196589662.20230204075023@inbox.ru>
To:     =?windows-1258?Q?=D0o=E0n_Tr=E2=CCn_C=F4ng_Danh?= 
        <congdanhqx@gmail.com>
CC:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Subject: Re: Hash for a commit sourcetree beside to a commit hash
In-Reply-To: <Y90lBJ8b5nCUcLv2@danh.dev>
References: <1798489336.20230203042837@inbox.ru> <Y9xq5VAMjzUqTb6X@danh.dev> 
  <563617028.20230203052145@inbox.ru>
  <22255406-42da-9ac3-4783-11a035877a3c@iee.email>
  <1309893232.20230203163720@inbox.ru> <Y90lBJ8b5nCUcLv2@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1258
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp55.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D919194CF4FC6604A01E0973C23BD86EDECBF287589C38D0182A05F538085040E012EB6EE602F6386EC57D8697490B125E4848A4054A0745039E841931D76EE7
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78AC0750F3304E924EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375F0BD5CF353A411D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8094E27E9A3ABFD38507D13A7F25050D76F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE767883B903EA3BAEA9FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18618001F51B5FD3F9D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8B0FC4FCDDD36A1EE6A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC092BEC5799CCA3073AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F790063792C412A1E28370B0D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F0A35B161A8BF67C157739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34E318F287A436F24C13F1ACE6BAD29D6812940AB7A7CE07C4F472A7524A0B1A39559362ED6B64B2B01D7E09C32AA3244C81343E4F566D8E879C99BFAB5C538BB9C86C126E7119A0FEFACE5A9C96DEB163
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojdzjlIIgnltbJb21nNL3NXw==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E3A1282C41107AC386EC57D8697490B1201E239FE924D908858EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Ðoàn,



Friday, February 3, 2023, 6:15:16 PM, you wrote:

ÐTCD> On 2023-02-03 16:37:20+0300, Andry <andry@inbox.ru> wrote:
>> Hello Philip,
>> >> Nice, but I can not apply this over a git hub or a web interface without a clone.
>> 
>> PO> As a 'Distributed'-VCS, cloning the repository would be the de-facto
>> PO> normal approach, otherwise you have re-invented centralised VCS ;-)
>> 
>> Cloning repository is a heavy operation by downloading everything
>> instead of search a single commit.

ÐTCD> You can limit the download with "git clone --filter=tree:0"
ÐTCD> which only fetch the commit but not any tree or file contents.

And what next? You still need to download something to see.
Better to start search in the remote anyway, because, for example, it is someone's else repository you don't want to download at all until you find something.
This is how it works in first place - you search something to start download, instead of to download at first to search something.

