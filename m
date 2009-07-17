From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 2/2] Improve doc for format-patch threading options.
Date: Sat, 18 Jul 2009 01:23:41 +0200
Message-ID: <200907180123.41735.markus.heidelberg@web.de>
References: <cover.1246834883.git.ydirson@altern.org> <200907170058.46962.markus.heidelberg@web.de> <20090717065236.GE5762@nan92-1-81-57-214-146.fbx.proxad.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Jul 18 01:23:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRwmE-0005qL-6C
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 01:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbZGQXXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 19:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbZGQXXU
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 19:23:20 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47424 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbZGQXXT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 19:23:19 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 07A4010659067;
	Sat, 18 Jul 2009 01:23:17 +0200 (CEST)
Received: from [89.59.107.28] (helo=pluto)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MRwlo-0003Dd-00; Sat, 18 Jul 2009 01:23:16 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090717065236.GE5762@nan92-1-81-57-214-146.fbx.proxad.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18O/1F62oBx+fDFPiBnsbFANFRuW0pXjFm+4ltf
	SBMNgBMzq8C4nPDCCytJDvjWc3RRu8SdVONXd7MF0C6gtbJzsI
	oRdXwbkN4oENrMxVqGOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123498>

Yann Dirson, 17.07.2009:
> On Fri, Jul 17, 2009 at 12:58:46AM +0200, Markus Heidelberg wrote:
> > > - even when --no-thread is specified, and format-patch was run with
> > > --no-thread as well, it still adds In-Reply-To and References headers,
> > > and I must say I do not see what in the code causes this behaviour.
> > 
> > This is caused by a bug fixed in commit 5e9758e29 (send-email: fix
> > non-threaded mails, 2009-06-12). Try using "git send-email --no-thread
> > --no-chain-reply" and it may work again. You should use an up-to-date
> > git, when searching for bugs.
> 
> I had tried exactly this just in case it would help, with current
> master (1.6.4rc1), and it still saw the same behaviour.

Strange, I can't reproduce it.
