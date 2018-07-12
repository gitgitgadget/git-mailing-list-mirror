Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD301F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeGLTGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:06:36 -0400
Received: from box.datamaskinaggie.xyz ([45.55.255.105]:33480 "EHLO
        box.datamaskinaggie.xyz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeGLTGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:06:36 -0400
X-Greylist: delayed 579 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2018 15:06:35 EDT
Received: from authenticated-user (box.datamaskinaggie.xyz [45.55.255.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by box.datamaskinaggie.xyz (Postfix) with ESMTPSA id 521CA1400A5
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 14:46:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidwbrown.name;
        s=mail; t=1531421169;
        bh=66Rwzt24edSjqaJ3XfTHrkZTvmERUNBG4L4VQJGUzXU=;
        h=Date:From:To:Subject:From;
        b=g7Vjf94RcM/8yO2mjY1TjRl8PYvvWDFyhtXTTWudpzPp7oxPKPOe9Im4v7YIEclZY
         9S3IXkdMIUHJFo8npVtTnr5AVDaIajLR6igQK3lSKVAodaEa5WJORKzP4db7njNPbL
         HMlnjY1ug4y0yOnFMN473CnWKI269wODyODMpLAP92D70kGRPPUMEN+rXbnhWNMH2b
         qOxnKqcFgoZRQYTAarA+KzUN3TRZclgMau4kdHaaH0sTFbwTFi371RwMPrlBAAfMX+
         5bmN6+gAcGw39SbmQHXfo3QUVlx6zI+4hrjj0JuL7Psfn3C8PFpbIdt0btXPszS5Vd
         wF+j9ePqH/QoQ==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Jul 2018 13:46:09 -0500
From:   David Brown <david@davidwbrown.name>
To:     git@vger.kernel.org
Subject: gitweb and Levenshtein
Message-ID: <e5903365bd8679d345bf3ca7f535070d@davidwbrown.name>
X-Sender: david@davidwbrown.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Howdy, I want to hack the getweb_make_index.perl script to create a 
string search using: 
https://github.com/git/git/blob/master/levenshtein.c.

How do i reference the compiled code?

I would like to call this routine using Java and maybe Perl.

Please advise.

Thanks.

Regards,
