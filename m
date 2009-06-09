From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] send-email: Refuse to send cover-letter template subject
Date: Tue, 9 Jun 2009 20:25:18 +0200
Message-ID: <200906092025.18643.markus.heidelberg@web.de>
References: <7fedc4b76fed03e4db6a2bb7453609c9cd02928a.1244496564.git.trast@student.ethz.ch> <7v4ouqwa42.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME60h-0003y0-9T
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbZFISZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbZFISZJ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:25:09 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:51472 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbZFISZI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 14:25:08 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 46F9F104DD6A7;
	Tue,  9 Jun 2009 20:25:10 +0200 (CEST)
Received: from [89.59.118.0] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1ME60T-0004pz-00; Tue, 09 Jun 2009 20:25:09 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v4ouqwa42.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18m0s+dIoiNS5kFrIEpuPN8BySZmwvL2HL1wLMc
	VkogMdjiECa9PAWJy9zzaWB/cubyuxvmvUv6Yj0pXgJ5ajst7f
	PrrsPtTETa7YLdazWbrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121198>

Junio C Hamano, 09.06.2009:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > Every so often, someone sends out an unedited cover-letter template.
> > Add a simple check to send-email that refuses to send if the subject
> > contains "*** SUBJECT HERE ***", with an option --force to override.
> 
> Good ;-).  More valuable to detect would be an empty "blurb" section
> (i.e. not "unedited *** BLURB HERE ***" string, but literally, there is
> nothing said in the message other than the shortstat).

My mail "[PATCH 0/6] fixes for git-send-email" had an empty blurb
section because it didn't need any additional description.
I wouldn't want git to refuse sending it.
