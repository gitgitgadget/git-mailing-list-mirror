From: Mike Laster <mlaster@metavillage.com>
Subject: git gc annoyance
Date: Thu, 17 Jul 2008 20:30:22 -0700
Message-ID: <0BEA60F9-852B-45B2-9A9A-173B8C9386AC@metavillage.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: multipart/mixed; boundary=Apple-Mail-8--326061831
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 05:31:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJggo-00020I-BQ
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 05:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbYGRDa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 23:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYGRDa0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 23:30:26 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39657 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750903AbYGRDaZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jul 2008 23:30:25 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 1903B13B046
	for <git@vger.kernel.org>; Thu, 17 Jul 2008 23:30:25 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 17 Jul 2008 23:30:25 -0400
X-Sasl-enc: 1IvGspLURrjB5UKUc4H1gs6M2n5V7At84wLzCcclb2s/ 1216351824
Received: from cambot.internal.metavillage.com (c-24-7-121-38.hsd1.ca.comcast.net [24.7.121.38])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7AE233907F
	for <git@vger.kernel.org>; Thu, 17 Jul 2008 23:30:24 -0400 (EDT)
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88980>


--Apple-Mail-8--326061831
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Whenever I run 'git gc' all of the files in .git/logs/refs/remotes/ 
tags get touched with the current timestamp.

I use unison to sync my working directories between home and work and  
these files show up as changed unnecessarily.  Since they are all zero- 
byte files
clearly they haven't changed.  It would be more efficient to not touch  
the file if it already exists to leave the old timestamp in place.


--Apple-Mail-8--326061831
Content-Disposition: attachment;
	filename=git_gc_log.txt.gz
Content-Type: application/x-gzip;
	x-unix-mode=0644;
	name="git_gc_log.txt.gz"
Content-Transfer-Encoding: base64

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

--Apple-Mail-8--326061831
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7bit



--Apple-Mail-8--326061831--
