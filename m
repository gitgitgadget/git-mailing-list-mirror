From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] gitk: Use git-difftool for external diffs
Date: Sat, 21 Nov 2009 00:33:42 +0100
Message-ID: <200911210033.42661.markus.heidelberg@web.de>
References: <1258341126-2108-1-git-send-email-davvid@gmail.com> <7vhbsp7htq.fsf@alter.siamese.dyndns.org> <20091120185522.GC56351@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>, peff@peff.net,
	sam@vilain.net, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 21 00:33:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBcys-0008NE-JP
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 00:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbZKTXdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 18:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753214AbZKTXdX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 18:33:23 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:37774 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbZKTXdW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 18:33:22 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 399271431DA2E;
	Sat, 21 Nov 2009 00:33:28 +0100 (CET)
Received: from [89.59.102.143] (helo=pluto.localnet)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #314)
	id 1NBcym-0006Cs-00; Sat, 21 Nov 2009 00:33:28 +0100
User-Agent: KMail/1.12.1 (Linux/2.6.30-gentoo-r8; KDE/4.3.1; i686; ; )
In-Reply-To: <20091120185522.GC56351@gmail.com>
Jabber-ID: markus.heidelberg@web.de
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/C0jbx2GQLdDYbb3I+2Z/cnRj/EbOoehRN31ep
	oFiQ4ACWTagaTEVbTpkh/WSWKqWuotcnA45vN3jzgdujAefpLP
	mapDeYbZ0AOW9IGTdzrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133386>

David Aguilar, 2009-11-20:
> The argument in favor of difftool is one of user
> expectations.  From a user's POV it ~seems~ desirable for
> gitk to honor difftool configurations.

In general I absolutely like the idea. There are however problems you
can encounter.
I use vimdiff for git-difftool and gvimdiff for gitk. When testing gitk
with your patch, I wondered where the editor is, because nothing popped
up. I then found vim on the terminal from where I started gitk. Even
worse: when started with "gitk &", the vim process runs somewhere in the
background and gitk freezes.

To overcome this problem maybe we need a second config variable like
diff.guitool.

Markus
