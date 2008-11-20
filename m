From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: git and mtime
Date: Thu, 20 Nov 2008 16:56:33 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-11-20-16-56-33+trackit+sam@rfc1149.net>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
	<20081120132107.GA27571@piper.oerlikon.madduck.net>
	<20081120133546.GA6023@codelibre.net>
	<20081120135956.GA29789@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Roger Leigh <rleigh@codelibre.net>, git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 17:10:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3BuM-0004qv-CB
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbYKTP4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754905AbYKTP4O
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:56:14 -0500
Received: from zoidberg.rfc1149.net ([91.121.19.179]:45459 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbYKTP4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:56:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id A432911046C;
	Thu, 20 Nov 2008 16:56:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cuL5i8eUi31F; Thu, 20 Nov 2008 16:56:10 +0100 (CET)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 2036810E81F;
	Thu, 20 Nov 2008 16:56:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 1AAD6C40BE;
	Thu, 20 Nov 2008 16:56:34 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yw+l5VWWZh13; Thu, 20 Nov 2008 16:56:33 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id E1500C40CD; Thu, 20 Nov 2008 16:56:33 +0100 (CET)
In-Reply-To: <20081120135956.GA29789@piper.oerlikon.madduck.net> (martin f. krafft's message of "Thu\, 20 Nov 2008 14\:59\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101457>

>>>>> "martin" == martin f krafft <madduck@madduck.net> writes:

martin> I know you will hate me, but I think the solution here is to
martin> fix the toolchain and make those build dependencies required.

I agree with martin here. Your planned solution of not rebuilding the
files if the tools are not present may lead to serious problems if the
user modifies the source files and happens not to have the tools
around.

Moreover, requiring the build dependencies would allow you to drop the
generated files from the repository and rebuild them in your packaging
(source or binary) process.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
