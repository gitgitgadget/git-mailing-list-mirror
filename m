From: "Reto S. News" <retoh@dplanet.ch>
Subject: How to update? (git Changed but not updated)
Date: Sat, 21 Feb 2009 22:23:01 +0100
Organization: Screen Point AG
Message-ID: <49A070B5.90909@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 22:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LazWr-0001n1-U8
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 22:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbZBUVf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 16:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754540AbZBUVf1
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 16:35:27 -0500
Received: from schaer.nine.ch ([217.150.250.49]:45642 "EHLO schaer.nine.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754461AbZBUVf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 16:35:26 -0500
X-Greylist: delayed 740 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Feb 2009 16:35:25 EST
Received: from [192.168.1.13] (catv-134-004.tbwil.ch [213.196.134.4])
	by schaer.nine.ch (8.13.8/8.13.8) with ESMTP id n1LLN17N015967
	for <git@vger.kernel.org>; Sat, 21 Feb 2009 22:23:01 +0100
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110982>

Beginner question: "How to update the pushed changes on the master?"

As a proof of concept to switch from CVS to git I prepared an
environment on two servers. I call the one "Slave" and "Master"
the other. Almost everything is working besides a silly
"cvs update" functionality I couldn't still find out after hours.

On Slave Host (a Developer that receives a working copy of a project):

$ git clone git://master.example.net/test myrepo
$ cd myrepo   # ... here I see all received files from the master
$ Changing file "foo.txt"
$ git add .   # ... for whatever reason this is necessary
$ git commit -m 'I changed this file'
$ git push

On Master Host (master.example.net):

# git status # Shows me correctly foo.txt has been changed by the"Slave"
# git show   # Shows me even the made changes in a diff style!


Now I have to update the fresh content produced by the "Slave". As an
ugly work-around, I'm currently cloning it again from localhost :-|

Any suggestions are very appreciated.

--reto
