From: "Franz Liedke" <franz@develophp.org>
Subject: [Support] Branch pointer does not move
Date: Mon, 14 Mar 2011 14:18:44 +0100
Organization: develoPHP
Message-ID: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 14:23:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pz7jq-0001Vt-Ig
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 14:23:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918Ab1CNNXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 09:23:05 -0400
Received: from relay01.alfahosting-server.de ([80.86.191.88]:59907 "EHLO
	relay01.alfahosting-server.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755015Ab1CNNXD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Mar 2011 09:23:03 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Mar 2011 09:23:02 EDT
Received: by relay01.alfahosting-server.de (Postfix, from userid 1001)
	id 5F27532C017D; Mon, 14 Mar 2011 14:17:05 +0100 (CET)
X-Spam-DCC: debian: relay01 1169; Body=1 Fuz1=1 Fuz2=1
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=7.0 tests=BAYES_50 autolearn=disabled
	version=3.2.5
Received: from alfa3007.alfahosting-server.de (alfa3007.alfahosting-server.de [82.197.146.14])
	by relay01.alfahosting-server.de (Postfix) with ESMTP id AFDBC32C0183
	for <git@vger.kernel.org>; Mon, 14 Mar 2011 14:17:02 +0100 (CET)
Received: from metalltrottel.fritz.box (sd-89-66.stud.uni-potsdam.de [141.89.89.66])
	by alfa3007.alfahosting-server.de (Postfix) with ESMTPSA id 9EEC02F04465
	for <git@vger.kernel.org>; Mon, 14 Mar 2011 14:17:02 +0100 (CET)
User-Agent: Opera Mail/11.01 (Win32)
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with ClamAV 0.97/12833/Mon Mar 14 09:09:46 2011
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168987>

Hello everybody,

I am currently having some trouble with a local Git branch.
It seems the branch pointer is not updated when I make new commits to that  
particular branch.

After looking around in the .git directory of my repository, it seems that  
the commit hashes both in .git/packed-refs and in .git/info/refs are not  
updated (if that helps).

Did I do something wrong? How can this be fixed?

Thank you very much in advance,
Franz
