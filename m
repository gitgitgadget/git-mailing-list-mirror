From: Heiko Voigt <heiko.voigt@mahr.de>
Subject: Partial tree export and merging
Date: Wed, 24 Sep 2008 15:58:07 +0200
Message-ID: <48DA476F.1070700@mahr.de>
References: <ACF330629DFB034AB290061C320F43460836E082@GOEMAILBE02.europe.mahr.lan> <48D9FACB.20901@mahr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@mahr.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 24 16:36:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVTE-0002U1-Ac
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 16:36:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbYIXOev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYIXOev
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 10:34:51 -0400
Received: from mail.mahr.de ([193.158.246.156]:16505 "EHLO mail.mahr.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbYIXOev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 10:34:51 -0400
X-Greylist: delayed 2201 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Sep 2008 10:34:50 EDT
Received: from [172.20.12.218] ([172.20.12.218]) by mail.mahr.de with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 24 Sep 2008 15:58:07 +0200
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48D9FACB.20901@mahr.de>
X-OriginalArrivalTime: 24 Sep 2008 13:58:07.0881 (UTC) FILETIME=[92ABAF90:01C91E4D]
X-TM-AS-Product-Ver: SMEX-8.0.0.1259-5.500.1027-16176.006
X-TM-AS-Result: No-2.212200-0.000000-31
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96635>

Hallo,

I am currently facing a challenge for adding limited access to a git 
repository for the i18n and documentation (language) team. Our 
repository contains *.html and *.loc files which are located along with 
the code. The language team should not see the code. At the same time a 
developer using the full tree needs to be able to contribute to the i8n 
files.

To archieve this I would like to extract a repository that only contains 
the documentation and localization files which can be used by the i8n 
and doc team. This should be regularly merged into the development (with 
code) repository.

My idea of a solution would be to export patches only for the specific 
files and import them into a seperate empty repository/branch using 
git-format-patch and git-am. This seperate repository then itself then
could be imported again with a normal merge operation. Has a anyone 
already solved such a problem or other ideas how to solve this ?

cheers Heiko
