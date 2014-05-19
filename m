From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Any difference to unstage files using "git checkout" and "git rm"
Date: Mon, 19 May 2014 21:12:47 +0630
Organization: CognitiveClouds
Message-ID: <6833494.47nikG189t@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 17:48:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmPnf-00084s-6b
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 17:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbaESPsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 11:48:22 -0400
Received: from nm10-vm4.bullet.mail.sg3.yahoo.com ([106.10.148.227]:41595 "EHLO
	nm10-vm4.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630AbaESPsU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2014 11:48:20 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 May 2014 11:48:20 EDT
Received: from [106.10.166.116] by nm10.bullet.mail.sg3.yahoo.com with NNFMP; 19 May 2014 15:42:25 -0000
Received: from [106.10.167.162] by tm5.bullet.mail.sg3.yahoo.com with NNFMP; 19 May 2014 15:42:24 -0000
Received: from [127.0.0.1] by smtp135.mail.sg3.yahoo.com with NNFMP; 19 May 2014 15:42:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1400514144; bh=lQqTmPCdRs1Z7MdgZq1JoWlef1fZnhT8H3sQfb8M7YM=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:MIME-Version:Content-Transfer-Encoding:Content-Type; b=2MJ3+6FrCXm2WIiFSmyPi0pjgqK58xlyXtN1WITe9d7rQgUwveNxi4R9OgWniytB5ehKv9A8koDZFo7Pp6JnelvP0n889TpePLOxkGQrQrBtGCmilL6cqhaVHKpFWFmGz4PiEpfNi12CiyAWwwegzMvXUtgXhL953T/Cf6Rjgvg=
X-Yahoo-Newman-Id: 620701.95736.bm@smtp135.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: XS.l1bwVM1nG.gwlFYWhq6jJQb50EPO7BP229pv7AoeeRG9
 uDVSYDMSI3_2JX8XrRo0IQW6yA7k9hPPdqxYoYiPEOmMIoEmU8fyPH7MF5aU
 3VYMHGHqp3wNPgYMwUUdONslPFaEmcHTXixsh4XQWchloaRVYSVtRLJgmf95
 SuvSxnR472zgn8q7UgsUFXApjnlwWatLmA5qu8NPhcnyTnbC3v7ZhfXhAbew
 hc8aplYI8KcvSTZ2Vy.aiWevk25eFHyC5R5oGCBbVb6SAlawezWID95eawAL
 9StecMowWISt_J6zYXOWKjgRhKa4GEh52pInoPv_LZDOlVgiL7.KsjHTktB4
 0Zx9XWp25koz0rev_Eue6zpk5JDfTOTFu_B7Z.yDrSlvW8dDlVflg__jTyh6
 8DaTV2xpKWTnneoJ9FQDB9bphXzgB.o.wGXK0u5BOFS9cNKd4GYgs32yO2Hx
 EB2VxTpaqIblqkSf6u80lsjotlPlG4nbznKWuABoe39f_Nl67uba4EVew3D5
 noRB_uyP_yAvXkf2IFQP5TJMKtw82hwLacRHd_KCU6KWIVep.OvrZv4r2OzM
 2
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@117.254.174.115 with plain [106.10.150.171])
        by smtp135.mail.sg3.yahoo.com with SMTP; 19 May 2014 08:42:24 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-7-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249590>

Hi,

Is there any difference between the below 2 commands ? I didn't see anything.

git rm --cached  -- <file1> .. <fileN>
git checkout  -- <file1> .. <fileN>


-- 
===============
Regards,
Arup Rakshit
