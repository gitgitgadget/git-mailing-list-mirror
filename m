X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: SungHyun Nam <goweol@gmail.com>
Subject: branch rebase and push
Date: Tue, 19 Dec 2006 12:39:40 +0900
Message-ID: <45875EFC.5090408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 03:56:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 979 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 22:56:08 EST
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34783>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwW5W-0002R2-La for gcvg-git@gmane.org; Tue, 19 Dec
 2006 04:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752314AbWLSD4J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 22:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752399AbWLSD4J
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 22:56:09 -0500
Received: from relaygw1.kornet.net ([61.74.75.196]:49998 "EHLO
 relaygw1.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752314AbWLSD4I (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 22:56:08 -0500
Received: from [211.48.62.134] ([211.48.62.134])  by relaygw1.kornet.net
 ([61.74.75.196])  with ESMTP id 2006121912:39:42:457238.19779.133610416 for
 <git@vger.kernel.org>;  Tue, 19 Dec 2006 12:39:42 +0900 (KST) 
Received: from [218.147.190.89] ([218.147.190.89])  by relay7.kornet.net
 ([211.48.62.134])  with ESMTP id 2006121912:39:41:836446.24574.26852272 for
 <git@vger.kernel.org>;  Tue, 19 Dec 2006 12:39:41 +0900 (KST) 
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

Can I push a branch after rebase?
I got a error message:
   error: remote 'refs/heads/br' is not a strict subset of local ref
   'refs/heads/br'. maybe you are not up-to-date and need to pull first?

It worked fine if I did:
  $ git checkout -b br
  $ git pull . master
  $ git checkout master
  $ git pull
  $ git push

But I got above error message if I did:
  $ git checkout br
  $ git rebase master
  $ git checkout master
  $ git pull
  $ git push

Thanks.
namsh



