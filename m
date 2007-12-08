From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] git-help: add -w|--web option to display html man page in a browser.
Date: Sat, 8 Dec 2007 05:00:06 +0100
Message-ID: <200712080500.06857.chriscool@tuxfamily.org>
References: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org> <7v1w9z9h2k.fsf@gitster.siamese.dyndns.org> <7vfxyf7zoi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 04:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0qlR-0002QG-2S
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 04:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbXLHDxo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Dec 2007 22:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbXLHDxo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 22:53:44 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:52699 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbXLHDxn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Dec 2007 22:53:43 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 5B0061AB2B4;
	Sat,  8 Dec 2007 04:53:42 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id F23B71AB2AE;
	Sat,  8 Dec 2007 04:53:41 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vfxyf7zoi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67506>

Le vendredi 7 d=E9cembre 2007, Junio C Hamano a =E9crit :
> Junio C Hamano <gitster@pobox.com> writes:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> > ...
> >
> >>> > +init_browser_path() {
> >>> > +	browser_path=3D`git config browser.$1.path`
> >>> > +	test -z "$browser_path" && browser_path=3D$1
> >>> > +}
> >>>
> >>> Please do not contaminate the config file with something the user=
 can
> >>> easily use a lot more standardized way (iow $PATH) to configure t=
o
> >>> his taste.
> >>>
> >>> I'd suggest dropping this bit.
>
> Well, I changed my mind.  It is a bit funny to have both firefox and
> iceweasel as "valid-tool", but if we consider $browser to define the
> external interface and $browser_path to define the implementation, it
> sort of makes sense to have that configuration.  browser_path could b=
e
> iceweasel for browser firefox.
>
> I'll squash the patch to update the one from the last round (as the l=
ast
> two patches are not yet accepted in 'next' yet), remove the html
> documentation path fallback, but will leave this part in.

Thanks.

> browser.*.path and web.browser configuration need to be documented, i=
f
> not already, though.

Did you see this patch:

http://article.gmane.org/gmane.comp.version-control.git/67101

Christian.
