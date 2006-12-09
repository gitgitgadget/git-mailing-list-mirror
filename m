X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: builtin git-shortlog still broken
Date: Fri, 08 Dec 2006 22:23:14 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612082205240.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 9 Dec 2006 03:23:26 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33794>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsso6-0000KR-L4 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 04:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758267AbWLIDXR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 22:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758505AbWLIDXQ
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 22:23:16 -0500
Received: from relais.videotron.ca ([24.201.245.36]:26434 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1758267AbWLIDXP (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 22:23:15 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9Z00IMILEQ3Y61@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Fri,
 08 Dec 2006 22:23:14 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On the Linux kernel repository, doing "git shortlog v2.6.18.." works 
fine. "git shortlog v2.6.17.." works fine. "git shortlog v2.6.16.." also 
works fine.  But "git shortlog v2.6.15.." dies with a segmentation 
fault.  Trying "git log v2.6.15.. | git shortlog" also produces the same 
crash while "git log v2.6.16.. | git shortlog" works fine.

The old perl version doesn't have any such issue with those test cases, 
not even with the whole kernel history.


