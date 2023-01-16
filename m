Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6837CC67871
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 07:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjAPHVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 02:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjAPHVc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 02:21:32 -0500
Received: from mail.turbocat.net (turbocat.net [IPv6:2a01:4f8:c17:6c4b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23396A78
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 23:21:31 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 9860D260BB4;
        Mon, 16 Jan 2023 08:21:29 +0100 (CET)
Message-ID: <02e6b8f4-ac5f-fdf5-cea8-58013a3f693d@selasky.org>
Date:   Mon, 16 Jan 2023 08:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
 <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/23 00:59, brian m. carlson wrote:
>> 3) Illicit contents may be present in binary blobs, which in the future may
>> be need to be removed without warrant and the only way to do that is by
>> rebasing and force pushing, which will break "everything". It can be
>> everything from child-porn to expired distribution licenses.
> This is a problem in every Merkle tree-like system.  Most repositories
> have some sort of code review or access control that prevents people
> from generally pushing inappropriate content.  For example, if somebody
> proposed to push any sort of pornography or other inappropriate content
> (e.g., a racist screed) to one of my repositories or one of my
> employer's, I'd refuse to approve or merge such a change, because
> that wouldn't be appropriate for the repository.
> 
> I don't feel this is enough of a problem that using a Merkle tree-like
> construction is a bad idea, given the benefits it offers.
> 

Yeah, right. And of course you have all the tools to decode those 
megabyte big firmware blobs from intel supporting wireless cards all 
over the place to see what is actually inside there, that they are not 
using some 3rd party code which licence will expire at some point, and 
then you need to remove those binaries.

--HPS
