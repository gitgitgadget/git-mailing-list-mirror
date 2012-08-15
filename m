From: Mina Almasry <almasry.mina@hotmail.com>
Subject: Feature request - discard hunk in add --patch mode
Date: Wed, 15 Aug 2012 04:36:22 -0400
Message-ID: <BLU0-SMTP37070ADBEC060E1EA15944693B60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 10:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1ZBc-000586-Nd
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 10:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab2HOImg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 04:42:36 -0400
Received: from blu0-omc3-s25.blu0.hotmail.com ([65.55.116.100]:63210 "EHLO
	blu0-omc3-s25.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753096Ab2HOIme (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Aug 2012 04:42:34 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2012 04:42:34 EDT
Received: from BLU0-SMTP370 ([65.55.116.74]) by blu0-omc3-s25.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 15 Aug 2012 01:36:24 -0700
X-Originating-IP: [142.151.169.12]
X-EIP: [uMRWVE6kMnDjzG0qMgAvw35jW916KPzb]
X-Originating-Email: [almasry.mina@hotmail.com]
Received: from [192.168.1.101] ([142.151.169.12]) by BLU0-SMTP370.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 15 Aug 2012 01:36:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120714 Thunderbird/14.0
X-OriginalArrivalTime: 15 Aug 2012 08:36:23.0531 (UTC) FILETIME=[0D6063B0:01CD7AC1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203464>

Hi,

I frequently stage files using git add --patch command and I almost 
always come across debug code I want to discard, but there is no option 
for that in the prompt. The result is that I have to run an extra 
command after the dialogue ends.

I would like to add a feature to allow users to discard hunks using a 
command like r! or d!

I was wondering if that would be a welcome addition to git. I am willing 
to work on the feature myself.

Regards,
Mina
