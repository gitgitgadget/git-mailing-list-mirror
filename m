From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Commit to more than one branch at once?
Date: Fri, 06 Oct 2006 20:18:42 +0200
Message-ID: <45269E02.50407@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 06 20:19:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuHa-0001I0-M2
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422811AbWJFSSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422812AbWJFSSr
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:18:47 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:17292 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1422811AbWJFSSr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 14:18:47 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k96IIhTJ027494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 6 Oct 2006 20:18:45 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.1.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28424>

Hi all,

if I git-cherry-pick a commit from branch A into branch B, this is shown
as a difference in "git-log B..A".

Is it possible to commit a change to two or more branches but preserve
the identity of the change? IOW, is there an alternative to
git-cherry-pick that does not have above mentioned side effect?
-- 
Stefan Richter
-=====-=-==- =-=- --==-
http://arcgraph.de/sr/
