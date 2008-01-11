From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Re-casing directories on case-insensitive systems
Date: Fri, 11 Jan 2008 22:59:40 +0100
Message-ID: <200801112259.40968.robin.rosenberg.lists@dewire.com>
References: <579DF776-4F4E-464C-88DB-B22C2EC291BD@sb.org> <CCDF6298-4F17-4F70-AF00-E63F2C2A2816@sb.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 23:00:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDRvF-0001u4-Js
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 23:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762024AbYAKV7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761979AbYAKV7t
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:59:49 -0500
Received: from [83.140.172.130] ([83.140.172.130]:7393 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1761755AbYAKV7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 16:59:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B8A97802899;
	Fri, 11 Jan 2008 22:59:46 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EgQam3gAAkdl; Fri, 11 Jan 2008 22:59:46 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3DC91802641;
	Fri, 11 Jan 2008 22:59:46 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <CCDF6298-4F17-4F70-AF00-E63F2C2A2816@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70211>

fredagen den 11 januari 2008 skrev Kevin Ballard:
> Wow, it's even worse. I made a tmp branch and used git-filter-branch  
> to remove the commit that introduced CS4536, leaving only the cs4536  
> directory. But now if I try and run `git co master` it refuses, as it  
> thinks it's going to overwrite the untracked file CS4536/ 
> introduction.txt. I believe it's actually seeing the tracked file  
> cs4536/introduction.txt.

I think you should try an index filter. That should help you avoid file system problems.

-- robin
