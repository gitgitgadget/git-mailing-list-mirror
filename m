From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] No color diff when redirecting to file
Date: Sun, 23 Jan 2011 18:29:52 +0100
Message-ID: <vpq39oj4jfz.fsf@bauges.imag.fr>
References: <201101231410.48528.saschpe@gmx.de>
	<201101231547.18529.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sascha Peilicke <saschpe@gmx.de>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 23 18:30:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ph3lO-0003Ig-81
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 18:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab1AWR37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 12:29:59 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55010 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306Ab1AWR36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 12:29:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p0NHToYX019002
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 23 Jan 2011 18:29:50 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ph3lA-00064w-Ci; Sun, 23 Jan 2011 18:29:52 +0100
In-Reply-To: <201101231547.18529.j6t@kdbg.org> (Johannes Sixt's message of "Sun\, 23 Jan 2011 15\:47\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 23 Jan 2011 18:29:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0NHToYX019002
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1296408592.17348@a/nQMZ6Wg3xVY4GcdyEcGA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165427>

Johannes Sixt <j6t@kdbg.org> writes:

> That said, I cannot reproduce. Perhaps your configuration says 
> color.ui=always? If so, then this is expected behavior and not a bug, IMO.

I think you're right.

I tested this (without the patch):

git diff
=> I get color, because I have color.ui = auto

git diff | cat
=> I don't get color

git diff --color=auto | cat
=> no color

git diff --color=always | cat
=> colors, because I've asked

this seems to be just the right behavior.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
