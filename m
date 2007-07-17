From: Amit Walambe <awalambe@arcom.com>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 17:36:28 +0100
Message-ID: <469CF00C.4040906@arcom.com>
References: <469CE836.6010508@arcom.com> <20070717161607.GD16209@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Amit Walambe (awalambe@arcom.com)" <awalambe@arcom.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 17 18:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAq2b-0002sK-11
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757446AbXGQQgf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 12:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755632AbXGQQgf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:36:35 -0400
Received: from mail28.messagelabs.com ([216.82.249.131]:53414 "HELO
	mail28.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754016AbXGQQge (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:36:34 -0400
X-VirusChecked: Checked
X-Env-Sender: awalambe@arcom.com
X-Msg-Ref: server-17.tower-28.messagelabs.com!1184690191!49231979!1
X-StarScan-Version: 5.5.12.11; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Received: (qmail 27317 invoked from network); 17 Jul 2007 16:36:32 -0000
Received: from mail2.arcom.com (HELO mail2.arcom.com) (194.200.159.164)
  by server-17.tower-28.messagelabs.com with SMTP; 17 Jul 2007 16:36:32 -0000
Received: from amit.arcom.cc [10.2.2.55] by mail2.arcom.com with ESMTP
  (SMTPD32-8.00) id A14A7B700DA; Tue, 17 Jul 2007 17:41:46 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <20070717161607.GD16209@cip.informatik.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52773>

Hi,
Thanks for both the replies.

Thomas Glanzmann wrote:
> Hello,
> 
>> # git --version
>> git version 0.99.8.GIT
> 
> this doesn't match
> 
>> '# dpkg -l | grep git' shows ' git-core 1:1.5.2.3-1'
This struck me as being weird, but I thought 'git' utility version is 
different than the package. My mistake! :)

> that. Maybe you should build your own git packages. Lucky you that it is
> pretty easy with debian. Have a look at this thread:
I didn't build my own git version. What I did do was to remove the old 
git and ensure I am using the Debian installed one.

Now I am getting a different error :
root@amit:/usr/src/linux-git # which git
/usr/bin/git
root@amit:/usr/src/linux-git # git --version
git version 1.5.2.3
root@amit:/usr/src/linux-git # git bisect good v2.6.22-rc6
root@amit:/usr/src/linux-git # git bisect bad v2.6.22-rc8
fatal: Needed a single revision
root@amit:/usr/src/linux-git #

A quick search on the net didn't yield anything. Please help me find out 
what's going wrong.
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
