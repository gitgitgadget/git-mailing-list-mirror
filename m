X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Miles Bader <miles.bader@necel.com>
Subject: git bug? + question
Date: Thu, 02 Nov 2006 14:56:51 +0900
Message-ID: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 06:01:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org, miles@gnu.org
System-Type: i686-pc-linux-gnu
Blat: Foop
Original-Lines: 25
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30688>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfVe8-0000SV-3S for gcvg-git@gmane.org; Thu, 02 Nov
 2006 07:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752651AbWKBGBl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 01:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbWKBGBl
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 01:01:41 -0500
Received: from mgate03.necel.com ([203.180.232.83]:45732 "EHLO
 mgate03.necel.com") by vger.kernel.org with ESMTP id S1752651AbWKBGBk (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 01:01:40 -0500
Received: from relay21.aps.necel.com (relay21 [10.29.19.50]) by
 mgate03.necel.com (8.13.8/8.13.1) with ESMTP id kA24s357024833; Thu, 2 Nov
 2006 15:01:35 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.24] [10.29.19.24]) by
 relay21.aps.necel.com with ESMTP; Thu, 2 Nov 2006 15:01:35 +0900
Received: from dhapc248.dev.necel.com ([10.114.97.235] [10.114.97.235]) by
 relay31.aps.necel.com with ESMTP; Thu, 2 Nov 2006 15:01:35 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295) id 02F7B57;
 Thu,  2 Nov 2006 14:56:51 +0900 (JST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I tried the following sequence of commands to make two clones of a
remote repository, but got an error:

   $ git clone --use-separate-remote ssh://fp.gnu.org/~/git/snogray.git snogray-git
   $ git clone --use-separate-remote --reference snogray-git ssh://fp.gnu.org/~/git/snogray.git imp-sample
   error: refs/reference-tmp/refs/remotes/origin/HEAD points nowhere!

Is this a real error, or bad usage?

Also, a question:  Is there anyway to make git-clone use
--use-separate-remote by default?  I'm trying for a "lots of branches in
a single shared remote repository" style, and use-separate-remote seems
more sane for this usage.

I'm using git version 1.4.3.3.

Thanks,

-Miles

-- 
"I distrust a research person who is always obviously busy on a task."
