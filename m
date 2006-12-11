X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Masters <jonathan@jonmasters.org>
Subject: error: Can't lock ref
Date: Mon, 11 Dec 2006 02:58:15 -0500
Organization: World Organi[sz]ation Of Broken Dreams
Message-ID: <457D0F97.6050801@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 07:58:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33977>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtg3U-0005tU-Tm for gcvg-git@gmane.org; Mon, 11 Dec
 2006 08:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762645AbWLKH6U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 02:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762647AbWLKH6U
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 02:58:20 -0500
Received: from panic.printk.net ([217.147.83.20]:40843 "EHLO
 panic.printk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1762645AbWLKH6T (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 02:58:19 -0500
Received: from localhost.localdomain ([127.0.0.1]) by panic.printk.net with
 esmtp (Exim 3.36 #1 (Debian)) id 1Gtg3F-0003a4-00 for <git@vger.kernel.org>;
 Mon, 11 Dec 2006 07:58:18 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi folks,

I've just pushed up a packed git repo:

http://www.kerneltools.org/pub/downloads/module-init-tools/devel/module-init-tools.git

Attempting to clone this repo using http generates the error in 
$subject. Brief searching via Google suggests this is an appache 
permissions problem - anyone got a trivially obvious apache config fix 
before I go trawling through to figure out what's up?

