Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11686C4363D
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 16:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABE72084C
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 16:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIVQAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 12:00:11 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:32804 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVQAL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 12:00:11 -0400
Received: from [192.168.1.58] ([2.10.73.184])
        by mwinf5d16 with ME
        id X4072300B3yZrnE03407YD; Tue, 22 Sep 2020 18:00:07 +0200
X-ME-Helo: [192.168.1.58]
X-ME-Auth: ZnJhbmNpcy5hbmRyZS5rYW1wYmVsbEBvcmFuZ2UuZnI=
X-ME-Date: Tue, 22 Sep 2020 18:00:07 +0200
X-ME-IP: 2.10.73.184
To:     git@vger.kernel.org
From:   Francis ANDRE <francis.andre.kampbell@orange.fr>
Subject: git-filter-repo on Windows
Message-ID: <8345312a-40aa-b582-50d7-714b8f518ecc@orange.fr>
Date:   Tue, 22 Sep 2020 18:03:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git people

Since I understood that the git-filter-repo is now recommanded by Git to 
replace git-filter-branch, I am trying to use it on Windows 10 under a 
DOS window. The installation and use of this git-filter-repo is really a 
nigthmare on DOS Win10. As there is a git-for-windows specific 
installation, could you make also an installation a little bit more 
Window oriented?


C:\Users\fandre\Documents\MXW\MI\release>git filter-repo --analyse
/usr/bin/env: 'python3': Permission denied

C:\Users\fandre\Documents\MXW\MI\release>git filter-repo --analyse
/usr/bin/env: 'python': Permission denied

C:\Users\fandre\Documents\MXW\MI\release>where python3
C:\Users\fandre\AppData\Local\Microsoft\WindowsApps\python3.exe


Same with a git-bash window:

FAE@FANDRE-LAPTOP MINGW64 ~/Documents/MXW/MI/release (release)
$ git filter-repo --analyse
/usr/bin/env: 'python': Permission denied

FAE@FANDRE-LAPTOP MINGW64 ~/Documents/MXW/MI/release (release)
$ ls -l /c/Users/fandre/AppData/Local/Microsoft/WindowsApps/python
-rwxr-xr-x 1 FAE 1049089 0 Sep 22 10:59 
/c/Users/fandre/AppData/Local/Microsoft/WindowsApps/python*

$ env | grep USER
USERDOMAIN=METRIXWARE
USERNAME=FAE
USERPROFILE=C:\Users\fandre
USERDOMAIN_ROAMINGPROFILE=METRIXWARE
FPS_BROWSER_USER_PROFILE_STRING=Default
USERDNSDOMAIN=METRIXWARE.LOCAL
ALLUSERSPROFILE=C:\ProgramData
UIPATH_USER_SERVICE_PATH=C:\Users\fandre\AppData\Local\UiPath\app-20.4.3\UiPath.Service.UserHost.exe

Regards

