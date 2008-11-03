From: Bryan Larsen <bryan@larsen.st>
Subject: git clone over HTTP failing one time out of four
Date: Mon, 03 Nov 2008 16:25:15 -0500
Message-ID: <490F6C3B.4020108@larsen.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 03 22:33:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx73U-00052X-Hw
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 22:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637AbYKCVca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 16:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754145AbYKCVca
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 16:32:30 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:64412 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbYKCVca (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 16:32:30 -0500
Received: by an-out-0708.google.com with SMTP id d40so124060and.1
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 13:32:28 -0800 (PST)
Received: by 10.64.208.20 with SMTP id f20mr667883qbg.89.1225747517332;
        Mon, 03 Nov 2008 13:25:17 -0800 (PST)
Received: from ?192.168.1.91? (76-10-180-103.dsl.teksavvy.com [76.10.180.103])
        by mx.google.com with ESMTPS id 9sm17666036qbw.6.2008.11.03.13.25.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 13:25:16 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99997>

Given the discussion about HTTP clones on October 12th, this isn't a 
huge surprise, but I thought I'd throw this out there.

I've been doing a large number of clones of 
http://repo.or.cz/r/kdebase.git.  Approximately 1 time in 4 this fails 
with an error like:

error: Unable to find fdb3... under http://repo.or.cz/r/kdebase.git
Cannot obtain needed tree fdb3...
while processing commit 3ce5...

I assume that repo.or.cz has the post hooks properly set up to do 
update-server-info.   Perhaps more is needed?

kdebase.git is the largest tree I could find, so the clone takes a long 
time to complete, and changes are being pushed regularly.

Bryan
