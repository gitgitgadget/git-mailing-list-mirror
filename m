X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "P. Christeas" <p_christ@hol.gr>
Subject: Svnimport problem for openwrt repo
Date: Sun, 26 Nov 2006 19:30:52 +0200
Message-ID: <200611261930.53732.p_christ@hol.gr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_N9caFJyKNs47qra"
NNTP-Posting-Date: Sun, 26 Nov 2006 17:31:11 +0000 (UTC)
Cc: git-list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32359>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoNq4-0000dv-5D for gcvg-git@gmane.org; Sun, 26 Nov
 2006 18:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935457AbWKZRaf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 12:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935458AbWKZRaf
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 12:30:35 -0500
Received: from ppp249-097.dsl.hol.gr ([89.210.249.97]:33447 "EHLO
 pfn3.pefnos") by vger.kernel.org with ESMTP id S935457AbWKZRae (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 12:30:34 -0500
Received: from localhost.invalid (xorhgos2.pefnos [192.168.0.3]) by
 pfn3.pefnos (Postfix) with ESMTP id 80EF2355CB; Sun, 26 Nov 2006 19:31:16
 +0200 (EET)
To: Matthias Urlichs <smurf@smurf.noris.de>
Sender: git-owner@vger.kernel.org

--Boundary-00=_N9caFJyKNs47qra
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just tried today to sync my openwrt copy, but it seems that their extensive 
use of svn makes git-svnimport fail.
In particular, around commit #5089, I get the attached error (having printed 
the 'system' line). That commit should be the one when they merged 
their 'buildroot-ng' branch into the trunk (major changes, that is).
I have little to no time to debug the issue. Would you please give me a clue 
how to solve the issue and keep on using git-svnimport? Of course, I could 
even let you clone my repo or even work on it..
Hint: is there something wrong in the git-update-index arguments  I have 
there?




--Boundary-00=_N9caFJyKNs47qra
Content-Type: text/x-log;
  charset="us-ascii";
  name="svnimport.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="svnimport.log"

~/bin/git-svnimport -v  https://svn.openwrt.org/openwrt/
Fetching from 5059 to 5646 ...
Switching from 52e84fb9bdd801d5ec730c871918b9a72103d93b to fd0a4bec684c716f58f674c7f6b609a78450de49 (/)
5059:/:/: copying from buildroot-ng:openwrt @ 5058
git-update-index --add  --cacheinfo 100644f6f0cadf4603265e36202cfb1bac1092e240d956//BSDmakefile --cacheinfo 10064474b3696242caf331aebf1df2d02f70cd53d2792e//Config.in --cacheinfo 100644d60c31a97a544b53039088d14fe9114583c0efc3//LICENSE --cacheinfo 10064439ffb17fb5e770c8c6983feee5ef3568388665a2//Makefile --cacheinfo 1006442bba6fa6f6c8190e659145770d3d5cfeb01b45b9//README --cacheinfo 10064459881580b475e05803a3a55dde4d356c27a9a589//docs/config.txt --cacheinfo 100644024161bdebf1cfcec79c4a1063c2ddabaf5237f0//docs/network-scripts.txt --cacheinfo 10064469dbaa60ba8f492c0875060b09b583173921fa48//docs/network.txt --cacheinfo 100644a1287da475bc8a63a5d13c021e6d27efc0fe39e9//include/host-build.mk --cacheinfo 1006443a5fd9683e3592f4750a80964a321075e388cde7//include/host.mkfatal: git-update-index: --cacheinfo cannot add //BSDmakefile
Cannot add files: 32768

