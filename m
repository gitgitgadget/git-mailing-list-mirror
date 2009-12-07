From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 2/2] Add a command "fixup" to rebase --interactive
Date: Mon, 07 Dec 2009 12:57:57 +0100
Message-ID: <vpqtyw3808q.fsf@bauges.imag.fr>
References: <cover.1260099005.git.mhagger@alum.mit.edu>
	<ced6765cff6225a05f196a6896ab577850979ab1.1260099005.git.mhagger@alum.mit.edu>
	<fabb9a1e0912070326s6cda5c8r442c4816538d0e2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, git@drmicha.warpmail.net,
	Johannes.Schindelin@gmx.de, bgustavsson@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 12:58:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHcEW-0001Hs-NT
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934268AbZLGL6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 06:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934215AbZLGL6J
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:58:09 -0500
Received: from mx2.imag.fr ([129.88.30.17]:44967 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934189AbZLGL6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 06:58:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nB7BuADs013920
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Dec 2009 12:56:12 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NHcE2-0008G5-6r; Mon, 07 Dec 2009 12:57:58 +0100
In-Reply-To: <fabb9a1e0912070326s6cda5c8r442c4816538d0e2a@mail.gmail.com> (Sverre Rabbelier's message of "Mon\, 7 Dec 2009 12\:26\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Dec 2009 12:56:13 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nB7BuADs013920
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1260791775.23645@oILE3bAJEJwFsqAbpUXWVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134751>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Mon, Dec 7, 2009 at 05:22, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> The command is like "squash", except that it discards the commit message
>> of the corresponding commit.
>
> No no, wait, wasn't "fixup" supposed to let you just edit the commit
> message of the commit you're fixing up? :(

This is "reword", already in Git (6741aa6c399dec3d8f0b2, Wed Oct 7
08:13:23 2009).

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
