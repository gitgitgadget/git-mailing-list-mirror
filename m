From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: RFC: git pull <remote> making an octopus?
Date: Mon, 14 Aug 2006 09:43:36 +0300
Message-ID: <20060814064336.GE21963@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 14 08:45:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCWC5-00079G-Q8
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 08:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWHNGo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 02:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWHNGo6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 02:44:58 -0400
Received: from mxl145v69.mxlogic.net ([208.65.145.69]:10934 "EHLO
	p02c11o146.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751791AbWHNGo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 02:44:58 -0400
Received: from unknown [194.90.237.34]
	by p02c11o146.mxlogic.net (mxl_mta-3.0.0-12)
	with SMTP id 9eb10e44.1964399536.3940.00-007.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 14 Aug 2006 00:44:57 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 09:47:34 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 09:43:36 +0300
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 06:47:34.0937 (UTC) FILETIME=[86224090:01C6BF6D]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25326>

Hi!
If I do

$git pull origin

where origin is a file in .git/remotes/origin with multiple Pull: lines,
then I seem to get an octopus merge. I would expect it to behave
in the same way as git pull without parameters.
Is this a bug or a feature?

My git pull page says:
              While
              git-pull run without  any  explicit  <refspec>  parameter  takes
              default  <refspec>s  from  Pull: lines, it merges only the first
              <refspec> found into the current branch, after fetching all  the
              remote  refs. This is because making an Octopus from remote refs
              is rarely done, while keeping track of multiple remote heads  in
              one-go by fetching more than one is often useful.

So, the same logic seems to apply to anything under .git/remotes.
Right?

-- 
MST
