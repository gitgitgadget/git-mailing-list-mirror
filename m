X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: George Sherwood <pilot@beernabeer.com>
Subject: http git and curl 7.16.0
Date: Sat, 18 Nov 2006 08:07:08 +0400
Message-ID: <20061118080708.428cbff6@athlon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 04:05:29 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.6; i686-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31750>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlHSC-0004rt-0E for gcvg-git@gmane.org; Sat, 18 Nov
 2006 05:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753866AbWKREFJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 23:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbWKREFJ
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 23:05:09 -0500
Received: from email12.mywebmailserver.com ([199.231.136.142]:43279 "EHLO
 email12.mywebmailserver.com") by vger.kernel.org with ESMTP id
 S1753866AbWKREFG (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006
 23:05:06 -0500
Received: from athlon ([217.14.102.68]) by email12.mywebmailserver.com
 (IntelliMail) with ASMTP id CRY74585 for <git@vger.kernel.org>; Fri, 17 Nov
 2006 23:05:05 -0500
To: Git List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I seem to be having a problem doing an http checkout with git built
with curl 7.16.0 enabled.  If I build against curl 7.16.0 and try a
clone, I get:

git clone http://dmlb2000.homelinux.org/~dmlb2000/git-repos/local/castfs.git
error: Unable to start request error: Could not interpret heads/master
as something to pull

If I rebuild git against curl 7.15.5 then I get:
git clone
http://dmlb2000.homelinux.org/~dmlb2000/git-repos/local/castfs.git got
9a985de4a4cfa973a4573828df4cbb2e4f66c419 walk
9a985de4a4cfa973a4573828df4cbb2e4f66c419 got
c431dee75dfadb4c6f81bd95fa1ae44b2b07b359 got
6e645158ba349eaa68caa4c37d18412b30bfd76d walk
c431dee75dfadb4c6f81bd95fa1ae44b2b07b359 got
e452f63c2af324254b7f65f955cbb5ac8efa6762 got

and the checkout finishes.

Has any one else seen this?

George Sherwood
Lead Developer Sourcemage GNU/Linux
