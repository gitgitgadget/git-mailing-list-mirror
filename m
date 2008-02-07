From: Sami Maisniemi <sami@maisniemi.net>
Subject: Compiling Git in Mac OS X Leopard
Date: Thu, 7 Feb 2008 09:09:39 +0200
Message-ID: <E9380AA8-2E38-4733-9940-FFD51BB84700@maisniemi.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 08:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN12D-0004ek-6v
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 08:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097AbYBGHS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 02:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755595AbYBGHS1
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 02:18:27 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:45391 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbYBGHS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 02:18:26 -0500
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Feb 2008 02:18:26 EST
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 6685918D278
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 09:09:40 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A063F148E7C; Thu, 07 Feb 2008 09:09:40 +0200
Received: from [192.168.255.2] (a88-114-125-230.elisa-laajakaista.fi [88.114.125.230])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 5BB344BC24
	for <git@vger.kernel.org>; Thu,  7 Feb 2008 09:09:39 +0200 (EET)
X-Mailer: Apple Mail (2.915)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72902>

Hi,

I tried to compile Git in Mac OS X Leopard, because I was unable to  
find any precompiled binaries. However, the compilation was aborted  
due to the following error:

msgfmt --statistics --tcl po/de.po -l de -d po/
make[1]: msgfmt: Command not found
make[1]: *** [po/de.msg] Error 127
make: *** [all] Error 2

It seems that the makefile uses an application called msgfmt that is  
not available in Mac OS X Leopard. What is application msgfmt and why  
it is required? Is there any kind of workaround available?

Regards Sami Maisniemi
