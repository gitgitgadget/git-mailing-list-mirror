From: Andreas Schneider <as@gestaltung.com>
Subject: GIT over HTTP
Date: Thu, 22 Jul 2010 11:03:50 +0900
Message-ID: <AF1397F5-0394-4CCD-937A-7B11513CC174@iamas.ac.jp>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 22 04:04:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obl8u-0000sY-RT
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 04:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab0GVCD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 22:03:57 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:40861 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab0GVCD4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jul 2010 22:03:56 -0400
Received: by pvc7 with SMTP id 7so2854533pvc.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 19:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=QH57LaIWS2b8lLR8A/9QDSr7jIGrDPhlAjXAvCwUip8=;
        b=TYfW5dkT9bIO+/x9Ml0FEcRCU9IhS2YuSjPbL5CmxVc8N6pvxrW4qL4CbbHhdxkeXu
         LTsEi0VPRG/wf4PJMXwsujpuh5kIZdIQCIBTjInCNmJq0z0mrmgiMUfdrYNsi9jxDTtx
         kA2IsEQLPUBgkBOVgF6A6JDlsLG0B1baCtdI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:content-type:content-transfer-encoding:subject:date
         :message-id:to:mime-version:x-mailer;
        b=w43LKQ1RZrtcZ/p1h28hzVYgae6jlEkf0k3+9mP9657o20gaBbAzbEa//3WdgiYXuZ
         YJ64eiLrFLxOwPsfELp5QB4Op+cmX8Zm7yvFu5FF+84TXlyXaRg+JtnRYMrh1OLV8Ikz
         OCObMqG2FkI4Vx9z+2+tuL9CjXvOT4tB7EKxM=
Received: by 10.142.212.2 with SMTP id k2mr1354779wfg.168.1279764235564;
        Wed, 21 Jul 2010 19:03:55 -0700 (PDT)
Received: from [192.168.1.18] (z225171.dynamic.ppp.asahi-net.or.jp [110.4.225.171])
        by mx.google.com with ESMTPS id c38sm2616350rvf.5.2010.07.21.19.03.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 19:03:54 -0700 (PDT)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151441>

after lost of research on the www i am still at a loss on how to
properly do push/pull over HTTP

it seems to work on the GIT level, however PUSHS to the remote repository do
NOT show up in the file-structure: adding a file locally, then pushing to the remote repository - the file will not appear in the remote listing, however it became part of the remote repository.


in the httpd.conf i put these directives

<Location /GIT>
  AllowOverride All
  DAV on
</Location>
<Location /GIT/.git>
  AuthType Basic
  AuthName "Git"
  AuthUserFile /etc/httpd/conf/pwd
  Require valid-user
</Location>


as /GIT is the publicly accessible site- i put authentication in the /GIT/.git
location



another issue i can't seem to solve:
having a REWRITE directive in the /GIT directory seems to obstruct any PUSH
attempt from the local repository...



any help would be highy appreciated!


	thanx,

		andreas




. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
IAMAS
Institute of Advanced Media Arts and Sciences

	andreas schneider

	T +81-80-5538 9767
	T.F.M +1-206-350 5073, voiceMail/Fax


. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
SPAM FILTER notice:
Please note that your mail might get caught by SPAM filtering midways.
Using an unambiguous SUBJECT line helps to sort out the good from the bad ;-)
