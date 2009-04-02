From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 2/3] mergetool-lib: specialize xxdiff options when in diff mode
Date: Thu, 2 Apr 2009 23:20:55 +0200
Message-ID: <200904022320.55334.markus.heidelberg@web.de>
References: <1238668246-762-1-git-send-email-davvid@gmail.com> <1238668246-762-2-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 23:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpUNP-0004bs-4p
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 23:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245AbZDBVVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 17:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755496AbZDBVVA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 17:21:00 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:39234 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbZDBVVA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 17:21:00 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id DBF71FF582A1;
	Thu,  2 Apr 2009 23:20:55 +0200 (CEST)
Received: from [89.59.93.159] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LpULH-0005e2-00; Thu, 02 Apr 2009 23:20:55 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238668246-762-2-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+BSt7Rhf56M46WTvC0y+UKU5vqv4jt5SsyN9/9
	iuQB10l+WGxtvVFe61a5yV1GoIciqUVAlCggMzo2BJyqMQpJUR
	H5V2oc753qAFehJCNykg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115498>

David Aguilar, 02.04.2009:
> We don't need '-merged-file', 'save as', and the merge-status exit
> code when in diff mode

I guess the same as for xxdiff and kdiff3 also applies to opendiff,
ecmerge and emerge. But since I don't have them installed, I'm not
entirely sure not to break something.
On the other hand it should be save, since they were just copied from
git-mergetool without adjustment for diff use.

Markus
