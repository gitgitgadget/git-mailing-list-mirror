From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] send-email: Refuse to send cover-letter template subject
Date: Tue, 9 Jun 2009 21:32:09 +0200
Message-ID: <200906092132.10256.markus.heidelberg@web.de>
References: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch> <200906092025.18643.markus.heidelberg@web.de> <7v4oupmdv5.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:32:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME73Q-0004r9-TJ
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbZFITcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 15:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbZFITcG
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:32:06 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51250 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbZFITcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 15:32:06 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 001B01025C397;
	Tue,  9 Jun 2009 21:32:06 +0200 (CEST)
Received: from [89.59.118.0] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1ME73A-0002mK-00; Tue, 09 Jun 2009 21:32:01 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v4oupmdv5.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18F2E7c/3kmg61JKUCU5jweMM1147kIDCR94Ag1
	zpqlU0nVLFhwnW5FvzCOngvy28t8OUTj6tk2UVJ1hUq3LUeFOm
	xJHcqYnysCIAiSwjhv2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121210>

Junio C Hamano, 09.06.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> >
> > My mail "[PATCH 0/6] fixes for git-send-email" had an empty blurb
> > section because it didn't need any additional description.
> > I wouldn't want git to refuse sending it.
> 
> I actually wouldn't have wanted to see that [0/6] with empty description.

I thought the diffstat is a nice overview as well. So there is at least
some value in a blurb-less cover letter. But I guess they are debatable.

> If the list of 6 patch titles give clear enough description of the theme
> of the whole series, you would not need [0/6] to set the stage,

I prefer --thread --no-chain-reply-to for more than 2 patches, so it
seems I sometimes only abuse the 0/X as a common anchor for 1..X/X. I'd
find it strange to use 1/X for that.

> and that is the best kind of series.

Hmm, so then you prefer no 0/X at all.
