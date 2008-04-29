From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-help: Try to find html pages without the git- prefix
Date: Tue, 29 Apr 2008 07:18:47 +0200
Message-ID: <200804290718.47961.chriscool@tuxfamily.org>
References: <1209377611-90005-1-git-send-email-pdebie@ai.rug.nl> <200804290513.40948.chriscool@tuxfamily.org> <7vy76x8e0s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 07:14:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqiAm-0005Mt-Q1
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 07:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbYD2FNr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Apr 2008 01:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbYD2FNr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 01:13:47 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51134 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbYD2FNq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Apr 2008 01:13:46 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A4C1C1AB2DD;
	Tue, 29 Apr 2008 07:13:45 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7ECEE1AB2C6;
	Tue, 29 Apr 2008 07:13:44 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vy76x8e0s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80646>

Le mardi 29 avril 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > We already have the following files following that scheme:
> >
> > gitk.txt
> > gitattributes.txt
> > gitignore.txt
> > gitcli.txt
> > gitmodules.txt
> > git.txt
> >
> > And for example the following commands are already working:
> >
> > $ git help -w gitmodules
> > $ git help -m gitmodules
> > $ man gitmodules
>
> That is not surprise as gitattributes(5), gitignore(5) and gitmodules=
(5)
> work by design.  They are valid manual pages in section 5 (file forma=
ts).
>
> I am not sure about hooks let alone gitcli --- they are not something=
 you
> would traditionally place in section 5.

Aren't there other man sections where we could put them ?

> It would be nice if "git help <any path you see in Documentation/>"
> worked as expected,=20

I agree and that means that we should find an appropriate man section f=
or=20
everything in "Documentation/". Otherwise how could "git help -m <any p=
ath=20
you see in Documentation/>" work ?

Thanks,
Christian.

> although I personally tend to go to the *.txt files=20
> ;-)
