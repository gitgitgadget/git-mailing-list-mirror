From: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
Subject: Re: branching based on tag.
Date: Fri, 04 May 2012 11:53:56 +0200
Message-ID: <d0a5c7b492d53912d12f25ba6f8fe828@ulrik.uio.no>
References: <CABECqUE-WqnR_wQzMsuEFmUu86_9i+GnJdEKYXwB+WancTFnOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: karunakar merugu <karuna.linux@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 11:54:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQFD9-0003cW-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 11:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab2EDJx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 05:53:59 -0400
Received: from mail-out1.uio.no ([129.240.10.57]:36150 "EHLO mail-out1.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917Ab2EDJx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 05:53:58 -0400
Received: from mail-mx5.uio.no ([129.240.10.46])
	by mail-out1.uio.no with esmtp (Exim 4.75)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SQFD3-0008IK-36; Fri, 04 May 2012 11:53:57 +0200
Received: from w3prod-wm03.uio.no ([129.240.4.40] helo=webmail.uio.no)
	by mail-mx5.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	user hbf (Exim 4.76)
	(envelope-from <h.b.furuseth@usit.uio.no>)
	id 1SQFD2-0003js-Jv; Fri, 04 May 2012 11:53:56 +0200
Received: from bombur.uio.no ([129.240.6.233])
 by webmail.uio.no
 with HTTP (HTTP/1.1 POST); Fri, 04 May 2012 11:53:56 +0200
In-Reply-To: <CABECqUE-WqnR_wQzMsuEFmUu86_9i+GnJdEKYXwB+WancTFnOA@mail.gmail.com>
X-Sender: h.b.furuseth@usit.uio.no
User-Agent: Roundcube Webmail/0.4.2
X-UiO-Ratelimit-Test: rcpts/h 2 msgs/h 1 sum rcpts/h 9 sum msgs/h 1 total rcpts 2406 max rcpts/h 20 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 543C4B9FBCAF01876569C8C766A46D5A36A23664
X-UiO-SPAM-Test: remote_host: 129.240.4.40 spam_score: -49 maxlevel 80 minaction 2 bait 0 mail/h: 305 total 1291276 max/h 414 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197011>

 On Fri, 4 May 2012 14:48:58 +0530, karunakar merugu wrote:
> git tag -l
> it gives me the lot of tags.I just want to work on some specific
> tag.Is it possible for me to create separate branch on that specific
> tag.

 Start a new branch from the tag, and check that
 branch out so you can work in it:

     git checkout -b your-new-branch tagname

 This is shorthand for the two commands
     git branch   your-new-branch tagname
     git checkout your-new-branch

 You should probably not move the tag, though you
 can with the 'git tag' command.

-- 
 Hallvard
