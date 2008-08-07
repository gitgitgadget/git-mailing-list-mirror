From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [PATCH] files given on the command line are relative to $cwd
Date: Thu, 07 Aug 2008 10:45:21 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-08-07-10-45-21+trackit+sam@rfc1149.net>
References: <48997D2E.9030708@obry.net>
	<20080806104432.GG7121@bit.office.eurotux.com>
	<4899848C.6030800@obry.net>
	<7v3alirw6b.fsf@gitster.siamese.dyndns.org>
	<4899D119.1080403@obry.net>
	<7vy73aqe9m.fsf@gitster.siamese.dyndns.org>
	<7vr692oufw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git list <git@vger.kernel.org>,
	Luciano Rocha <luciano@eurotux.com>, pascal@obry.net,
	Pierre Habouzit <madcoder@debian.org>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 10:46:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR18x-0002FG-Gb
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 10:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733AbYHGIph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 04:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbYHGIpf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 04:45:35 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:55101 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569AbYHGIpc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 04:45:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 6951FE0C23;
	Thu,  7 Aug 2008 10:45:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFWJJ9rLbMp9; Thu,  7 Aug 2008 10:45:22 +0200 (CEST)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by mail.rfc1149.net (Postfix) with ESMTPS id 6FC45E0477;
	Thu,  7 Aug 2008 10:45:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id A2884C40BC;
	Thu,  7 Aug 2008 10:45:21 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L0Iwv2Lh+KBd; Thu,  7 Aug 2008 10:45:21 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 762C8C40BD; Thu,  7 Aug 2008 10:45:21 +0200 (CEST)
In-Reply-To: <7vr692oufw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 06 Aug 2008 11\:43\:47 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91567>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> When running "git commit -F file" and "git tag -F file" from a
Junio> subdirectory, we should take it as relative to the directory we
Junio> started from, not relative to the top-level directory.

Don't we have the same problem with "git show"? If you go into
the "gitweb" directory of the GIT source, "git show HEAD:README" will
show you the toplevel "README" instead of the one in the "gitweb"
directory.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
