From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Why does "git config" output nothing instead of the default value
 for unset variables?
Date: Sun, 14 Apr 2013 14:34:12 +0200
Message-ID: <kke7o1$oo$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 14 14:34:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URM8g-00053S-DV
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab3DNMeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:34:21 -0400
Received: from plane.gmane.org ([80.91.229.3]:54608 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443Ab3DNMeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 08:34:20 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1URM8R-0004kb-Ha
	for git@vger.kernel.org; Sun, 14 Apr 2013 14:34:19 +0200
Received: from p4fc9755d.dip.t-dialin.net ([79.201.117.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 14:34:19 +0200
Received: from sschuberth by p4fc9755d.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 14:34:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p4fc9755d.dip.t-dialin.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221097>

Hi,

I'm just wondering why it was decided to work like this. IMHO it's quite 
inconvenient that git config outputs nothing for any unset (but known) 
variable. Usually when I query a variable I'm not so much interested in 
whether it is at all (explicitly) set to some value or not, but what 
value is currently in use. With that in mind, it would make much more 
sense for git config to print the implicit default value instead of 
nothing if a known variable is unset. For unknown / custom variables it 
still could display nothing, which also gives a nice way to check 
whether a given variable name is known to Git or not.

-- 
Sebastian Schuberth
