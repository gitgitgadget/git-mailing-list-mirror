From: Amit Walambe <awalambe@arcom.com>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 18:06:19 +0100
Message-ID: <469CF70B.7080207@arcom.com>
References: <469CE836.6010508@arcom.com> <20070717161607.GD16209@cip.informatik.uni-erlangen.de> <469CF00C.4040906@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Amit Walambe (awalambe@arcom.com)" <awalambe@arcom.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqVM-0005eM-8D
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 19:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbXGQRG2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 13:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbXGQRG2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 13:06:28 -0400
Received: from mail28.messagelabs.com ([216.82.249.131]:53747 "HELO
	mail28.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754436AbXGQRG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 13:06:27 -0400
X-VirusChecked: Checked
X-Env-Sender: awalambe@arcom.com
X-Msg-Ref: server-19.tower-28.messagelabs.com!1184691981!43413005!1
X-StarScan-Version: 5.5.12.11; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Received: (qmail 12389 invoked from network); 17 Jul 2007 17:06:22 -0000
Received: from mail2.arcom.com (HELO mail2.arcom.com) (194.200.159.164)
  by server-19.tower-28.messagelabs.com with SMTP; 17 Jul 2007 17:06:22 -0000
Received: from amit.arcom.cc [10.2.2.55] by mail2.arcom.com with ESMTP
  (SMTPD32-8.00) id A8497FD00DA; Tue, 17 Jul 2007 18:11:37 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <469CF00C.4040906@arcom.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52777>

Amit Walambe wrote:
> I didn't build my own git version. What I did do was to remove the old 
> git and ensure I am using the Debian installed one.
> 
> Now I am getting a different error :
> root@amit:/usr/src/linux-git # which git
> /usr/bin/git
> root@amit:/usr/src/linux-git # git --version
> git version 1.5.2.3
> root@amit:/usr/src/linux-git # git bisect good v2.6.22-rc6
> root@amit:/usr/src/linux-git # git bisect bad v2.6.22-rc8
> fatal: Needed a single revision
> root@amit:/usr/src/linux-git #
I should call it a day. Above commands are wrong. I need to work on -git 
kernels and not -rc kernels (as the above commands are showing).
I am still getting the same errors I started with :

root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
Bad rev input: v2.6.22-git6
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git # git bisect good v2.6.22-git8
Bad rev input: v2.6.22-git8

> A quick search on the net didn't yield anything. Please help me find out 
> what's going wrong.
> Thanks and Regards,
The above greatly applies :)
-- 
Amit Walambe
Design Engineer, Arcom Control Systems Ltd.
http://www.arcom.com
Tel: +44-(0)1223 411200 ext. 3204
Direct: +44-(0)1223 403465

_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
