From: "psantosl@codicesoftware.com" <psantosl@codicesoftware.com>
Subject: Bi-directional sync with Git - direct access to server?
Date: Fri, 04 Mar 2011 18:44:41 +0100
Message-ID: <4D712509.1070704@codicesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 19:48:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pva2h-0004zr-Hn
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 19:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760052Ab1CDSru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 13:47:50 -0500
Received: from berith.lunarbreeze.com ([216.97.239.175]:55055 "EHLO
	berith.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759975Ab1CDSrt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 13:47:49 -0500
X-Greylist: delayed 3781 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Mar 2011 13:47:49 EST
Received: from 117.red-79-152-20.dynamicip.rima-tde.net ([79.152.20.117] helo=[192.168.2.33])
	by berith.lunarbreeze.com with esmtpa (Exim 4.69)
	(envelope-from <psantosl@codicesoftware.com>)
	id 1PvZ3V-0005Ij-Qr
	for git@vger.kernel.org; Fri, 04 Mar 2011 09:44:46 -0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
X-Enigmail-Version: 1.1.1
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - berith.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - codicesoftware.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168459>

Hi,

I'm developing a bi-directional synchronization between Plastic SCM and Git.

I've seen the hg-git Mercurial plugin by Scott Chacon and it uses a
local git repos to perform all operations, instead of directly "calling"
the "remote git server".

Well, considering Chacon did it this way, I guess there's no better way
to do it but I wanted to ask if there's a way to receive info about
commits (revisions) remotely (like, "give me your tree of commits and
how they're related so I can check with mines") and also a good way to
create a "push" without having a full local git repos. I'm looking into
the NGit and lib2git libraries.

Thanks,

pablo
