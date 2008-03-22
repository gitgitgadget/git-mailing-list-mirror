From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: How to rewrite author history
Date: Sat, 22 Mar 2008 10:29:22 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-03-22-10-29-23+trackit+sam@rfc1149.net>
References: <216e54900803210938q4981b5d1t535af419f5b15ad8@mail.gmail.com>
	<216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Andrew Arnott" <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 10:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd03V-0005Jg-1x
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 10:30:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbYCVJ3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 05:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752766AbYCVJ3d
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 05:29:33 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:54477 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbYCVJ3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 05:29:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 3508CE05D5;
	Sat, 22 Mar 2008 10:29:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1LHwLtNRbjpa; Sat, 22 Mar 2008 10:29:25 +0100 (CET)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:5d8:5138:2f95::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id 65DB5E04CC;
	Sat, 22 Mar 2008 10:29:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 55344C408D;
	Sat, 22 Mar 2008 10:29:24 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26Nh+++74e9U; Sat, 22 Mar 2008 10:29:23 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 89210C40B8; Sat, 22 Mar 2008 10:29:23 +0100 (CET)
In-Reply-To: <216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com> (Andrew Arnott's message of "Fri\, 21 Mar 2008 09\:41\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77793>

>>>>> "Andrew" == Andrew Arnott <andrewarnott@gmail.com> writes:

Andrew> I imported my git repo from an SVN repo, and the authors have
Andrew> email@SOME-GUID for their email address rather than their
Andrew> actual one (probably courtesy of Google Code hosting).
Andrew> Rewriting history and changing all the commit hashes isn't a
Andrew> problem at this point in development, so how can I do a
Andrew> massive search-and-replace to replace several specific author
Andrew> emails with the valid ones?

If you can reimport it, you can use the "--authors-file" of "git svn".

  Sam
