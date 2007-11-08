From: Luke Diamand <luke@vidanti.com>
Subject: Problem with https and git-pull
Date: Thu, 08 Nov 2007 07:42:30 +0000
Message-ID: <4732BDE6.4020509@vidanti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 08:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq28A-0001j3-0Q
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 08:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXKHHsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 02:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbXKHHsf
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 02:48:35 -0500
Received: from c2bthomr13.btconnect.com ([213.123.20.131]:20013 "EHLO
	c2bthomr13.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXKHHsf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 02:48:35 -0500
Received: from mozart.ballroom.vidanti.com 
	by c2bthomr13.btconnect.com
	with ESMTP id DNC81958;
	Thu, 8 Nov 2007 07:42:30 GMT
Received: from cpc2-cmbg6-0-0-cust655.cmbg.cable.ntl.com ([81.107.34.144] helo=[192.168.245.128])
	by mozart.ballroom.vidanti.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1Iq222-0004aC-F8
	for git@vger.kernel.org; Thu, 08 Nov 2007 07:42:30 +0000
User-Agent: Icedove 1.5.0.12 (X11/20070606)
X-Junkmail-Status: score=10/50, host=c2bthomr13.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0202.4732BCAA.0181,ss=1,fgs=0,
	ip=81.107.34.144,
	so=2006-12-09 10:45:40,
	dmn=5.4.3/2007-10-18
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63948>

I'm finding that git-pull using https does not work in the way I would 
expect.

I created a bare repository, test.git, available by https://

I then cloned it:

% git-clone https://host/git/test.git

So far, so good.

Then I made a change in a different clone and pushed it.

When I next did git-pull it just said:

% git-pull
Fetching refs/heads/master from https://host/git/test.git using https
Already up-to-date.

But it *isn't* up-to-date! If I do the same exercise with git:// or 
ssh:// on the same repo then it pulls down my changes as expected.

Tried with:
   git version 1.5.3.4 (debian testing)
   git 1.5.3.5-dirty

curl is 7.16.4

The server access log shows the git-pull happening, and there are no 
errors reported by the server.

Is there something obvious I'm missing?

Thanks
Luke
