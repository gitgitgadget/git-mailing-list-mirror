From: Christof =?ISO-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
Subject: Re: Merging some existing svn code
Date: Mon, 04 Jul 2011 18:00:02 +0200
Message-ID: <1309795202.18226.3.camel@oxylap>
References: <CAHVO_930ECHRYR7RsKGa61OtBhwyFA5Mt9NxpD6Ysq9jJBgk-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 04 18:00:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdlZG-0006cB-L1
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 18:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757746Ab1GDQAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jul 2011 12:00:09 -0400
Received: from vserver.localhost.li ([85.214.46.152]:56470 "EHLO
	mail.localhost.li" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab1GDQAI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 12:00:08 -0400
Received: from p5794cc85.dip.t-dialin.net ([87.148.204.133]:35866 helo=[192.168.0.126])
	by mail.localhost.li with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <git@christof-krueger.de>)
	id 1QdlZ6-0002ea-Mi; Mon, 04 Jul 2011 18:00:06 +0200
In-Reply-To: <CAHVO_930ECHRYR7RsKGa61OtBhwyFA5Mt9NxpD6Ysq9jJBgk-g@mail.gmail.com>
X-Mailer: Evolution 2.30.3 
X-Spam-Score: 0.0 (/)
X-Spam-Report: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176602>

On Mo, 2011-07-04 at 13:59 +0100, Howard Miller wrote:
> Firstly I have an application "under" git....  years ago I wrote a
> plugin for the app (and by that I mean that it does not affect the
> main code in any way) and that used svn. I've cloned the svn
> repository using git svn so I have the history. I'd like to pull this
> into the main project by moving the history onto a new branch. There
> will be no merge issues but I'm unsure of the steps to take. The file
> structure is not the same as the svn repository only covered the
> required directory.
Sounds like a subtree merge could help you, see [1].
Just ask if there is anything in the description that doesn't work for
you.

Regards,
  Chris

[1]
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
