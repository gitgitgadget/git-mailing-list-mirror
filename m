X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: SungHyun Nam <goweol@gmail.com>
Subject: t1300-repo-config.sh failed on CYGWIN
Date: Wed, 20 Dec 2006 11:37:32 +0900
Message-ID: <4588A1EC.7040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 02:37:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
X-Enigmail-Version: 0.94.1.2
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34899>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwrKu-0001hX-QT for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964790AbWLTChi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWLTChi
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:37:38 -0500
Received: from relaygw1.kornet.net ([61.74.75.196]:35439 "EHLO
 relaygw1.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964790AbWLTChh (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 21:37:37 -0500
Received: from [211.48.62.136] ([211.48.62.136])  by relaygw1.kornet.net
 ([61.74.75.196])  with ESMTP id 2006122011:37:33:987236.19779.133610416 for
 <git@vger.kernel.org>;  Wed, 20 Dec 2006 11:37:33 +0900 (KST) 
Received: from [218.147.190.89] ([218.147.190.89])  by relay8.kornet.net
 ([211.48.62.136])  with ESMTP id 2006122011:37:34:068245.10051.26143664 for
 <git@vger.kernel.org>;  Wed, 20 Dec 2006 11:37:34 +0900 (KST) 
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

If I run it on CYGWIN, there's an error msg:

* FAIL 39: rename section
        git-repo-config --rename-section branch.eins branch.zwei
* FAIL 40: rename succeeded
        diff -u expect .git/config
...

I run some commands...

$ cd t/trash
$ rm -f .git/config.lock
$ ../../git-repo-config.exe --rename-section branch.eins branch.zwei
error: Cannot commit config file!

Thanks,
namsh



