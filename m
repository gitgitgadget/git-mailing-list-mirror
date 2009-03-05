From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: How to ignore a modified file?
Date: Thu, 5 Mar 2009 21:45:08 +0100
Message-ID: <200903052145.08249.robin.rosenberg.lists@dewire.com>
References: <1236242659559-2428157.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: dealmaker <vinkhc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 21:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfKSu-0006Fl-L5
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 21:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754191AbZCEUpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 15:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbZCEUpR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 15:45:17 -0500
Received: from mail.dewire.com ([83.140.172.130]:12048 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354AbZCEUpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 15:45:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C3F0F1295E69;
	Thu,  5 Mar 2009 21:45:09 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jnBgp3XY0Q73; Thu,  5 Mar 2009 21:45:09 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3EEE48006AC;
	Thu,  5 Mar 2009 21:45:09 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-12-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <1236242659559-2428157.post@n2.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112337>

torsdag 05 mars 2009 09:44:19 skrev dealmaker <vinkhc@gmail.com>:
> 
> Hi, 
>   I run "git status", and I saw the a modified file in a directory.  I want
> to ignore all files in that directory.  I put the directory name into
> .gitignore, but it still shows as modified file.  Why?  How do I ignore the
> directory?
> Thanks.

git update-index --assume-unchanged <files...>

-- robin
