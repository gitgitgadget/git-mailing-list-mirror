From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 5 Apr 2009 23:58:52 +0200
Message-ID: <200904052358.53028.markus.heidelberg@web.de>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 00:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqaOb-0003FD-Fl
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 00:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383AbZDEV6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752035AbZDEV6s
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:58:48 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:48250 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbZDEV6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:58:48 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3549FFC8501F;
	Sun,  5 Apr 2009 23:58:46 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LqaMX-0001nk-00; Sun, 05 Apr 2009 23:58:46 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/OcE4NWLsJ9XM5hevICBL/YFO0YYktXWBkWobK
	3pPiD1viHm0UwD3dl2sohzYrjPSrtqQnl0pzj6T5xPjbBVVCjG
	dYW25IT+2t+kPrysmpzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115723>

Felipe Contreras, 05.04.2009:
> For example 'git stage diff' is more natural (at least to me) than 'git diff
> --cached', same goes for 'git stage rm foo.c' vs 'git rm --cached foo.c'.

Not for me. If I want to GET a diff, I want to use a command "diff", so
"git diff" is more obvious.
The next step is to say WHAT exactly to diff. Therefor options to the
"diff" command are more logically to me from a hierarchic POV. And here
I don't think options like "--cached" or "sha1..sha2", despite having
different style, make any difference.

Markus
