From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] fetch-pack: Prepare for a side-band demultiplexer in a thread.
Date: Sun, 18 Nov 2007 10:36:14 +0100
Message-ID: <200711181036.14565.johannes.sixt@telecom.at>
References: <200711172309.28364.johannes.sixt@telecom.at> <7vtznkz8nw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 10:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItgZu-0006yz-8s
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 10:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbXKRJgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 04:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbXKRJgR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 04:36:17 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:35251 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXKRJgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 04:36:16 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 9D23F13A693;
	Sun, 18 Nov 2007 10:36:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3790D589E2;
	Sun, 18 Nov 2007 10:36:15 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtznkz8nw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65353>

On Sunday 18 November 2007 01:42, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> > 	This change again originates from the MinGW port. Since we don't
> > 	have fork(2) on Windows, we must run the sideband demultiplexer
> > 	in a thread.
>
> If the rationale was "running in a thread is more natural on the
> platform", I would understand it.

Please take it as such.

> But "_must_ run because there is no fork(2)" solicits a "Huh?
> How does Cygwin does it then?" from me.

Alex has answered this. We are not going to copy Cygwin's fork() into git.

-- Hannes
