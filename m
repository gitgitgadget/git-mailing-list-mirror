X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Masters <jcm@redhat.com>
Subject: changing log entries
Date: Wed, 13 Dec 2006 18:08:01 -0500
Message-ID: <1166051281.1808.1.camel@jcm.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 23:17:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 850 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 18:17:41 EST
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34250>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudMC-0008Dt-Vg for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751723AbWLMXRn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWLMXRm
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:17:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53311 "EHLO mx1.redhat.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751727AbWLMXRl
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 18:17:41 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
 [172.16.52.254]) by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
 kBDN3VUt028587 for <git@vger.kernel.org>; Wed, 13 Dec 2006 18:03:31 -0500
Received: from pobox.surrey.redhat.com (pobox.surrey.redhat.com
 [172.16.10.17]) by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
 kBDN3Uwd013125 for <git@vger.kernel.org>; Wed, 13 Dec 2006 18:03:31 -0500
Received: from [172.16.81.77] (jcm.boston.redhat.com [172.16.81.77]) by
 pobox.surrey.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id
 kBDN3T5B012583 for <git@vger.kernel.org>; Wed, 13 Dec 2006 23:03:30 GMT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

So I figured out that the problem with "Can't lock ref" was down to not
having set one of the scripts executable on the http server. Great.

Anyway, now I would like to change an existing log entry to make it a
bit cleaner (read: add a first line that's under 80 characters). What's
the best way to change an existing log entry for a commit?

Jon.

