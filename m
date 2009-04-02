From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 10/10] mergetool: use run_mergetool from git-mergetool-lib
Date: Thu, 2 Apr 2009 22:16:50 +0200
Message-ID: <200904022216.51159.markus.heidelberg@web.de>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <20090402200235.GB13817@hashpling.org> <200904022213.15173.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:19:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpTNS-0002cT-Sb
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 22:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762473AbZDBURL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 16:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761972AbZDBURK
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 16:17:10 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:48419 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762439AbZDBURI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 16:17:08 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 1F470FF56673;
	Thu,  2 Apr 2009 22:16:52 +0200 (CEST)
Received: from [89.59.93.159] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LpTLH-0007wC-00; Thu, 02 Apr 2009 22:16:51 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200904022213.15173.markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18D6RJ8o/6WE0KRZef3mLwM0qcj0G5bY8yyBQUb
	X+9B/f1pFzPTllhLH4AE3IkSSKwQtLrpbGaRolPTEJRbVTixvN
	cCpwnjfOD/qfbiNVR+OQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115494>

Markus Heidelberg, 02.04.2009:
> Huh, it seems as if some editors for difftool cannot work correctly
> currently, because this function is used, but defined in
> git-mergetool.sh.

Yes, it works...

# Overridden in git-mergetool
check_unchanged () {
	true
}

But that's not really nice, is it? Maybe we'd be better with a

    if merge_mode; then

inside this function and only define it in git-mergetool--lib.sh.

Markus
