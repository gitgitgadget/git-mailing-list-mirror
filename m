From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] git stash: one bug and one feature request
Date: Fri, 04 Jan 2008 18:30:14 +0100
Organization: Home - http://www.obry.net
Message-ID: <477E6D26.9020809@obry.net>
References: <e5bfff550801040814n82f34b2g17c485a207093440@mail.gmail.com> <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jan 04 18:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAqNd-0005Y0-LS
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 18:30:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYADRaV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jan 2008 12:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbYADRaV
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 12:30:21 -0500
Received: from smtp23.orange.fr ([80.12.242.97]:16486 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193AbYADRaU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 12:30:20 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2313.orange.fr (SMTP Server) with ESMTP id 507F87000089
	for <git@vger.kernel.org>; Fri,  4 Jan 2008 18:30:18 +0100 (CET)
Received: from [192.168.0.100] (unknown [90.35.18.118])
	by mwinf2313.orange.fr (SMTP Server) with ESMTP id ECF0B7000084;
	Fri,  4 Jan 2008 18:30:17 +0100 (CET)
X-ME-UUID: 20080104173017970.ECF0B7000084@mwinf2313.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0801041030420.31161@torch.nrlssc.navy.mil>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69585>

Brandon Casey a =E9crit :
> Not sure how often such a command would be used though, so
> it may not be worth it.

I've missed it many times. Especially in some scripts when I want to us=
e
the stash-stack to store current working tree and clear it before
exiting. This is not possible today as all the stash-stack would be cle=
ared.

I agree that drop seems better.

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
