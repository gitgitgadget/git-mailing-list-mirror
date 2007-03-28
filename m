From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Wed, 28 Mar 2007 05:44:47 +0200
Message-ID: <200703280544.47569.chriscool@tuxfamily.org>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org> <7vmz1zs0g5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 05:36:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWOxl-0007P3-OK
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 05:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbXC1Dgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 23:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbXC1Dgi
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 23:36:38 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:52554 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbXC1Dgh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 23:36:37 -0400
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 3E96CB61EA;
	Wed, 28 Mar 2007 05:36:36 +0200 (CEST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vmz1zs0g5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43348>

Le mardi 27 mars 2007 07:46, Junio C Hamano a =E9crit :

[...]

> So our requirement to have at least one good commit is not a
> fundamental one, but only a practical one.
>
> We could give an --immediate (or --no-good) option to 'git
> bisect bad' to start bisecting as soon as you give a single bad
> commit.  It might turn out that the commits you test are bad all
> the way down to the root commit, though ;-).

Yes, I plan to add some options to git bisect subcommands.

=46or example "git bisect run" could accept the following options:

--not
mark current revision as bad instead of good and as good instead of bad

--strict
all exit code except 0 and 1 abort the bisect run process

--good <rev1>
--bad <rev2>
use rev1 as good and rev2 as bad

--check or --test
run the script once and then do nothing if the result is good

Are there other options that people want ?

Thanks,
Christian.
