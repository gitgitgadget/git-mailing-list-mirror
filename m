From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] grep: don't support "grep.color"-like config options
Date: Tue, 21 Apr 2009 09:57:54 +0200
Message-ID: <200904210957.55640.markus.heidelberg@web.de>
References: <1240268295-10296-1-git-send-email-markus.heidelberg@web.de> <alpine.DEB.1.00.0904210145260.10279@pacific.mpi-cbg.de> <7vy6tua6uh.fsf@gitster.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 09:59:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwAse-00021P-1n
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 09:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbZDUH50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 03:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbZDUH50
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 03:57:26 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:50093 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbZDUH5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 03:57:25 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 10A1710056D81;
	Tue, 21 Apr 2009 09:57:24 +0200 (CEST)
Received: from [89.59.89.253] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LwAr5-0002Iz-00; Tue, 21 Apr 2009 09:57:23 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vy6tua6uh.fsf@gitster.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+M1E4zmpW3jHN9nKP95eUDSF2+oYNr9Yw4+cct
	weVkOyorTAVH0aBALRf0tKkPyD60o2OIPfT4PwvjzspauffsWS
	EOAsJsQhtTlylT4vQS3Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117100>

Junio C Hamano, 21.04.2009:
>  (2) add code comments about their deprecated status to discourage people
>      from copying the style; and

Good idea.

> In any case, I think perhaps we should squash this in.
> 
>  diff.c      |    5 +++++
>  wt-status.c |    5 +++++
>  2 files changed, 10 insertions(+), 0 deletions(-)

There is still pager.color in config.c

Markus
