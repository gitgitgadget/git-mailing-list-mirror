Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD22B2021E
	for <e@80x24.org>; Sat, 12 Nov 2016 17:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966670AbcKLR4O (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 12:56:14 -0500
Received: from wilbur.contactoffice.com ([212.3.242.68]:59391 "EHLO
        wilbur.contactoffice.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbcKLR4M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 12:56:12 -0500
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Nov 2016 12:56:12 EST
Received: from ichabod.co-bxl (ichabod.co-bxl [10.2.0.36])
        by wilbur.contactoffice.com (Postfix) with ESMTP id 03E09C085
        for <git@vger.kernel.org>; Sat, 12 Nov 2016 18:49:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailfence.com;
        s=20160819-nLV10XS2; t=1478972997;
        bh=VjOS5rsfQeAhrgGn6AxjGRmrVRGjkxpWuvLBv4gIWz4=;
        h=Subject:Reply-To:From:To:Date:From;
        b=CveS9UPAAaPCTmppc0U3Vo5EDFUKEA1L7QyHodSXOg1RLWV9PiclGzNVi8ZmB4c8q
         mRJVQHjirRcm3iigX4acCaffBI1mk1KGZwMxDxFwhYu12Z3dMZ50TKO0F0TBQ+YXdA
         u/uSmy0dzm9NcXnxtHPBRToopf2Ahe8VNeeE1roX37+Boqf5+mORBu70YDWWYNt/vA
         1PPnBsKnxNPlVxqSjTvwmatFp7HPpIr5RKUf0gViY0GevBzT9VvrxMcp53pHwjJbXG
         j8bkuTvKk4CY55nnOZ2enuLetbt5p4GvVvmGA/VoQqlfG1qnIkv5zB7w9HJVnqCefF
         LZc9lUbeHSevg==
Message-ID: <284668531.626.1478972994238.JavaMail.root@ichabod>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Feature request - show result of URL rewrites
X-Priority: 3
Reply-To: Git User <git.user@mailfence.com>
From:   Git User <git.user@mailfence.com>
To:     git@vger.kernel.org
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:95587084
Date:   Sat, 12 Nov 2016 18:49:54 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

Hopefully this is the right place to submit feature requests - let me know if there's somewhere else I should use!

Git lets you rewrite URLs using "url.<base>.insteadOf"

https://stackoverflow.com/a/11383587
https://git-scm.com/docs/git-config

Can you add a git-config option to show the result of this rewriting whenever this occurs, as debugging more complicated rules can be difficult/wasn't obvious without Wireshark.

E.g. you could have the option 'url.printRewrites [True/False]' which would print the line "Rewrote url 'git://github.com/git/git' to 'https://github.com/git/git'" to terminal/stdout  when set to True.

Thanks
