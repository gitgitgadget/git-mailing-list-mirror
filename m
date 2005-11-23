From: Carl Baldwin <cnb@fc.hp.com>
Subject: Why not clone to a remote directory over SSH
Date: Wed, 23 Nov 2005 14:16:01 -0700
Organization: Hewlett Packard
Message-ID: <20051123211601.GA2260@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 23 22:16:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef1yL-000089-8A
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 22:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVKWVQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 16:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVKWVQF
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 16:16:05 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:25041 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932466AbVKWVQC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 16:16:02 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel8.hp.com (Postfix) with ESMTP id B060A277F
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 16:16:01 -0500 (EST)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP id 7A93E387CA
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 21:16:01 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 635322A6C; Wed, 23 Nov 2005 14:16:01 -0700 (MST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpsvcnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12651>

It might be cool to enable cloning to a remote over ssh if the remote
doesn't yet exist.

% git clone . machine:/path/to/new/repository

If you try this now it will clone the current working repository to a
new directory called 'machine:'.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
