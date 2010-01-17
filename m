From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/2] Make it easy to use branch --track on existing branch
Date: Sun, 17 Jan 2010 15:53:04 +0100
Message-ID: <vpqska4n5pr.fsf@bauges.imag.fr>
References: <1263737212-8101-1-git-send-email-Matthieu.Moy@imag.fr>
	<20100117144031.GA20335@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Jan 17 15:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWWVE-0001LK-P6
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 15:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab0AQOxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 09:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847Ab0AQOxO
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 09:53:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:59822 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932081Ab0AQOxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 09:53:13 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o0HEqVoN025632
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 17 Jan 2010 15:52:31 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NWWUy-00061s-CP; Sun, 17 Jan 2010 15:53:04 +0100
In-Reply-To: <20100117144031.GA20335@Knoppix> (Ilari Liusvaara's message of "Sun\, 17 Jan 2010 16\:40\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 17 Jan 2010 15:52:31 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o0HEqVoN025632
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1264344751.91946@DE4M/9YELz4CohUkl2LqxA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137301>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> But If I read the patch correctly, you can't just arbitrarily set the
> tracking branch since the IDs must match.

Yes. The patch really helps when you already have synchronized, or
when you haven't already desynchronized your local branch and its
upstream.

We could go one step further, and allow the new branch point to be
different as long as it has the old point as an ancestor, but that
would still be a ref update.

> [*] Yes, I know you can edit .git/config, but I would want "official sounding"
> (read: git remote subcommand) command to edit it (and no, delete & recreate
> doesn't do the right thing).

Having a "git remote subcommand" to do the same thing could help too,
but it could just come in addition to my patch.

My patch doesn't introduce new complexity: the command is already
there, and the use-case I'm allowing are legitimate. So, it can help
to let users run in, and it doesn't harm.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
