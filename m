From: Daniel Poelzleithner <poelzi@poelzi.org>
Subject: custom attributes per file
Date: Sun, 08 Nov 2009 00:55:02 +0100
Message-ID: <4AF608D6.6010904@poelzi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 01:15:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6vRE-00040w-4O
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 01:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbZKHAO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 19:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbZKHAO6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 19:14:58 -0500
Received: from quamquam.org ([88.198.196.3]:33663 "EHLO quamquam.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbZKHAO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 19:14:57 -0500
X-Greylist: delayed 1198 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Nov 2009 19:14:57 EST
Received: from fuckup.club.berlin.ccc.de ([195.160.172.2] helo=[23.23.23.191])
	by quamquam.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <poelzi@poelzi.org>)
	id 1N6v7Y-0002wk-2c
	for git@vger.kernel.org; Sun, 08 Nov 2009 00:55:04 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-SA-Do-Not-Run: Yes
X-SA-Exim-Connect-IP: 195.160.172.2
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: poelzi@poelzi.org
X-SA-Exim-Scanned: No (on quamquam.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132379>

Hi git devs,

I have seen on your TODO list, that you plan to add tree attributes. We 
want to use git as a backend to store the wikipedia content in a 
distributed manner. The exporter [1] is already quite stable it seems. 
Today I started a frontend project [2] and have a feature request :-)

* Make attributes apply to trees, not just working tree.

What we need are versioned attributes per file and per tree. Currently 
we export each article into a file, but there is no way we could save 
custom attributes directly bound to it, which distributes the data which 
should be together. If the maximum value per attribute should be quite 
large, this way we could save reports of vote results bound to the 
article directly.

I think unicode data to an ascii key would be sufficient, but real types 
could provide great features in the future. Changes to these values 
should be signable by gpg signed commit messages like a normal checkin.

Maybe in the long run, there could be some sort of export filter 
mechanism. For cloning repositories, for example a copy of the wiki 
database based on a quality key of an article could be exported for a 
embedded device.

[1] http://github.com/scy/levitation
[2] http://github.com/poelzi/communiki

kindly regards
  Daniel Poelzleithner
