Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0240C11D04
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 09:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8617D24656
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 09:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBTJu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 04:50:57 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:44267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbgBTJu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 04:50:57 -0500
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5max-1jX8JZ29G7-017AUb for <git@vger.kernel.org>; Thu, 20 Feb 2020
 10:50:54 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 5169C64FB00
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 09:50:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G7HAbhd8kA1b for <git@vger.kernel.org>;
        Thu, 20 Feb 2020 10:50:53 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 7955E64F9D5
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 10:50:53 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.10.2.141) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4; Thu, 20 Feb 2020 10:50:53 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 1A4F7804E9; Thu, 20 Feb 2020 10:50:53 +0100 (CET)
Date:   Thu, 20 Feb 2020 10:50:53 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     <git@vger.kernel.org>
Subject: t3513-revert-submodule.sh (3513.8) fails sometimes
Message-ID: <20200220095053.GA8865@pflmari>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
X-Originating-IP: [10.10.2.141]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A29536F936F607565
X-Provags-ID: V03:K1:VYlIB1gOuBXjq0eroIpIsYnmOpaB2E6ZDjEwkx8TaOfp2M2bVzS
 xjDqHxAuWtVyk5a0pZobDBnDvN+WshGcUb3UhgfNkhcofnDUDMHEo/ZgIxZSzjQ5sJW+Ytg
 RWmhB1R3uYZaqUySpCGmA4vBxqolbktyHaLv0npyGUbslb0eNwTmBLNw35y0lYBWxJYERFh
 xRWhbO0nWsJFflN8sAb8g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qmy3CWtS3JU=:k4oQOyNfT040WcksnlGDRE
 JTIjvUeeuLq3eR/roVFeK53MAHa0NpjMQq7jAWcAD2TER5ZFYv0sTrCtH8jONpYuBsa8vZxOG
 w+Y+ANgIONjBQ7joVWqw1RG04GsNOrnjmkGuOqWJm7Kl4TRv4n2MdrvBtyj+st1zc0JpboiJm
 wvd1jtqDuqN6rKj0DjTSWYIf7oiHzVA+r5LZJGDu3vj6wAUduEog/4n+8RfmwleKRgdMuRBji
 u5rbEoiMZVVAtFs5+5XC1jb2eTzALzyjEc6ZafuEzZedG3dKDL9Di5TDWca7AYSveTzbAWIHy
 YcRthO5cmWy3H2JK+Rav1dReks0ax1pJ9cJLsyEJjYfA3YE3zHzCpO4/LId1pwyk/bi7twbhc
 g06IiqwiQjLmWpta9rUBGwvXxKgvnRYNmOkG6HWgM8ukMFVUChZVmNjv0unumDeazrj+yaMQw
 v0qi2CEuSPn+bEqB9nN+FnWPly2NVO739LlwrKK9GY5LhzmkV5oZyBcxq8daYWEZWV/9VhwG5
 61mbT/AjrUEuNbt+iLQdUk/tbACt/c4upQTEX7WkVAHkBuZFk0LAVhoPgBu1HWHwiru2aKutb
 yffFZBIhA3JZrWejYEajilJPW1SJ6QgS42U5YOuC5RIcSzKraPSxJegqU63kMLH6CIH2vwFfU
 UhH+ofBxS9c4L+AgCX/hZnFcAlTCTiUXDTe8P2aNZc1ENBheatDuG5HEbaqJUi6+iozAg9CCc
 TkXZvnHXraPff1gUctGzx74PSCnZA3bE9Ev4NToCzkZrpK/MnHCtKeZ0YQOPeQaKsVplrOrGe
 xeHPhhX97OFBRZwERy/ur0zkw0FPWFoKe+SjVkfmPPqfFXp3KaP4/YsLbY5pnuczNFLmlB2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

the test fails for some reason, relatively rarely (20 per 100
invocations). I could not find the why, so I'm just posting the logs
below with the full log attached.

The test has been failing here for at least a year (the logs below done with
v2.25.1).

I have a config.mak:

    USE_LIBPCRE2=YesPlease
    OPENSSL_SHA256=YesPlease

    CFLAGS += -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=1
    CFLAGS += -fstack-protector-strong
    CFLAGS += -fpie
    LDFLAGS += -z relro -z now
    LDFLAGS += -pie

There local modifications, but none in the core core (small customizations in gitk).

The file system where the test is run on is an ext4 volume (an old, but still
usable ssd). The kernel is an v5.5.3. Debian without systemd. Not a container.
Not a VM.

expecting success of 3513.8 'git_revert: replace submodule containing a .git directory with a directory must fail': 
		prolog &&
		reset_work_tree_to add_sub1 &&
		(
			cd submodule_update &&
			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
			replace_gitfile_with_git_dir sub1 &&
			test_must_fail $command replace_sub1_with_directory &&
			test_superproject_content origin/add_sub1 &&
			test_git_directory_is_unchanged sub1 &&
			test_submodule_content sub1 origin/add_sub1
		)
	
Cloning into 'submodule_update'...
done.
Branch 'add_sub1' set up to track remote branch 'add_sub1' from 'origin'.
Switched to a new branch 'add_sub1'
Submodule 'sub1' (/home/ari/compile/git/t/trash directory.t3513-revert-submodule/submodule_update_sub1) registered for path 'sub1'
Cloning into '/home/ari/compile/git/t/trash directory.t3513-revert-submodule/submodule_update/sub1'...
done.
Submodule path 'sub1': checked out '4a3c63c700bd465527a865db70efb925e380182c'
Branch 'replace_sub1_with_directory' set up to track remote branch 'replace_sub1_with_directory' from 'origin'.
error: The following untracked working tree files would be overwritten by checkout:
	sub1/file1
	sub1/file2
Please move or remove them before you switch branches.
Aborting
'actual' is not empty, it contains:
:100644 100644 587be6b4c3f93f93c489c0111bba5596147a26cb 0000000000000000000000000000000000000000 M	file1
:100644 100644 975fbec8256d3e8a3797e7a3611380f27c49f4ac 0000000000000000000000000000000000000000 M	file2
not ok 8 - git_revert: replace submodule containing a .git directory with a directory must fail
#	
#			prolog &&
#			reset_work_tree_to add_sub1 &&
#			(
#				cd submodule_update &&
#				git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
#				replace_gitfile_with_git_dir sub1 &&
#				test_must_fail $command replace_sub1_with_directory &&
#				test_superproject_content origin/add_sub1 &&
#				test_git_directory_is_unchanged sub1 &&
#				test_submodule_content sub1 origin/add_sub1
#			)
#		

Regards,
Alex

--ew6BAiZeqk4r7MaW
Content-Type: application/x-xz
Content-Disposition: attachment; filename="t3513-revert-submodule.log.xz"
Content-Transfer-Encoding: base64

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
Z/sCAAAAAARZWg==

--ew6BAiZeqk4r7MaW--
