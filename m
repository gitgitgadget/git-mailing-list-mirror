Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C3F1F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbeBIL3V convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 9 Feb 2018 06:29:21 -0500
Received: from smtppost.atos.net ([193.56.114.164]:32071 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeBIL3U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:29:20 -0500
X-Greylist: delayed 435 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Feb 2018 06:29:19 EST
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost5.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 5f99_76a1_304cd36c_65f2_44d1_8d38_42ca3fa04139;
        Fri, 09 Feb 2018 12:22:01 +0100
Received: from mail1-int.my-it-solutions.net ([10.92.32.11])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w19BM1AJ026450
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Fri, 9 Feb 2018 12:22:01 +0100
Received: from DEFTHW99ETTMSX.ww931.my-it-solutions.net ([10.86.142.101])
        by mail1-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w19BLuGN016524
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Fri, 9 Feb 2018 12:21:56 +0100
Received: from DEERLM99EX2MSX.ww931.my-it-solutions.net ([169.254.2.222]) by
 DEFTHW99ETTMSX.ww931.my-it-solutions.net ([10.86.142.101]) with mapi id
 14.03.0361.001; Fri, 9 Feb 2018 12:21:56 +0100
From:   "Fechter, Juergen" <juergen.fechter@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Issue: Git Gui: show ssh key don't show key type id_ed25519.pub
Thread-Topic: Issue: Git Gui: show ssh key don't show key type id_ed25519.pub
Thread-Index: AdOhmBPXmGKkjCZoQnC+ke1VDA/hXA==
Date:   Fri, 9 Feb 2018 11:21:56 +0000
Message-ID: <F65780F29E48994380E2BCE87C6F071101146AB1@DEERLM99EX2MSX.ww931.my-it-solutions.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.86.142.15]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Maybe someone can fix this issue.
Thanks

Git Gui: show ssh key don't show key type id_ed25519.pub
Setup
. Which version of Git for Windows are you using? Is it 32-bit or 64-bit?
$ git --version --build-options

** 2.16.1windows.2 **

. Which version of Windows are you running? Vista, 7, 8, 10? Is it 32-bit or 64-bit?
$ cmd.exe /c ver

** Microsoft Windows [Version 10.0.16299.214] **
. What options did you set as part of the installation? Or did you choose the
defaults?
# One of the following:
> type "C:\Program Files\Git\etc\install-options.txt"
> type "C:\Program Files (x86)\Git\etc\install-options.txt"
> type "%USERPROFILE%\AppData\Local\Programs\Git\etc\install-options.txt"
$ cat /etc/install-options.txt

** insert your machine's response here **
. Any other interesting things about your environment that might be related
to the issue you're seeing?
** insert your response here **
Details
. Which terminal/shell are you running Git from? e.g Bash/CMD/PowerShell/other
** insert your response here **
. What commands did you run to trigger this issue? If you can provide a
http://stackoverflow.com/help/mcve
this will help us understand the issue.
** insert your commands here **
. What did you expect to occur after running these commands?
** insert here **
. What actually happened instead?
** insert here **
. If the problem was occurring with a specific repository, can you provide the
URL to that repository to help us with testing?
** insert URL here **
Description
Under ~/.ssh are only one ssh key pair of type ed25519
( id_ed25519 and id_ed25519.pub)
Git GUI don't show it
C:\Users\goldfinger2\.ssh>dir /b
agent.env
authorized_keys
id_ed25519
id_ed25519.pub
Win32-OpenSSH Beta currently supports only one key type (ed25519).
https://github.com/PowerShell/Win32-OpenSSH/issues/973
https://blogs.msdn.microsoft.com/powershell/2017/12/15/using-the-openssh-beta-in-windows-10-fall-creators-update-and-windows-server-1709/
Steps to Reproduce
1. Open Git Gui
2. Select Help
3. Show SSH Key : No Keys found
Expected behavior: Showing the ed25519 Key
Reproduces how often: 100%
Additional information
The problem is located in the find_ssh_key function in sshkey.tcl.
Which is not searching after id_ed25519.pub
find_ssh_key {} {

        foreach name {~/.ssh/id_dsa.pub ~/.ssh/id_rsa.pub ~/.ssh/identity.pub} {

>> This looks like a problem in upstream Git GUI. Would you mind reporting this to the Git mailing list at git@vger.kernel.org? 
>> Or even better, write the patch yourself? ;-) This looks like a problem in upstream Git GUI. 
>> Would you mind reporting this to the Git mailing list at git@vger.kernel.org? Or even better, write the patch yourself? ;-) 

