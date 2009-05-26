From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v3] diff: generate prettier filenames when using GIT_EXTERNAL_DIFF
Date: Tue, 26 May 2009 22:31:50 +0200
Message-ID: <200905262231.50892.markus.heidelberg@web.de>
References: <1243316165-99065-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	nick@incise.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 22:31:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M93JP-0003xQ-FE
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 22:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387AbZEZUbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbZEZUbl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 16:31:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:59703 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbZEZUbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 16:31:40 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id BB340FE3986B;
	Tue, 26 May 2009 22:31:41 +0200 (CEST)
Received: from [89.59.76.108] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M93JF-00060L-00; Tue, 26 May 2009 22:31:41 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1243316165-99065-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+J82+ooaHH61jT0UI9fJ04DHvIdeXBH9X8a1Mw
	8/OnH3+pLIbazbKQe4JkLmAVhzbydgK3ICVSKdfn+GKf59yx2L
	gCdvJHfLllCKw4wk9WZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120009>

David Aguilar, 26.05.2009:
> Diffing "name.ext" now generates "name.XXXX.ext".
> Diffing files with no extension now generates "name_XXXX".

Would it simplify the patch when using "name_XXXX.ext" and "name_XXXX"?
Or what about "XXXX_name.ext" and "XXXX_name"? Then you don't even have
to search for the dot and it has the advantage to show the original
filename without some random letters in the middle of it.

Markus
