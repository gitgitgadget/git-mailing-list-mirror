From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Getting "Automatic merge failed" although all conflicts were resolved
 using previous resolution
Date: Sun, 14 Apr 2013 14:39:32 +0200
Message-ID: <kke822$3ln$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 14:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMDk-0002lk-6O
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715Ab3DNMjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:39:44 -0400
Received: from plane.gmane.org ([80.91.229.3]:34607 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab3DNMjn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 08:39:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1URMDc-0002bs-4g
	for git@vger.kernel.org; Sun, 14 Apr 2013 14:39:40 +0200
Received: from p4fc9755d.dip.t-dialin.net ([79.201.117.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 14:39:40 +0200
Received: from sschuberth by p4fc9755d.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 14:39:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4fc9755d.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221098>

Hi,

I just realized Git merge still outputs

    Automatic merge failed; fix conflicts and then commit the result.

although all of my conflicts were resolved using a previously recorded resolution. I think it's OK for Git to not just do the merge commit in that case to sort of force a review of the resolution, but still I think the message is misleading. It should probably rather say something like

    All conflicts resolved using previous resolutions; please review and then commit the result.

Opinions?

-- 
Sebastian Schuberth
