From: Marc Weber <marco-oweber@gmx.de>
Subject: Re: Git and Amazon S3
Date: Tue, 02 Feb 2010 15:04:39 +0100
Message-ID: <1265119362-sup-1889@nixos>
References: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 15:05:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcJN3-0007PT-R3
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 15:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756108Ab0BBOEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 09:04:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:54474 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756017Ab0BBOEn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 09:04:43 -0500
Received: (qmail invoked by alias); 02 Feb 2010 14:04:40 -0000
Received: from mawercer.at.xencon.net (EHLO mail.gmx.net) [83.246.111.127]
  by mail.gmx.net (mp019) with SMTP; 02 Feb 2010 15:04:40 +0100
X-Authenticated: #9006135
X-Provags-ID: V01U2FsdGVkX1+89I8hN+e8ZA+Y+ECePhLgT6KwPnJDqTim6VMFxq
	/UGnc3HNfHufJC
Received: by mail.gmx.net (sSMTP sendmail emulation); Tue, 02 Feb 2010 15:04:39 +0100
In-reply-to: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
User-Agent: Sup/git
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138718>

> Does anyone have any remarks about these options? Is there a better option - how
> difficult would it be to add native support to git? Are there any other options

There are also tools such as curlftpfs. Then you can mount any FTP
account. However git will be slow. There are some .git options.
Maybe it's worth a try - Don't know excactly.

There should be fuse like filesystems for Amazon S3 as well. Google
showns some hits. Don't know which one works best.

Good luck.
Marc Weber
