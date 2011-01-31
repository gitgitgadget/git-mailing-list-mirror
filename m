From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] make two-argument fetch update remote branches
Date: Mon, 31 Jan 2011 23:18:50 +0100
Message-ID: <vpqipx4af91.fsf@bauges.imag.fr>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<201101312244.10047.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jan 31 23:19:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk25l-0003oQ-9p
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 23:19:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754239Ab1AaWTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 17:19:19 -0500
Received: from mx1.imag.fr ([129.88.30.5]:39917 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753944Ab1AaWTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 17:19:19 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p0VMIl8K008442
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 31 Jan 2011 23:18:47 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pk25C-0003z8-AG; Mon, 31 Jan 2011 23:18:50 +0100
In-Reply-To: <201101312244.10047.trast@student.ethz.ch> (Thomas Rast's message of "Mon\, 31 Jan 2011 22\:44\:09 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 31 Jan 2011 23:18:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0VMIl8K008442
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297117133.16927@Opp+jFznQ65NvloX6dqnEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165763>

Thomas Rast <trast@student.ethz.ch> writes:

> Running "git fetch origin master" only updates FETCH_HEAD, not
> origin/master, which turns out to be quite confusing for newcomers
> especially after running 'git pull origin master'.

+1

We just got the case on this list of a newbie running "git pull origin
master" to update his local branch, and "git status" still complaining
that the local branch was ahead of the remote by many commits.

Updating the remote-tracking in this case would avoid such confusion.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
