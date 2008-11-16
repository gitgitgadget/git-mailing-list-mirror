From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: Conflict-free merging (i.e. concat) of conflicting branches?
Date: Sun, 16 Nov 2008 15:19:47 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-11-16-15-19-47+trackit+sam@rfc1149.net>
References: <2d460de70811160550g75e50e00gb50d3b2045c460af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, markus.heidelberg@web.de
To: "Richard Hartmann" <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 15:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1iWW-0007gL-Ki
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 15:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbYKPOTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 09:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751706AbYKPOTe
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 09:19:34 -0500
Received: from zoidberg.rfc1149.net ([91.121.19.179]:56963 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbYKPOTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 09:19:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 565EE10E6DF;
	Sun, 16 Nov 2008 15:19:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eJzESbOdqeWF; Sun, 16 Nov 2008 15:19:29 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id F01D410E6DB;
	Sun, 16 Nov 2008 15:19:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 9B52CC40BE;
	Sun, 16 Nov 2008 15:19:47 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZjKKdgv2cmH; Sun, 16 Nov 2008 15:19:47 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 69BF7C40C4; Sun, 16 Nov 2008 15:19:47 +0100 (CET)
In-Reply-To: <2d460de70811160550g75e50e00gb50d3b2045c460af@mail.gmail.com> (Richard Hartmann's message of "Sun\, 16 Nov 2008 14\:50\:34 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101131>

>>>>> "Richard" == Richard Hartmann <richih.mailinglist@gmail.com> writes:

Richard> The question is if there is a way to to merge these branches
Richard> in a way that is conflict-free and includes all
Richard> lines. Obviously, the order of the lines is irrelevant and
Richard> can be random.

You can use a custom merge driver especially designed for this case.
See gitattributes(5) man page for an explanation of how it works.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
