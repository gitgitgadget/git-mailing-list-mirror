From: Ian Hobson <ian@ianhobson.co.uk>
Subject: Handling multiple parallel versions.
Date: Wed, 21 Jul 2010 16:28:35 +0100
Message-ID: <4C471223.9050303@ianhobson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 18:50:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObcUa-0000Cc-DK
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 18:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab0GUQty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 12:49:54 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:29074 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751050Ab0GUQty (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 12:49:54 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100721152855.MFIE3192.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Wed, 21 Jul 2010 16:28:55 +0100
Received: from jupiter.ianhobson.co.uk ([86.12.69.89])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100721152855.QPIP1593.aamtaout04-winn.ispmail.ntl.com@jupiter.ianhobson.co.uk>
          for <git@vger.kernel.org>; Wed, 21 Jul 2010 16:28:55 +0100
Received: (qmail 15735 invoked by uid 453); 21 Jul 2010 15:28:42 -0000
X-Virus-Checked: Checked by ClamAV on ianhobson.co.uk
Received: from coachmaster.leda.hcs (HELO [192.168.0.12]) (192.168.0.12)
    by ianhobson.co.uk (qpsmtpd/0.83) with ESMTP; Wed, 21 Jul 2010 16:28:42 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.1.10) Gecko/20100512 Lightning/1.0b1 Thunderbird/3.0.5
X-Cloudmark-Analysis: v=1.1 cv=DhNl2YeytwJssBBGe49HJX82LNDFEEVkpVB34RXKaPo= c=1 sm=0 a=d5db43592S0A:10 a=8nJEP1OIZ-IA:10 a=jfYSeKfjs8TI_JA1eSUA:9 a=n2DbP3fI_JNSiJ8Pis0yQ3CiWIYA:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151405>

Hi All,

I need your advice.  I started with the "Rebase master" approach.

Now I have...

O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O  Master
| \
|  O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O London
|
| \ O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O Birmingham
|
| \ O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O Glasgow
|
| \ O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O Sheffield
|
  \ O--O--O--O--O--O--O--many more--O--O--O--O--O--O--O--O Cardiff

All the rebase master's are taking an age (and involve many conflicts). 
They are taking linger than the development.

So this solution is NOT working for maintaining parallel versions.

I can get to.

O  Master
| \
|  O   London
|\
|  O  Birmingham
etc

by re-applying the differences between each version (they are a set of 
images and a config file).

Then I am left with the main problem that I need help with.

When I have done some development and I have

O--A--B  Master
| \
|  O   London
|\
|  O  Birmingham
etc

how do I get to the following?

O--A--B  Master
            | \
            |  B''   London
            |\
            |  B'''  Birmingham
              etc

Answers gratefully received.

Regards

Ian
