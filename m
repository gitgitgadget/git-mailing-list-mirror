From: Monte Goulding <monte@sweattechnologies.com>
Subject: Refspec wildcards for remotes require trailing slash
Date: Tue, 10 Dec 2013 13:32:26 +1100
Message-ID: <3B290FD1-EF2B-4419-8845-45C5A3B4A3D3@sweattechnologies.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 10 04:41:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqECb-00084U-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 04:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802Ab3LJDli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 22:41:38 -0500
Received: from pancake.on-rev.com ([37.59.34.226]:38836 "EHLO
	pancake.on-rev.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab3LJDlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Dec 2013 22:41:37 -0500
X-Greylist: delayed 4142 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Dec 2013 22:41:37 EST
Received: from [120.29.242.42] (port=58062 helo=[192.168.2.101])
	by pancake.on-rev.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <monte@sweattechnologies.com>)
	id 1VqD7g-0007zh-ID
	for git@vger.kernel.org; Tue, 10 Dec 2013 03:32:33 +0100
X-Mailer: Apple Mail (2.1283)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pancake.on-rev.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sweattechnologies.com
X-Get-Message-Sender-Via: pancake.on-rev.com: authenticated_id: monte+sweattechnologies.com/only user confirmed/virtual account not confirmed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239126>


Hi

I came across this issue the other day while trying to optimise a fetch to a repo with release branches named release-X.X.X. I wanted to just fetch just those branches but because of the trailing slash rule I couldn't. The following StackOverflow post has details of the issue:

http://stackoverflow.com/questions/20450003/is-it-possible-to-use-filters-in-refspec-in-places-other-than-directory-namespac

The trailing slash rule appears to be introduced in 46220ca and further tightened in b2a5627

Before I go ahead and look at what needs to be done for a patch I thought it would be polite to ask if there is any reasoning behind the trailing slash rule that I'm missing? Or if you are interested in changing this behavior at all.

Cheers

Monte