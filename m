From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [small bug] Surprising "Did you mean this?"
Date: Tue, 18 Nov 2008 19:45:45 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-11-18-19-45-45+trackit+sam@rfc1149.net>
References: <vpqod0dezh9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 18 19:46:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Vb4-0003hI-PN
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 19:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbYKRSpb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 13:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbYKRSpb
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 13:45:31 -0500
Received: from zoidberg.rfc1149.net ([91.121.19.179]:49857 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbYKRSpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 13:45:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 027D610E7DE;
	Tue, 18 Nov 2008 19:45:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFwAePEgAXzA; Tue, 18 Nov 2008 19:45:24 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id BDAFC110FC5;
	Tue, 18 Nov 2008 19:45:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 49640C40BE;
	Tue, 18 Nov 2008 19:45:46 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QRAwtIcZu2Mb; Tue, 18 Nov 2008 19:45:46 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 107A9C40C7; Tue, 18 Nov 2008 19:45:46 +0100 (CET)
In-Reply-To: <vpqod0dezh9.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue\, 18 Nov 2008 18\:05\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101277>

>>>>> "Matthieu" == Matthieu Moy <Matthieu.Moy@imag.fr> writes:

Matthieu> I would have expected git to propose me "tag" (1 character
Matthieu> removal), while "status" is quite far from "tags" (remove g,
Matthieu> add u, add another t, shuffle and you're there).

It looks like the addition of a character at the end (more exactly
the deletion of a character in the possible substitution) is bogus.
I am testing a patch.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
