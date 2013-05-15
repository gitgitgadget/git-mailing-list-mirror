From: John Keeping <john@keeping.me.uk>
Subject: Re: is this a bug of git-diff?
Date: Wed, 15 May 2013 10:50:25 +0100
Message-ID: <20130515095025.GV2299@serenity.lan>
References: <CABwUO_X8oTzuJh8+v3Oqca2W4ht-cQRNGQ+a1DbEruq5jY+vgA@mail.gmail.com>
 <CALWbr2z338CJgavC9sVGffHSoqr0Sb9nCsr4LKURDYpkOog2TQ@mail.gmail.com>
 <CABwUO_Wyq34S=CwbLeAqmzaFLxORkvGEvrjUzMXjkJdE1jnbhA@mail.gmail.com>
 <CALWbr2z2jB53=2UsEneqymU2peiL4OW9Tyace_8BN3=1gA9jNg@mail.gmail.com>
 <vpqhai4y4b2.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>,
	eric liou <accwuya@gmail.com>, git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 15 11:50:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcYM6-0006Kb-5d
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 11:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226Ab3EOJui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 05:50:38 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:44206 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758638Ab3EOJuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 05:50:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 8D719866004;
	Wed, 15 May 2013 10:50:36 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xi9AywhFgK6N; Wed, 15 May 2013 10:50:34 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 28216CDA5A8;
	Wed, 15 May 2013 10:50:27 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <vpqhai4y4b2.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224393>

On Wed, May 15, 2013 at 11:34:41AM +0200, Matthieu Moy wrote:
> Antoine's answer is correct. In addition, I'd say that you may want to
> enable color in the output to make it clearer (the @@ ... @@ part would
> be colored, but not the function name):
> 
>   git config --global color.ui auto

I wonder if that should be the default.  I've advised a lot of people to
turn it on and it seems to me that a user is much more likely to go
looking for a "turn color off" option than realise that color is an
option at all.
