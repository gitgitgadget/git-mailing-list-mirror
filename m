Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D237AC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 02:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2DF61057
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 02:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJSCgR convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 18 Oct 2021 22:36:17 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:42752 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhJSCgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 22:36:16 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Oct 2021 22:36:15 EDT
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 10AF91F14
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 10:27:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from pw (unknown [222.95.251.49])
        by smtp.263.net (postfix) whith ESMTP id P15805T140581248091904S1634610466993528_;
        Tue, 19 Oct 2021 10:27:49 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: lll@xeltek-cn.com
X-SENDER: lll@xeltek-cn.com
X-LOGIN-NAME: lll@xeltek-cn.com
X-FST-TO: git@vger.kernel.org
X-RCPT-COUNT: 1
X-LOCAL-RCPT-COUNT: 0
X-SENDER-IP: 222.95.251.49
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <6737513ca80d85e90c08ca5332fc24f6>
X-System-Flag: 0
From:   "LL L" <lll@xeltek-cn.com>
To:     <git@vger.kernel.org>
Subject: Git failed to pull after upgrading to 2.33.1, using choco
Date:   Tue, 19 Oct 2021 10:27:43 +0800
Message-ID: <001401d7c490$e7d57620$b7806260$@xeltek-cn.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfEkOU57XeKrHxNSVulsOcVhZzDFA==
Content-Language: en-us
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. uninstall git for windows 2.32.2
2. install git again with： choco install -y git
3. git pull emit error:

git@e.coding.net: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

4. I am sure it is caused by the upgrading, I observed same issue on my other windows 10 machine..

What did you expect to happen? (Expected behavior)

pull from origin;

What happened instead? (Actual behavior)

git@e.coding.net: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

What's different between what you expected and what actually happened?

It doesn't work.

Anything else you want to add:

coding:/mytex on  trunk [?]
❯ git pull
git@e.coding.net: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

coding:/mytex on  trunk [?] took 13s
❯ ssh -Tv git@e.coding.net
OpenSSH_for_Windows_8.1p1, LibreSSL 3.0.2
debug1: Reading configuration data C:\\Users\\LL L/.ssh/config
debug1: Connecting to e.coding.net [81.69.155.167] port 22.
debug1: Connection established.
debug1: identity file C:\\Users\\LL L/.ssh/id_rsa type 0
debug1: identity file C:\\Users\\LL L/.ssh/id_rsa-cert type -1
debug1: identity file C:\\Users\\LL L/.ssh/id_dsa type -1
debug1: identity file C:\\Users\\LL L/.ssh/id_dsa-cert type -1
debug1: identity file C:\\Users\\LL L/.ssh/id_ecdsa type -1
debug1: identity file C:\\Users\\LL L/.ssh/id_ecdsa-cert type -1
debug1: identity file C:\\Users\\LL L/.ssh/id_ed25519 type -1
debug1: identity file C:\\Users\\LL L/.ssh/id_ed25519-cert type -1
debug1: identity file C:\\Users\\LL L/.ssh/id_xmss type -1
debug1: identity file C:\\Users\\LL L/.ssh/id_xmss-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_for_Windows_8.1
debug1: Remote protocol version 2.0, remote software version Go-CodingGit
debug1: no match: Go-CodingGit
debug1: Authenticating to e.coding.net:22 as 'git'
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: algorithm: curve25519-sha256@libssh.org
debug1: kex: host key algorithm: rsa-sha2-512
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug1: Server host key: ssh-rsa SHA256:jok3FH7q5LJ6qvE7iPNehBgXRw51ErE77S0Dn+Vg/Ik
debug1: Host 'e.coding.net' is known and matches the RSA host key.
debug1: Found key in C:\\Users\\LL L/.ssh/known_hosts:28
debug1: rekey out after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: rekey in after 134217728 blocks
debug1: pubkey_prepare: ssh_get_authentication_socket: No such file or directory
debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_rsa RSA SHA256:SzTwSmfmiLOTlZGuTIhP2VctForj8wVH866bFSWWLH0
debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_dsa
debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_ecdsa
debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_ed25519
debug1: Will attempt key: C:\\Users\\LL L/.ssh/id_xmss
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: publickey
debug1: Next authentication method: publickey
debug1: Offering public key: C:\\Users\\LL L/.ssh/id_rsa RSA SHA256:SzTwSmfmiLOTlZGuTIhP2VctForj8wVH866bFSWWLH0
debug1: Server accepts key: C:\\Users\\LL L/.ssh/id_rsa RSA SHA256:SzTwSmfmiLOTlZGuTIhP2VctForj8wVH866bFSWWLH0
debug1: Authentication succeeded (publickey).
Authenticated to e.coding.net ([81.69.155.167]:22).
debug1: channel 0: new [client-session]
debug1: Entering interactive session.
debug1: pledge: network
CODING 提示: Hello eyl, You've connected to coding.net via SSH. This is a Personal Key.
eyl，你好，你已经通过 SSH 协议认证 coding.net 服务，这是一个个人公钥.
公钥指纹：e9:6c:54:c8:72:42:36:ac:b2:29:7e:ad:b1:a5:09:42
debug1: client_input_channel_req: channel 0 rtype exit-status reply 0
debug1: channel 0: free: client-session, nchannels 1
Transferred: sent 2624, received 1924 bytes, in 1.5 seconds
Bytes per second: sent 1791.8, received 1313.8
debug1: Exit status 0

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.33.1.windows.1
cpu: x86_64
built from commit: 05d80adb775077d673fab685009ede4a1003ed92
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 19044 
compiler info: gnuc: 10.3
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]



