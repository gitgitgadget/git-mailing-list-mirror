Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C90C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 13:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbjBCNhC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 08:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjBCNg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 08:36:59 -0500
Received: from smtp39.i.mail.ru (smtp39.i.mail.ru [95.163.41.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C367C23660
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 05:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=8HLxVYxH6iLSc+1sjGs8zWZ83sX8An0Iz4OW20TKh3I=;
        t=1675431416;x=1675521416; 
        b=l3/6UOhcY4jK5wSQRwIxKwS943Kmyw58jf73+I5yAWIVkEiAgUSr9HhHLcUXKapTv4vIKrRv1ttEJ75CucVSGSLFwN6Q69OFdBypuBwERsUIzqTOkV9S3i95rE7LDaWpKLxuAyo+LgnrFH1Fq7PdKWq7RHGmD1iRNMb5nYDCHQhZnHpm5tLDaGzDxRp86rny3CmM62pq+D00cTZAxOV05WGx/3AOT3J62Gb/GPgTyqUXDk33DXzBr/fDZwJeV4mfk1cwLfhQ6HoC8xOD/uXPrJqniuh5rO6kbqvmsDNangNfLEkpkt/9wSX6Je5aVJhwWX7j4WRRvQgZkYdEbjPSjw==;
Received: by smtp39.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pNwFJ-001CqC-RE; Fri, 03 Feb 2023 16:36:54 +0300
Date:   Fri, 3 Feb 2023 16:37:20 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <1309893232.20230203163720@inbox.ru>
To:     Philip Oakley <philipoakley@iee.email>,
        =?utf-8?B?xJBvw6BuIFRyw6LMgG4gQ8O0bmcgRGFuaA==?= 
        <congdanhqx@gmail.com>
CC:     git@vger.kernel.org
Subject: Re: Hash for a commit sourcetree beside to a commit hash
In-Reply-To: <22255406-42da-9ac3-4783-11a035877a3c@iee.email>
References: <1798489336.20230203042837@inbox.ru> <Y9xq5VAMjzUqTb6X@danh.dev> 
  <563617028.20230203052145@inbox.ru>
  <22255406-42da-9ac3-4783-11a035877a3c@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp39.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9D919194CF4FC6604027E7E5960EA16BDC088668DE29F56AE182A05F5380850403D8952C0F3FC8A0922F7A71D63E4B08151620A77A9D7ECCAAC1DF38BF399E716
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE712EB008F780777E9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F10563012BA5CCB0EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B6F1F7B995052D5CE23FD6BB74FE599362E49A4D2C29F612D20879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0DEC8C2C8BCD2534D8941B15DA834481FA18204E546F3947CC2B5EEE3591E0D35F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F1F33655BFBB40449FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE731018C22CFFFF913D32BA5DBAC0009BE395957E7521B51C20BC6067A898B09E4090A508E0FED6299176DF2183F8FC7C0E3E3FB6EC827F0A0CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6816F06BAE7E44B0A089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34D9DC20663B80603F2A783E4EE0F2408920C6425F9BC741BC6CA873A8447A243EE7E71962896BFCD61D7E09C32AA3244C7C840B5EF41777A35343CCA0B1004AF8F522A1CF68F4BE05FACE5A9C96DEB163
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojdzjlIIgnltbTfmWpO/J01w==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14E83C4332ABCAC642022F7A71D63E4B081EA31111DDB2986FB58EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Philip,



Friday, February 3, 2023, 2:11:19 PM, you wrote:

PO> On 03/02/2023 02:21, Andry wrote:
>> Đoàn, 
>> Friday, February 3, 2023, 5:01:09 AM, you wrote:
>> ĐTCD>         git rev-list <a-commit-tish> |
>> ĐTCD>         while read commit; do
>> ĐTCD>                 if test $(git rev-parse $commit^{tree}) = $hash; then
>> ĐTCD>                         echo $commit
>> ĐTCD>                         break
>> ĐTCD>                 fi
>> ĐTCD>         done
>>
>> Nice, but I can not apply this over a git hub or a web interface without a clone.

PO> As a 'Distributed'-VCS, cloning the repository would be the de-facto
PO> normal approach, otherwise you have re-invented centralised VCS ;-)

Cloning repository is a heavy operation by downloading everything instead of search a single commit.
And searching at the remote does not make it a central.

PO> Alternatively, you could approach the server (hub/web interface)
PO> provider to see if they are willing to provide that level of search
PO> interface.

The GitHub already provides that in the search field. Just input a hash and see what happens.

