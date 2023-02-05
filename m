Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339D1C61DA4
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 01:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjBEBlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 20:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBEBlA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 20:41:00 -0500
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [95.163.41.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78C819F36
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 17:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8sgMA7v8lqYlRwV3xK8IuKLCFEmdXlte4E0EM31Y6Rg=;
        t=1675561257;x=1675651257; 
        b=uZjsEtf/OnJBJ41tDSqKtL+ylVQ0Glkxcl8a5ddxNYgtJmEgmip2naNRAjuRivtywmX/III9e/WYdpq7VM6ikZKzc2AQoWOwvSeQ2O6O6ahgffpCK1CVlVAJGhrDc6ON0KuFLXJKyJDxM955/7WNrnQ46AlrzMQ2NzFezvbgwGQoKpI+10hSuwYoABy42yfG/ZGdMbaZNUdPRrgD2HyM11nxoTBmcpMDD7vbpAwJMMb/lDNz3TgIaknPE1GI23hZtNnmdQc8LIarTHzUAABPwKLmWRxRJwxxCY7zvpKFZkoX/40ltesq0KQb7V0ZLmE8KOE5vMf9BUftM4PbAx0kXQ==;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pOU1X-00DreN-2Y; Sun, 05 Feb 2023 04:40:55 +0300
Date:   Sun, 5 Feb 2023 04:41:06 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <1185159444.20230205044106@inbox.ru>
To:     Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?xJBvw6BuIFRyw6LMgG4gQ8O0bmcgRGFuaA==?= 
        <congdanhqx@gmail.com>
CC:     git@vger.kernel.org
Subject: Re: Hash for a commit sourcetree beside to a commit hash
In-Reply-To: <01dd49c1-026d-1215-dd06-02fe73ce14f8@iee.email>
References: <1798489336.20230203042837@inbox.ru> <Y9xq5VAMjzUqTb6X@danh.dev> 
  <563617028.20230203052145@inbox.ru>
  <22255406-42da-9ac3-4783-11a035877a3c@iee.email>
  <1309893232.20230203163720@inbox.ru>
  <01dd49c1-026d-1215-dd06-02fe73ce14f8@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp32.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D919194CF4FC66045B54299027B3A8306F739179B9E3A35A182A05F5380850405951B7A8AEDF759BFECC15F25E26DAF81F40D9A028DDCC94CCB1235D0FD766AA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7195F30236A8D43B4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374FBED2B83F5E00CA8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E66B9920A61D4181557952716CD724866F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE7069B8BEE518BDBBF9FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751F2CC0D3CB04F14752D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BD215BE4436AF2686A471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC4C62484918FB75633AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F790063792C412A1E28370B0D81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F0A35B161A8BF67C1262FEC7FBD7D1F5BB5C8C57E37DE458BEDA766A37F9254B7
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D345DE7771146E56B08C024D78EE5E33EABBD78A4CCF5E9ED386EDF9289886292E5E7D56EDB51645D8D1D7E09C32AA3244CAAC28F8654236D800F05E73C4D29343E9CA7333006C390A0FACE5A9C96DEB163
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojcKYJXXMOG3cc/Ip9C4RLlg==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E07E0070AE2D9DC85FECC15F25E26DAF8ED16EBA61AB7F1C458EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Philip,



Saturday, February 4, 2023, 1:39:31 AM, you wrote:

>> PO> As a 'Distributed'-VCS, cloning the repository would be the de-facto
>> PO> normal approach, otherwise you have re-invented centralised VCS ;-)
>>
>> Cloning repository is a heavy operation by downloading everything instead of search a single commit.
>> And searching at the remote does not make it a central.

PO> It's not local though ;-)
PO> Given that there's usually a trusted remote in this scenario (that's why
PO> your searching it)

I am searching it because it is a fork of many other forks.

PO> it does feel very like a 'centralised' VCS, even if
PO> formally is isn't stated as such.

It feels not. I don't see how this is connected to anything.

>>
>> PO> Alternatively, you could approach the server (hub/web interface)
>> PO> provider to see if they are willing to provide that level of search
>> PO> interface.
>>
>> The GitHub already provides that in the search field. Just input a hash and see what happens.

PO> There is still a need to walk the commit graph to discover each commit's
PO> tree to do the look-back. There are some catch 22 steps to be done.

Calculate a hash from an ordered sourcetree diff is not 22 steps.

PO> How do you determine the sourcetree has that starts this process? (have
PO> we accidentally created an XY problem?)

PO> Obliterating history is hard [1].
PO> --
PO> Philip

PO> [1]
PO> https://lore.kernel.org/git/5cab1530-f8b6-cef3-7b93-48fad410a160@iee.email/

How this related to the issue?

