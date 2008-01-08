From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Documentation: config: add 'help.*' and 'instaweb.*' variables.
Date: Tue, 8 Jan 2008 08:43:35 +0100
Message-ID: <200801080843.35693.chriscool@tuxfamily.org>
References: <20080108045514.1a506761.chriscool@tuxfamily.org> <7vmyrgx26h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 08:37:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC91x-0001uZ-6c
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 08:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814AbYAHHhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jan 2008 02:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbYAHHhV
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 02:37:21 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:57696 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551AbYAHHhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jan 2008 02:37:21 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6FE401AB2DB;
	Tue,  8 Jan 2008 08:37:19 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 56DD61AB2C6;
	Tue,  8 Jan 2008 08:37:19 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vmyrgx26h.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69846>

Le mardi 8 janvier 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > +web.browser::
> > +	Specify a web browser that may be used by some commands.
> > +	Currently only gitlink:git-instaweb[1] and gitlink:git-help[1]
> > +	may use it.
> > --
> > 1.5.4.rc2.38.gd6da3
>
> Somebody seems to have recounted the patch lines incorrectly
> here.  The hunk header should have read "@@ -843,3 +871,8 @@".

Yeah, sorry about that. I added "gitlink:" before "git-help[1]" and=20
moved "may use" to the next line before "it" just before sending the pa=
tch.
This probably made xemacs recount badly.

By the way I had no comment on my RFC/Patch to run the test scripts und=
er=20
valgrind. Maybe it's useless because it doesn't find any bug right now.

Thanks,
Christian.
