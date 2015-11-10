From: "Ryabov, Vasily V" <vasily.v.ryabov@intel.com>
Subject: [bug] git 2.6.2 (64-bit) blocks keyboard input (running in RDP,
 Win7 x64)
Date: Tue, 10 Nov 2015 14:02:22 +0000
Message-ID: <D28D2D5A78DB8B49BB75DB10E72239683ABA1700@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 15:02:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zw9VJ-0007wC-DU
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 15:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbbKJOCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 09:02:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:30747 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbbKJOCX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2015 09:02:23 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP; 10 Nov 2015 06:02:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,270,1444719600"; 
   d="scan'208";a="597562066"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Nov 2015 06:02:22 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.251]) by
 irsmsx110.ger.corp.intel.com ([169.254.15.163]) with mapi id 14.03.0248.002;
 Tue, 10 Nov 2015 14:02:22 +0000
Thread-Topic: [bug] git 2.6.2 (64-bit) blocks keyboard input (running in
 RDP, Win7 x64)
Thread-Index: AdEbwFFCHwseOB+ZR1e7k4rymJ8q8Q==
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.180]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281123>

     Hi,

I'm trying to run something like this (on the remote machine (Win7 x64 with git 2.6.2 64-bit) through RDP):
```
git pull --tags --progress ssh://<username>@<repo_URL>:<tcp_port>/<repo_name> +refs/heads/*:refs/remotes/origin/*
```
It worked on local machine with git 1.9.5.

Git asks to confirm an action:
```
The server's host key is not cached in the registry. You
have no guarantee that the server is the computer you
think it is.
The server's dss key fingerprint is:
ssh-dss 1024 <...>
If you trust this host, enter "y" to add the key to
PuTTY's cache and carry on connecting.
If you want to carry on connecting just once, without
adding the key to the cache, enter "n".
If you do not trust this host, press Return to abandon the
connection.
Store key in cache? (y/n)
```
I'm typing `y`, but there is no reaction at all. No symbols appears in the console. But...
When I'm pressing `Ctrl+C`, it's killed. And I can see `yyyyy` keys in the bash console for the next command.

On-screen keyboard didn't help as well.

I've already tried several combinations of `MinTTY` and `Windows cmd.exe` check boxes in the installer. Nothing helped.
It looks like a bug in Git client.

Best regards,
-Vasily.

--------------------------------------------------------------------
Joint Stock Company Intel A/O
Registered legal address: Krylatsky Hills Business Park,
17 Krylatskaya Str., Bldg 4, Moscow 121614,
Russian Federation

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
