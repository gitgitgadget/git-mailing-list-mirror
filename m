From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] git-stash: alias 'list' to 'ls' and 'clear' to 'rm'
Date: Tue, 5 Feb 2008 12:06:00 +0100
Message-ID: <D512F3C0-3354-40BB-BD8D-8B3A85196825@wincent.com>
References: <1202207899-28578-1-git-send-email-tim@stoakes.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tim Stoakes <tim@stoakes.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 12:08:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMLf6-00007k-4I
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 12:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756904AbYBELHu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2008 06:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756890AbYBELHu
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 06:07:50 -0500
Received: from wincent.com ([72.3.236.74]:57626 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756869AbYBELHt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2008 06:07:49 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m15B61La007143;
	Tue, 5 Feb 2008 05:06:02 -0600
In-Reply-To: <1202207899-28578-1-git-send-email-tim@stoakes.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72648>

El 5/2/2008, a las 11:38, Tim Stoakes escribi=F3:

> clear::
> +rm::
> 	Remove all the stashed states. Note that those states will then
> 	be subject to pruning, and may be difficult or impossible to recover=
=2E

Isn't "rm" a bit misleading here? Seeing as the clear subcommand =20
really does an "rm -rf".

Also, is there any other precedent in the command suite for =20
abbreviating subcommand names in that way (ie. not just by shortening =20
them, but by using alternative names based on filesystem commands)? It =
=20
strikes me as a bit inconsistent.

Cheers,
Wincent
