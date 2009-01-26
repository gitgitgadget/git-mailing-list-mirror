From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH v2] Change octal literals to be XEmacs friendly
Date: Mon, 26 Jan 2009 23:59:47 +0100
Message-ID: <877i4had24.fsf@wine.dyndns.org>
References: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru>
	<874ozp79y4.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jan 27 00:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRaoN-0008Nq-FP
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 00:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbZAZXWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 18:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752667AbZAZXWc
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 18:22:32 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:37990 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbZAZXWc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 18:22:32 -0500
X-Greylist: delayed 1355 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jan 2009 18:22:31 EST
Received: from adsl-62-167-29-78.adslplus.ch ([62.167.29.78] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1LRaQn-0007iW-75; Mon, 26 Jan 2009 16:59:55 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 07CA51E71F0; Mon, 26 Jan 2009 23:59:47 +0100 (CET)
In-Reply-To: <874ozp79y4.fsf@Astalo.kon.iki.fi> (Kalle Olavi Niemitalo's
	message of "Sat, 24 Jan 2009 03:46:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107295>

Kalle Olavi Niemitalo <kon@iki.fi> writes:

> Vassili Karpov <av1474@comtv.ru> writes:
>
>> #ooctal syntax on the other hand produces integers everywhere.
>
> GNU Emacs 20.7 doesn't support #o, but neither does it include
> the ewoc and log-edit libraries required by the current git.el.
>
> It would be nice to have a comment in git.el saying which
> versions of Emacs and XEmacs it is supposed to support, but I
> guess people wouldn't bother testing those on every commit.

I try to make sure that it still works with Emacs 21, but for older
versions you're on your own. Of course if you find problems patches are
welcome...

-- 
Alexandre Julliard
julliard@winehq.org
