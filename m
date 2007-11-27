From: Pascal Obry <pascal.obry@wanadoo.fr>
Subject: Re: [PATCH] Use --no-color option on git log commands.
Date: Tue, 27 Nov 2007 19:24:58 +0100
Organization: Home
Message-ID: <474C60FA.4040302@wanadoo.fr>
References: <474B42EC.1000408@wanadoo.fr> <7vr6icej23.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 19:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix57c-0002Wf-3b
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 19:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051AbXK0SZE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 13:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755919AbXK0SZE
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 13:25:04 -0500
Received: from smtp28.orange.fr ([80.12.242.99]:13546 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755473AbXK0SZD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 13:25:03 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2803.orange.fr (SMTP Server) with ESMTP id 5A74E8000155
	for <git@vger.kernel.org>; Tue, 27 Nov 2007 19:25:00 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-61-188.w82-124.abo.wanadoo.fr [82.124.127.188])
	by mwinf2803.orange.fr (SMTP Server) with ESMTP id 273A78000047;
	Tue, 27 Nov 2007 19:25:00 +0100 (CET)
X-ME-UUID: 20071127182500160.273A78000047@mwinf2803.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vr6icej23.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66252>

Junio C Hamano a =E9crit :
> The patch is good as belt-and-suspender, thanks.

Ok.

> But I suspect that we should make 'true' to mean 'auto' someday in
> git_config_colorbool().  Crazy people can set 'always' if they really
> wanted to, but most normal people would not want color unless the out=
put
> goes to the terminal, I would think.

I definitely agree. I add it set to true, using auto instead I do not
have the problem. Anyway I still think that it is good to apply my patc=
h
to completely avoid such issues.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
