From: ode <ode5002@blueyonder.co.uk>
Subject: Staging Individual Lines
Date: Sun, 21 Apr 2013 23:22:49 +0100
Message-ID: <517466B9.8010607@blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 01:14:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU3Si-0005Kd-0W
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 01:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753377Ab3DUXOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 19:14:20 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:5718 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752396Ab3DUXOT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Apr 2013 19:14:19 -0400
Received: from know-smtpout-1.server.virginmedia.net ([62.254.123.4])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20130421222358.CZWO23282.mtaout02-winn.ispmail.ntl.com@know-smtpout-1.server.virginmedia.net>
          for <git@vger.kernel.org>; Sun, 21 Apr 2013 23:23:58 +0100
Received: from [94.175.104.19] (helo=[192.168.0.3])
	by know-smtpout-1.server.virginmedia.net with esmtp (Exim 4.63)
	(envelope-from <ode5002@blueyonder.co.uk>)
	id 1UU2eo-00069S-3B
	for git@vger.kernel.org; Sun, 21 Apr 2013 23:22:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
X-Cloudmark-Analysis: v=1.1 cv=GaEGOwq9FwezmTggA+b6yC6zDZF2HYaK6RN/tSqdnVA= c=1 sm=0 a=-TtDL2fbfKMA:10 a=3NElcqgl2aoA:10 a=8nJEP1OIZ-IA:10 a=qIQ-3y9Lr21poTZgAfEA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221983>

Hi,

I had a big commit I wanted to break up and was wondering if there is
any way to stage individual lines from the command line.

I am using git add -i but it couldn't split the hunks any smaller.

I went looking on Google and found git-cola gui client which works for
staging individual lines to the commit.

But it's a bit clumsy to do this with the mouse and I was wondering if
there is a way to do this without having manually editing the file and
changing the diff numbers in git add -i when it can't break the hunks
smaller.

Why must we still manually edit the diff numbers when git-cola seems to
be able to work out the changes automatically when adding single lines?

Thanks for your help.
