From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/6] send-email: fix a typo in a comment
Date: Tue, 9 Jun 2009 09:05:57 +0200
Message-ID: <200906090905.58446.markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de> <1244410857-920-2-git-send-email-markus.heidelberg@web.de> <7vljo2wgco.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:06:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDvPV-0002gX-H4
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 09:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbZFIHGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 03:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbZFIHGF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 03:06:05 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:41639 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbZFIHGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 03:06:04 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id DC609104D103F;
	Tue,  9 Jun 2009 09:05:52 +0200 (CEST)
Received: from [89.59.118.0] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDvP5-0006Gj-00; Tue, 09 Jun 2009 09:05:51 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vljo2wgco.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/sQ7kmNIhMf+NR+4YBFVLcoy+yVVS3XjRLfpum
	fP0Gi1PbN8p4IXJ1iY/waAMXiMDGimeLz035tG86vA+FVVf6qw
	lk1q9ykn5b0N7MIvJX7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121143>

Junio C Hamano, 08.06.2009:
> Thanks; is there any patch among the six that should go to 'maint' (aka
> 1.6.3.X)?

[PATCH 4/6] add a test for git-send-email for non-threaded mails
[PATCH 5/6] send-email: fix non-threaded mails

fix the regression from commit 3e0c4ff (send-email: respect in-reply-to
regardless of threading, 2009-03-01), which was included before 1.6.3
and so is included in 'maint', so they should go to 'maint'. I'll resend
rebased.

[PATCH 1/6] send-email: fix a typo in a comment
[PATCH 2/6] add a test for git-send-email for threaded mails without chain-reply-to
[PATCH 3/6] send-email: fix threaded mails without chain-reply-to

fix commit 15da108 ("send-email: 'References:' should only reference
what is sent", 2009-04-13), which was included after 1.6.3 directly to
'master', so they don't go to 'maint'.

I don't know how documentation fixes are handled for inclusion to
'maint', but this could apply to 'maint' as well:

[PATCH 6/6] doc/send-email: clarify the behavior of --in-reply-to with --no-thread
