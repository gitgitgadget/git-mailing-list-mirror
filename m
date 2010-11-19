From: Pascal Obry <pascal@obry.net>
Subject: Git doc generation question
Date: Fri, 19 Nov 2010 17:26:34 +0100
Organization: Home - http://www.obry.net
Message-ID: <4CE6A53A.9090203@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 19 17:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJTv0-0000VK-EL
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 17:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755827Ab0KSQe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 11:34:29 -0500
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:47353 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab0KSQe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 11:34:29 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2010 11:34:28 EST
Received: from [192.168.0.100] ([83.204.249.233])
	by mwinf5d24 with ME
	id Z4Sa1f00L52tS8K034SaGj; Fri, 19 Nov 2010 17:26:34 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161765>


Hi,

I'm building Git from source and in the documentation I have some code
remaining, for example:

   $ man git

git me in the CONFIGURATION MECHANISM section:


<<
       example:

           .ft C
           #
           # A '#' or ';' character indicates a comment.
           #

           ; core variables
           ...
           .ft
>>

It looks like the ".ft C" and the ending .ft are some code not properly
parsed. Right?

Is that a known issue?

I had this problem on Cygwin and now on GNU/Debian!

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
