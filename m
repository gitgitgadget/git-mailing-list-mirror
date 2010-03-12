From: Adam Nielsen <adam.nielsen@uq.edu.au>
Subject: How do you switch branches in a bare repo?
Date: Fri, 12 Mar 2010 16:26:42 +1000
Organization: The University of Queensland
Message-ID: <4B99DEA2.6050104@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 12 07:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npyav-0003Vn-0P
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 07:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233Ab0CLGnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 01:43:31 -0500
Received: from mailhub3.uq.edu.au ([130.102.148.131]:47090 "EHLO
	mailhub3.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0CLGnb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 01:43:31 -0500
X-Greylist: delayed 1006 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Mar 2010 01:43:30 EST
Received: from smtp3.uq.edu.au (smtp3.uq.edu.au [130.102.128.18])
	by mailhub3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o2C6Qgao008282
	for <git@vger.kernel.org>; Fri, 12 Mar 2010 16:26:42 +1000
Received: from [192.168.173.208] (rrtd-it1.research.uq.edu.au [192.168.173.208])
	by smtp3.uq.edu.au (8.13.8/8.13.8) with ESMTP id o2C6Qgil000920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 12 Mar 2010 16:26:42 +1000
User-Agent: Thunderbird 2.0.0.23 (X11/20091130)
X-UQ-FilterTime: 1268375202
X-Scanned-By: MIMEDefang 2.58 on UQ Mailhub on 130.102.148.131
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142022>

Hi all,

I want to remove some commits (with git reset) from a bare repo, but 
they're not in the master branch and I can't figure out how to change 
branches:

$ git checkout newbranch
fatal: This operation must be run in a work tree

I've tried running the reset locally and pushing the change (with -f) 
but that doesn't work either, and Google isn't being much help.

How do you switch between branches in a bare repo?

Many thanks,
Adam.

(Please CC)
