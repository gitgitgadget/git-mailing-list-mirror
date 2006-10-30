X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Len Brown <len.brown@intel.com>
Subject: how to ignore merge conflicts?
Date: Mon, 30 Oct 2006 14:48:38 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200610301448.38222.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 30 Oct 2006 19:56:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.5/2131/Sun Oct 29 22:00:12 2006 on hera.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30515>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ged5H-0007d2-7c for gcvg-git@gmane.org; Mon, 30 Oct
 2006 20:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965172AbWJ3TqG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 14:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWJ3TqG
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 14:46:06 -0500
Received: from hera.kernel.org ([140.211.167.34]:59061 "EHLO
 hera.kernel.org") by vger.kernel.org with ESMTP id S965172AbWJ3TqF (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 14:46:05 -0500
Received: from lenb-laptop (c-65-96-213-102.hsd1.ma.comcast.net
 [65.96.213.102]) (authenticated bits=0) by hera.kernel.org (8.13.7/8.13.7)
 with ESMTP id k9UJjZKX007551 (version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128
 verify=NO) for <git@vger.kernel.org>; Mon, 30 Oct 2006 19:46:00 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Sometimes when a multiple-file merge give conflicts, I don't want to edit
one of the resulting <<<<<=====>>>>> files.
Instead, I just want to choose the version of that particular file that
existed in one of the two merged branches and commit that along with
the rest of the merge.

How to do this?

thanks,
