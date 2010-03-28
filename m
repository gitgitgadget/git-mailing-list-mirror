From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v3] gitk: Use git-difftool for external diffs
Date: Sun, 28 Mar 2010 11:59:06 +0100
Message-ID: <201003281259.06947.markus.heidelberg@web.de>
References: <1269726316-30443-1-git-send-email-davvid@gmail.com> <1269735600-12769-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 12:57:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvqBb-00043X-HJ
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 12:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438Ab0C1K5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 06:57:25 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:48820 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab0C1K5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 06:57:24 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6DF7A14916E59;
	Sun, 28 Mar 2010 12:57:23 +0200 (CEST)
Received: from [91.19.2.33] (helo=pluto.localnet)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NvqBH-00040R-00; Sun, 28 Mar 2010 12:57:23 +0200
User-Agent: KMail/1.12.4 (Linux/2.6.30-gentoo-r8; KDE/4.3.5; i686; ; )
In-Reply-To: <1269735600-12769-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18clKbRd2bpl5drI8uo8fBo27Q6I3U+9OJS0jhd
	iLNmz40FLmFtFxLBe8dNvjNqk9n+LAZQgGDfceRfWWf+LaoW0C
	AQLXcpHcu5X0ALdFFOug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143384>

David Aguilar, 2010-03-28 01:20:
> +    set cmd [list "git" "difftool" "--no-prompt" "--extcmd" $extdifftool]

According to "man gitcli" this should be "--extcmd=$extdifftool".

Besides this, works for me.

Markus
