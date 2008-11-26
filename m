From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: update Japanese translation
Date: Wed, 26 Nov 2008 13:28:28 -0800
Message-ID: <20081126212828.GA20382@spearce.org>
References: <20081126192144.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 22:29:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5RxD-0002i7-Fu
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 22:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYKZV23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 16:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbYKZV23
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 16:28:29 -0500
Received: from george.spearce.org ([209.20.77.23]:55204 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbYKZV22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 16:28:28 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 228F438200; Wed, 26 Nov 2008 21:28:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081126192144.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101771>

Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
>  po/ja.po | 1127 ++++++++++++++++++++++++++++++++++++++++++++++----------------
>  1 files changed, 833 insertions(+), 294 deletions(-)

Hmm.

$ make V=1
msgfmt --statistics --tcl -l ja -d po/ po/ja.po
po/ja.po:1558: `msgid' and `msgstr' entries do not both begin with '\n'
po/ja.po:1567: `msgid' and `msgstr' entries do not both begin with '\n'
po/ja.po:1602: `msgid' and `msgstr' entries do not both begin with '\n'
po/ja.po:1883: `msgid' and `msgstr' entries do not both begin with '\n'
po/ja.po:1931: `msgid' and `msgstr' entries do not both begin with '\n'
po/ja.po:1941: `msgid' and `msgstr' entries do not both begin with '\n'
po/ja.po:2342: `msgid' and `msgstr' entries do not both begin with '\n'
po/ja.po:2455: `msgid' and `msgstr' entries do not both begin with '\n'
msgfmt: found 8 fatal errors
make: *** [po/ja.msg] Error 1

Can you fix up the .po and resend?

-- 
Shawn.
