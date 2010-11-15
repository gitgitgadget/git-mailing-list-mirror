From: "Dennis" <dennisfm@friendlymatch.com>
Subject: Setting up Git Server over SSH
Date: Mon, 15 Nov 2010 13:20:15 -0500
Message-ID: <B99C7057496B47E48E5ABED7DE6BA51A@denny>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 15 19:30:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI3pG-0000Bn-3L
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 19:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996Ab0KOSag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 13:30:36 -0500
Received: from fmailhost04.isp.att.net ([204.127.217.104]:54267 "EHLO
	fmailhost04.isp.att.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758117Ab0KOSae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 13:30:34 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Nov 2010 13:30:34 EST
DKIM-Signature: v=1; q=dns/txt; d=ameritech.net; s=dkim01;
      i=dennismv@ameritech.net; a=rsa-sha256; c=relaxed/relaxed;
      t=1289845834; h=Content-Transfer-Encoding:Content-Type:
     MIME-Version:Date:Subject:To:From:Message-ID; bh=mSZG1+F4DhC+uXKtI4
     xK6gMlynqyreXgTH6U2XyBtdE=; b=o/Yxj8T8OYjrcztseTWHm8CaIWafpsPw/bUnf
     ttiSiURYFjiRYYRb1xu7VzTE1ZGHArwiqSdd1WuUhRUvIzIGA==
Received: from denny (d118-75-134-244.clv.wideopenwest.com[75.118.244.134])
          by isp.att.net (frfwmhc04) with SMTP
          id <20101115182019H0400o0lqme>; Mon, 15 Nov 2010 18:20:19 +0000
X-Originating-IP: [75.118.244.134]
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161497>

I have a remote server (hostname.com) that acts as a webserver.
What I did is I wanted to set up my public_html folder as a public 
repository.
After trial and error I am still at stage_0.

Thus, on that server I have /home/user/.git directory and the repo works 
fine if I am accessing it from the server.

Now, I want to clone that repo onto my local machine.
I am doing this, but it fails:

>git clone ssh://hostname.com:/home/user/.git
Cloning into user...
fatal: protocol error: bad line length character: logi

>Access denied
Access denied
Access denied
Access denied
Access denied
Access denied
FATAL ERROR: Server sent disconnect message
type 2 (protocol error):
"Too many authentication failures for "
--------------------------------

What can I do to make it work?
Dennis
