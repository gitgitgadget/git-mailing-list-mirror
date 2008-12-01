From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 0/6 (v2)] Detecting HEAD more reliably while cloning
Date: Mon, 01 Dec 2008 16:52:11 +0100
Message-ID: <4934082B.5050802@viscovery.net>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 16:53:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7B5Z-0003NF-Kf
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 16:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYLAPwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 10:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbYLAPwQ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 10:52:16 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29665 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbYLAPwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 10:52:15 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L7B4G-0004yJ-OD; Mon, 01 Dec 2008 16:52:12 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7458769F; Mon,  1 Dec 2008 16:52:12 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1228140775-29212-1-git-send-email-gitster@pobox.com>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Junio C Hamano schrieb: > Instead of introducing a full-fledged
	protocol extension, this round hides > the new information in the same place
	as the server capabilities list that > is used to implement protocol extension
	is hidden from older clients. [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102053>

Junio C Hamano schrieb:
> Instead of introducing a full-fledged protocol extension, this round hides
> the new information in the same place as the server capabilities list that
> is used to implement protocol extension is hidden from older clients.

Not that it makes a lot of difference, but why do you want to *hide* the
information? Can't we just have a capability-with-parameter:

 ... shallow no-progress include-tag head=refs/heads/foo\ bar ...

(with spaces and backslashes escaped)?

-- Hannes
