From: Richard Yang <weiyang@linux.vnet.ibm.com>
Subject: How can I specify the "sendmail" program for git-send-email?
Date: Mon, 11 Jun 2012 15:32:32 +0800
Message-ID: <20120611073232.GA5602@richard>
Reply-To: Richard Yang <weiyang@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 09:32:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdz7H-0006rf-JY
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 09:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab2FKHcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 03:32:43 -0400
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:45064 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2FKHcm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 03:32:42 -0400
Received: from /spool/local
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <weiyang@linux.vnet.ibm.com>;
	Mon, 11 Jun 2012 07:22:04 +1000
Received: from d23relay04.au.ibm.com (202.81.31.246)
	by e23smtp03.au.ibm.com (202.81.31.209) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 11 Jun 2012 07:22:02 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q5B7PK1X8192364
	for <git@vger.kernel.org>; Mon, 11 Jun 2012 17:25:20 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q5B7WZ8p016218
	for <git@vger.kernel.org>; Mon, 11 Jun 2012 17:32:36 +1000
Received: from localhost ([9.123.247.68])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id q5B7WX4p016132
	for <git@vger.kernel.org>; Mon, 11 Jun 2012 17:32:34 +1000
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
x-cbid: 12061021-6102-0000-0000-000001AA7BF9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199630>

Hi, experts

I read the git-send-email manual and find the --smtp-server option can
specify the sendmail-like program to send mail.

Then I use this option in command line 
--smtp-server=/usr/bin/msmtp
This works.

While I found it not very convenient to write the option on command line
every time, then I wrote it in the .gitconfig file in my home directory.

[sendmail]
	smtpserver = /usr/bin/msmtp
	smtppass       = 123456
	smtpuser       = weiyang@linux.vnet.ibm.com
        smtpserverport = 143

While this time I don't use the --smtp-server option in command line. 

And seems this time, it doesn't use the msmpt to send mail, since this
time it fails.

Then my second approach is not correct? 

-- 
Richard Yang
Help you, Help me
