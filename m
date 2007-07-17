From: Amit Walambe <awalambe@arcom.com>
Subject: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 17:03:02 +0100
Message-ID: <469CE836.6010508@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Amit Walambe (awalambe@arcom.com)" <awalambe@arcom.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 18:03:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IApW9-00072U-VD
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbXGQQDJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbXGQQDI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:03:08 -0400
Received: from mail28.messagelabs.com ([216.82.249.131]:50872 "HELO
	mail28.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753142AbXGQQDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:03:06 -0400
X-VirusChecked: Checked
X-Env-Sender: awalambe@arcom.com
X-Msg-Ref: server-17.tower-28.messagelabs.com!1184688183!49230484!1
X-StarScan-Version: 5.5.12.11; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Received: (qmail 31947 invoked from network); 17 Jul 2007 16:03:04 -0000
Received: from mail2.arcom.com (HELO mail2.arcom.com) (194.200.159.164)
  by server-17.tower-28.messagelabs.com with SMTP; 17 Jul 2007 16:03:04 -0000
Received: from amit.arcom.cc [10.2.2.55] by mail2.arcom.com with ESMTP
  (SMTPD32-8.00) id A97376000DA; Tue, 17 Jul 2007 17:08:19 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52765>

Hi!
I was trying to do a git bisect on 2.6.22-git6 and 2.6.22-git8. For 
which I get following error :
root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
Bad rev input: v2.6.22-git6

The repository is obtained by :
root@amit:/usr/src # git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 linux-git

I am running following git version on Debian Sid, updated today.
# git --version
git version 0.99.8.GIT
'# dpkg -l | grep git' shows ' git-core 
1:1.5.2.3-1'

I tried searching man-pages/documentation/website but couldn't find any 
references to git bisect on -git kernels. I would be grateful if anyone 
can help me find what's going wrong.

As I am not subscribed to the mailing-list, please cc me to all the 
messages on the thread.
Thanks and Regards,
-- 
Amit Walambe
Design Engineer, Arcom Control Systems Ltd.
http://www.arcom.com
Tel: +44-(0)1223 411200 ext. 3204
Direct: +44-(0)1223 403465

_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
