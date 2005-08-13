From: Carl Baldwin <cnb@fc.hp.com>
Subject: Add an empty directory?
Date: Sat, 13 Aug 2005 11:30:43 -0600
Organization: Hewlett Packard
Message-ID: <20050813173043.GA25013@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 13 19:31:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3zqK-0005AW-Bw
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 19:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVHMRaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVHMRap
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 13:30:45 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:15539 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932224AbVHMRap (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 13:30:45 -0400
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel8.hp.com (Postfix) with ESMTP id 9198B2D18
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 13:30:44 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 6D6AC38333
	for <git@vger.kernel.org>; Sat, 13 Aug 2005 17:30:43 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 4ED6C3FDE; Sat, 13 Aug 2005 11:30:43 -0600 (MDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Greetings,

My appologies if this has already been discussed.  I've been through the
archives but could easily have missed something.

I have found it useful in the past to have the ability to add an empty
directory to the repository.  With what little I know about git it seems
that this is entirely possible.  It would create an empty tree object
for the new directory and insert a reference to that in the parent tree
object.

If someone could get me started I think I could find the time to create
and submit a patch to allow this.  Here is what I've tried (with
0.99.4).

% mkdir test
% cd test
% git-init-db
% mkdir dir
% git-add-script dir
error: open("dir"): No such file or directory
fatal: Unable to add dir to database

Cheers,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
