From: Jing Xue <jingxue@digizenstudio.com>
Subject: gitk error: expected integer but got "Hamano"
Date: Sun, 2 Dec 2007 11:02:04 -0500
Message-ID: <20071202160204.GA13141@fawkes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 17:02:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyrHE-0005V5-DO
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 17:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752103AbXLBQCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 11:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbXLBQCT
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 11:02:19 -0500
Received: from k2smtpout06-01.prod.mesa1.secureserver.net ([64.202.189.102]:60069
	"HELO k2smtpout06-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751455AbXLBQCT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 11:02:19 -0500
Received: (qmail 11146 invoked from network); 2 Dec 2007 16:02:18 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout06-01.prod.mesa1.secureserver.net (64.202.189.102) with ESMTP; 02 Dec 2007 16:02:18 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id F375C100AD0
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 16:02:17 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SvfvDSjXtGrd for <git@vger.kernel.org>;
	Sun,  2 Dec 2007 11:02:05 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 4E9AD100A37
	for <git@vger.kernel.org>; Sun,  2 Dec 2007 11:02:05 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id 4EE4A9ACF1; Sun,  2 Dec 2007 11:02:04 -0500 (EST)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66786>


I keep running into this error today when using "gitk --all" in my local
git.git clone. It happens everytime when I use the mouse to grab the
thumb button on the scroll bar, and drag it up and down rapidly.

I'm running git 1.5.3.6.862.g3f72.

expected integer but got "Hamano"
expected integer but got "Hamano"
    while executing
"clock format $d -format $datetimeformat"
    (procedure "formatdate" line 4)
    invoked from within
"formatdate $date"
    (procedure "drawcmittext" line 52)
    invoked from within
"drawcmittext $id $row $col"
    (procedure "drawcmitrow" line 34)
    invoked from within
"drawcmitrow $r"
    (procedure "drawcommits" line 57)
    invoked from within
"drawcommits $row $endrow"
    (procedure "drawfrac" line 10)
    invoked from within
"drawfrac $f0 $f1"
    (procedure "scrollcanv" line 3)
    invoked from within
"scrollcanv .tf.histframe.csb 0.0613366 0.0636028"

I'd try to debug myself but my knowledge on tcl/tk is rather limited
(read: zero).

Cheers.
-- 
Jing Xue
