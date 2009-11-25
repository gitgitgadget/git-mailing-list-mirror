From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git repository mesh?
Date: Wed, 25 Nov 2009 08:55:48 +0100
Message-ID: <vpqaaybf37f.fsf@bauges.imag.fr>
References: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 08:56:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDCjJ-0005w4-IM
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 08:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758419AbZKYHzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 02:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758385AbZKYHzt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 02:55:49 -0500
Received: from mx2.imag.fr ([129.88.30.17]:53188 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758353AbZKYHzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 02:55:48 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAP7sbRQ024876
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 25 Nov 2009 08:54:37 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NDCj6-0002Md-Sn; Wed, 25 Nov 2009 08:55:48 +0100
In-Reply-To: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Wed\, 25 Nov 2009 11\:07\:51 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 25 Nov 2009 08:54:38 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAP7sbRQ024876
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1259740478.07094@tup8wkOvHssxjnF4n+p1Mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133615>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Never used Mercurial but the idea of "git in" and "git out" to see how
> many commits ahead/behind would be nice.

In Git, you'd run "git fetch" to get everything locally, and then

git log ..origin/master => what origin/master has that you don't
git log origin/master.. => what you have that origin/master doesn't

(and you can define aliases for that)

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
