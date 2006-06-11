From: "Marco Costalba" <mcostalba@gmail.com>
Subject: gitweb.cgi history not shown
Date: Sun, 11 Jun 2006 07:31:17 +0200
Message-ID: <e5bfff550606102231o756f6d11lc46fecdad29568c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 11 07:31:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpIXg-0002Ni-Rr
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 07:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWFKFbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 01:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWFKFbS
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 01:31:18 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:12940 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932098AbWFKFbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jun 2006 01:31:17 -0400
Received: by py-out-1112.google.com with SMTP id x31so1361774pye
        for <git@vger.kernel.org>; Sat, 10 Jun 2006 22:31:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lQwPleigkcr6FgaNWZgdqCPGDIIug4p2CSq5NTN0NpOgbBMaZGazxrmYTJR0jXUphpWrwOm1qIoNc6Sy0R6Mxw0iEz2pbEbBgpF5Ggmd+Ome1cBy5LU6pk1Zm11dfrkIG4PKREyKWFSqEIV6CT0TZ/njR+m6H/RQ1sXNLTkPCPU=
Received: by 10.35.106.15 with SMTP id i15mr5320206pym;
        Sat, 10 Jun 2006 22:31:17 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 10 Jun 2006 22:31:17 -0700 (PDT)
To: junkio@cox.net
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21632>

What I do wrong?

$ git-rev-list --all -- gitweb/gitweb.cgi
0a8f4f0020cb35095005852c0797f0b90e9ebb74
$ git-rev-list --all -- gitweb.cgi
$

Also the installed gitweb at kernel.org gives an empty history for
file gitweb.cgi under git repository, while the history is correctly
shown for the same file under the gitweb project.

    Marco
