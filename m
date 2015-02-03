From: "Hans Kristian Otnes Berge" <hansbe@ifi.uio.no>
Subject: symlinked files
Date: Tue, 3 Feb 2015 10:12:57 +0100
Message-ID: <006001d03f91$a00d0500$e0270f00$@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 10:35:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIZsy-0000sG-Q0
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 10:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959AbbBCJfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 04:35:04 -0500
Received: from mail-out5.uio.no ([129.240.10.17]:47837 "EHLO mail-out5.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbbBCJfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 04:35:00 -0500
X-Greylist: delayed 1310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Feb 2015 04:34:59 EST
Received: from mail-mx4.uio.no ([129.240.10.45])
	by mail-out5.uio.no with esmtp (Exim 4.80.1)
	(envelope-from <hansbe@ifi.uio.no>)
	id 1YIZXg-0005BH-Jd
	for git@vger.kernel.org; Tue, 03 Feb 2015 10:13:08 +0100
Received: from 82.122.45.31.customer.cdi.no ([31.45.122.82] helo=HANSBEL)
	by mail-mx4.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hansbe (Exim 4.80)
	(envelope-from <hansbe@ifi.uio.no>)
	id 1YIZXg-00015J-4e
	for git@vger.kernel.org; Tue, 03 Feb 2015 10:13:08 +0100
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdA/j9dUMpsM/URwSOSQi1azjb/ROQ==
Content-Language: no
X-UiO-SPF-Received: 
X-UiO-Ratelimit-Test: rcpts/h 1 msgs/h 1 sum rcpts/h 1 sum msgs/h 1 total rcpts 738 max rcpts/h 48 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, TVD_RCVD_IP=0.001,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: AD9CFE07FDC15A5B09E1F1ACD6C9649CC4211403
X-UiO-SPAM-Test: remote_host: 31.45.122.82 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 1 total 68 max/h 3 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263316>

Hi

First of all thanks for a great piece of software!!

I have a tiny complaint though, about git not allowing symlinked files (in
an easy way).

I would use this to keep track of the contents of a file that is also being
developed and shared across other projects, but later changes to it could
break a few things in each project. Although I understand it makes for some
complications, and it fails to meet basic KISS principles, it would be great
to be able to override the default behavior for instance via the config or
add command or something in the info directory. I suppose there are lots of
work-arounds to this (just a bit more hassle), so no worries if you don't
like it.

Thanks!

Hans Kristian
