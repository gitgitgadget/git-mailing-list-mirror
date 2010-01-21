From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 09:00:55 -0500
Message-ID: <20100121140054.GH18213@onerussian.com>
References: <20100121004756.GA18213@onerussian.com>
 <20100121050850.GA18896@Knoppix>
 <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
 <20100121155136.17b59e8f.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 15:01:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXxat-0002LM-Gw
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 15:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab0AUOBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 09:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999Ab0AUOBA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 09:01:00 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:52085 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab0AUOA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 09:00:59 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NXxah-0005lU-5m; Thu, 21 Jan 2010 09:00:55 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NXxah-0005lR-1T; Thu, 21 Jan 2010 09:00:55 -0500
Content-Disposition: inline
In-Reply-To: <20100121155136.17b59e8f.rctay89@gmail.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: rctay89@gmail.com, ilari.liusvaara@elisanet.fi, spearce@spearce.org, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137656>

Hi Tay Ray,

That patch works fine for me ;) I only hope it would get accepted into
bugfix and next dev release  (I guess it might annoy some of apache
admins a bit due to increase of their errors.log now even for well
maintained repositories, but well -- that is life ;-) )

Thanks!
Yarik

On Thu, 21 Jan 2010, Tay Ray Chuan wrote:
> > afaik, putting a "?var1=val1&var2=...." still makes it a normal GET
> > request, even if the url requested is just a plain file and not some
> > cgi handler that uses those variables/values.

> Yaroslav, sorry for making you run in circles - it really is git's
> fault (sorta).

> In recent versions of git, we were sending out the GET request for
> info/refs with a query string (?serivce=<service name>). I'm not sure
> why, but your server is not playing nice when the query string is
> appended.

> Could you try this patch and see if it solves the issue? I manage to
> clone your repo successfully with it.
-- 
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
