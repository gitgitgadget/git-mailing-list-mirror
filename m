From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 21:05:48 +0200
Message-ID: <m2ehlfnzoz.fsf@igel.home>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<CABURp0pbX4Fk4sNWCicfF7Gm52-KTMBrasdi_XHnjtE2zmSBFg@mail.gmail.com>
	<CAB9Jk9CdYXZzPcM=YiwOUyKNQ=4uKpfs+HY7WpWBmqgQRw4SyA@mail.gmail.com>
	<CAJsNXTm5uhWYB+oiz=3WQQKFQ=i=+oO0L6cgGBB+2cm5BgfFCg@mail.gmail.com>
	<CAB9Jk9D5c-7QKkUFtur4rxBfiaPFzGaMi-+m=Owje_Aaoc6XJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: PJ Weisberg <pj@irregularexpressions.net>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIL-0001DP-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348Ab2JCTFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 15:05:53 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47050 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2JCTFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 15:05:52 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XX6Bh6Js2z3hhVy;
	Wed,  3 Oct 2012 21:05:48 +0200 (CEST)
X-Auth-Info: wvBYQIOPwbbhSlsEy3h+H8nKdfOZQLOJzHZRi7NZlHc=
Received: from igel.home (ppp-93-104-158-56.dynamic.mnet-online.de [93.104.158.56])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XX6Bh5tzCzbbg3;
	Wed,  3 Oct 2012 21:05:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 8A7CFCA2B8; Wed,  3 Oct 2012 21:05:48 +0200 (CEST)
X-Yow: I Know A Joke
In-Reply-To: <CAB9Jk9D5c-7QKkUFtur4rxBfiaPFzGaMi-+m=Owje_Aaoc6XJQ@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 3 Oct 2012 19:34:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206927>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Take then a git commit --allow-empty: if the trees are equal it may
> create a commit or not depending on the parent, message, author and
> date; if the trees are different it creates a commit.

The commit is _always_ created, with a name depending on the parent,
message, author and date.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
