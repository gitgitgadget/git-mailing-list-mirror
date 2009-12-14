From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command given is junk
Date: Mon, 14 Dec 2009 22:55:36 +0100
Organization: Viscovery Software GmbH
Message-ID: <200912142255.36949.j.sixt@viscovery.net>
References: <4B263797.5070808@viscovery.net> <7v7hspjp3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:15:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKJCX-0003ZU-JI
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 23:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbZLNWP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 17:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758565AbZLNWP2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 17:15:28 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:56956 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758537AbZLNWP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 17:15:27 -0500
X-Greylist: delayed 1158 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2009 17:15:27 EST
Received: from bsmtp.bon.at (unknown [172.18.12.54])
	by lbmfmo03.bon.at (Postfix) with ESMTP id BF090CE88B
	for <git@vger.kernel.org>; Mon, 14 Dec 2009 22:56:59 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 5D8972C401A;
	Mon, 14 Dec 2009 22:56:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0F53019F5CA;
	Mon, 14 Dec 2009 22:55:37 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v7hspjp3q.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135249>

On Montag, 14. Dezember 2009, Junio C Hamano wrote:
> In the meantime, I think squashing the following in would help us keep the
> two magic numbers in sync.

I do not think that keeping the numbers in sync is necessary. For example, the 
similarity requirement for commands that run automatically could be stricter 
than for the list of suggestions. Then it would be possible that a unique 
best candidate is not good enough to be run automatically; there would only 
be a list of suggestions.

-- Hannes
