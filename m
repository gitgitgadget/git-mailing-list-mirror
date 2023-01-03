Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFB1C3DA7D
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 15:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbjACPIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Jan 2023 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjACPI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2023 10:08:27 -0500
Received: from fallback19.mail.ru (fallback19.mail.ru [185.5.136.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D04BE016
        for <git@vger.kernel.org>; Tue,  3 Jan 2023 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=7n628QCE00JUwJHjnZuAYgy2TRXVRZy5fDqYaQBlIDg=;
        t=1672758503;x=1672848503; 
        b=XAjTQqKOWrsUOL6nlFEcot6eelOa9N0dHgxsRP440IqU1NDZZz3RRhpB1bnq9NsZ7/A5mslJFKStkHSPxUb/yoDMxFUMq+oKniIn0cSdMnSVDK5cth7Ak22hIQQDON5n84zU/Q33xhNcNOW7aLOA6Q16SvU5wToUeuJGHlWDG20=;
Received: from [10.161.64.56] (port=47036 helo=smtp48.i.mail.ru)
        by fallback19.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1pCitp-0000Fp-35
        for git@vger.kernel.org; Tue, 03 Jan 2023 18:08:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=7n628QCE00JUwJHjnZuAYgy2TRXVRZy5fDqYaQBlIDg=;
        t=1672758501;x=1672848501; 
        b=152jQsjxCacOW/6gXbSFwMq3snx/ixrqnZAl92+9ZHTtUK78/AhB3627dYFD2y/JVhRwkfOang57euv0CAz9U4ppNKUQCFVZPGd39+qfqQY7lGDqFstlvTQg6hTv8vQlSUAEK8PimMdDerMLEaWH3fC3q2f18ku5MimzigIzGc8=;
Received: by smtp48.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1pCitl-0007dS-3f
        for git@vger.kernel.org; Tue, 03 Jan 2023 18:08:17 +0300
Date:   Tue, 3 Jan 2023 19:08:14 +0400
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     git@vger.kernel.org
Subject: Re: Request to remove Junio C Hamano as the Git Maintainer
Message-ID: <20230103150814.neevxs7trmzfbi67@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
 <064601d91f0e$b5521940$1ff64bc0$@abilitybusinesscomputerservices.com>
 <d84712ed-1504-4d54-a664-63713db570b6@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84712ed-1504-4d54-a664-63713db570b6@iee.email>
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD90D1502B3BE350FE4F8891610AF87FABCF509A241B98FBB8900894C459B0CD1B9B84BBC3C7E18977884D99009088BD52C65860B9FB6A06202F618F6F9AC73237B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A8325FA649D0A450EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373D58C44ED3182E498638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D87CFE039C2B806F0B901312BA9B88B3E1117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC8C7ADC89C2F0B2A5A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520902A1BE408319B29BDFBBEFFF4125B51D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE902A1BE408319B2996C9B5BF839F39F6D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE367F1C1C3ABB44F3A6E0066C2D8992A16C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637F765F39FA4E70FFE43847C11F186F3C59DAA53EE0834AAEE
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34C5CF6F4B28551E3FA19E395D92852390153E6014868363D5D3351F92F0B800BBD81D6D12370EC7EC1D7E09C32AA3244CEC05D763F9F7352D9CF3F0E4EBC6AB381DD47778AE04E04D3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojhI1t+zkomj8Pz24XAzn2Zg==
X-Mailru-Sender: 53225E476262CDFB75EED519089A6785A42DBC2E0E37C9C5639A528A0DA11DD21068CCE1DAF2B76B13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B41CF11DA7185A12D6AD7DD622C933E1B80D7E8AE6AB738DD868F3CF0E9FE49B6953CDA344A884A1E26BE1BB80DD66555277C7A9B39BC2F88EEFB0F98C01069970
X-7FA49CB5: 0D63561A33F958A5EB2EF619C41926EE12FEE4E428DF07CDB687D752F9FE62218941B15DA834481FA18204E546F3947CE3786DD2C77EBDAAF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063738CA231DD84B2BC5389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637DDF5CD7B9F40093CD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CD1D040B6C1ECEA3F43847C11F186F3C59DAA53EE0834AAEE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojhI1t+zkomj9HA+nJqwHF1Q==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2023 at 01:25:12PM +0000, Philip Oakley wrote:

[...]
> However, what Linus managed to do was to cut the Gordian Knot of the
> historical versioning systems that had their original designs created in
> the quill pen era, and are totally unsuited for the modern, high speed
> computation and perfect replication digital age. Finally, I have control
> over my versioning system (at least for software)!
[...]

Being pedantinc, Git was reasonably late to the party of the distributed VC
systems, and if not for that BitKeeper controversy, who knows whether we would
have Git at all ;-)

Still, while I do not think that Git is where it is today only due to its
technical properties, these properties are what made it got its initial
traction, I suppose. The design is sound and is appealing as that of Unix.

