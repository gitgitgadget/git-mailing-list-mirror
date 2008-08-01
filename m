From: Matti Kaasinen <matti.kaasinen@sitecno.fi>
Subject: Is there any hope (format-patch)??
Date: Fri, 01 Aug 2008 15:05:10 +0300
Organization: Si-Tecno Oy
Message-ID: <4892FBF6.8060505@sitecno.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 14:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOtZO-0007Sn-Bp
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 14:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbYHAMQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 08:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbYHAMQQ
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 08:16:16 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:44826 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbYHAMQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 08:16:16 -0400
X-Greylist: delayed 662 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Aug 2008 08:16:15 EDT
Received: from [192.168.2.22] (a88-114-145-105.elisa-laajakaista.fi [88.114.145.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id C40D41518EB
	for <git@vger.kernel.org>; Fri,  1 Aug 2008 15:05:10 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91061>

Hi!

Is there any hope with following procedure:
I took reporitory from linux git:
# git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

For getting patches to make recent version from v2.6.26-rc3 I executed:
# git format-patch -o patchdir v2.6.26-rc3..origin

This produced 9486 patches, two of which were empty. They both appeared 
to have two references in git.kernel.org archive so that newer ones were 
empy.

Then I checked out v2.6.26-rc3 to a new branch and patched it with 
at91patch/maxim.org.za that was produced against v2.6.26-rc3. That 
worked out without complaints.

Then I ran:

#git quiltimport --patches patchdir

I suppose, it was the fourth patch of 9486 that failed. Fail did not 
come from any of those parts patched with at91 patch. Is this anything 
that should work? at91 patch fails if I try it right-away over the HEAD 
branch.

cheers,
Matti Kaasinen
