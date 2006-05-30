From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: t9001 fails because Net::SMTP is missing
Date: Tue, 30 May 2006 21:26:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605302125310.11586@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue May 30 21:27:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl9rq-0005kd-7l
	for gcvg-git@gmane.org; Tue, 30 May 2006 21:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWE3T05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 15:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWE3T05
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 15:26:57 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:33956 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932406AbWE3T04 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 15:26:56 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id C375D1C7A
	for <git@vger.kernel.org>; Tue, 30 May 2006 21:26:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id B81C31C73
	for <git@vger.kernel.org>; Tue, 30 May 2006 21:26:55 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 9CF621C68
	for <git@vger.kernel.org>; Tue, 30 May 2006 21:26:55 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21043>

Hi,

is it unexpected that there are setups which come without Net::SMTP?

-- snip --
* expecting success: git format-patch -n HEAD^1
     git send-email -from="Example <nobody@example.com>" 
--to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" ./0001*txt
0001-Second.txt
Can't locate Net/SMTP.pm in @INC (@INC contains: 
/System/Library/Perl/darwin /System/Library/Perl /Library/Perl/darwin 
/Library/Perl /Library/Perl /Network/Library/Perl/darwin 
/Network/Library/Perl /Network/Library/Perl .) at 
/Users/gene099/my/git-current/t/../git-send-email line 24.
BEGIN failed--compilation aborted at 
/Users/gene099/my/git-current/t/../git-send-email line 24.
* FAIL 3: Extract patches and send
-- snap --

Ciao,
Dscho
