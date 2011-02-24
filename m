From: Chris Friesen <chris.friesen@genband.com>
Subject: [feature request] embed original commit info in cherry-pick
Date: Thu, 24 Feb 2011 12:30:33 -0600
Message-ID: <4D66A3C9.7050001@genband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 20:09:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsgYp-0000zp-RY
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 20:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756293Ab1BXTJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 14:09:00 -0500
Received: from exprod7og104.obsmtp.com ([64.18.2.161]:33693 "EHLO
	exprod7og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756280Ab1BXTJA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 14:09:00 -0500
X-Greylist: delayed 1069 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Feb 2011 14:08:59 EST
Received: from source ([63.149.188.88]) (using TLSv1) by exprod7ob104.postini.com ([64.18.6.12]) with SMTP
	ID DSNKTWasy8+OX+vU7DVpTaVs2kPH0D42YntD@postini.com; Thu, 24 Feb 2011 11:08:59 PST
Received: from gbausmail.genband.com ([172.16.21.55]) by mail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 24 Feb 2011 12:30:34 -0600
Received: from localhost.localdomain ([1.220.17.171]) by gbausmail.genband.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 24 Feb 2011 12:30:34 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc11 Thunderbird/3.0.4
X-OriginalArrivalTime: 24 Feb 2011 18:30:34.0193 (UTC) FILETIME=[EC963410:01CBD450]
X-TM-AS-Product-Ver: SMEX-8.0.0.4160-6.500.1024-17976.001
X-TM-AS-Result: No--2.776600-5.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167849>


If I cherry-pick a  bugfix from a more recent version of a project, it
would be useful to have an indication somewhere in the commit
information of where it originally came from.

That way, if I then upgrade to a newer version of the software it
becomes obvious that I don't need to worry about porting that commit
forwards because it's already been handled upstream.

As it stands, it's not immediately obvious what was cherry-picked vs
what was developed locally.

Chris

-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
