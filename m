From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: rebase, file permissions and removed file
Date: Mon, 27 Oct 2008 17:39:43 +0100
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2008-10-27-17-39-43+trackit+sam@rfc1149.net>
References: <a2633edd0810270702x416bb659ke183b0cc6266071@mail.gmail.com>
	<4905D276.9020308@viscovery.net>
	<a2633edd0810270809w7fec93b2rc314cc025f41d41f@mail.gmail.com>
	<4905DC90.6050503@viscovery.net>
	<a2633edd0810270833q482260b4pf0ae11dcf2d4936f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Pascal Obry" <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 17:51:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuVG9-0003cb-Gt
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 17:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbYJ0QqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 12:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYJ0QqY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 12:46:24 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:59996 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYJ0QqX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 12:46:23 -0400
X-Greylist: delayed 396 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Oct 2008 12:46:23 EDT
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 7ADD91104F2;
	Mon, 27 Oct 2008 17:39:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m046o3TLzqqC; Mon, 27 Oct 2008 17:39:44 +0100 (CET)
Received: from mail2.rfc1149.net (unknown [IPv6:2a01:e35:1382:f950::3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "rfc1149.net" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 28A0B10E6B7;
	Mon, 27 Oct 2008 17:39:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id ADCABC40BC;
	Mon, 27 Oct 2008 17:39:43 +0100 (CET)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnO-A7bWpr4V; Mon, 27 Oct 2008 17:39:43 +0100 (CET)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 7FDB6C40BD; Mon, 27 Oct 2008 17:39:43 +0100 (CET)
In-Reply-To: <a2633edd0810270833q482260b4pf0ae11dcf2d4936f@mail.gmail.com> (Pascal Obry's message of "Mon\, 27 Oct 2008 16\:33\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99243>

>>>>> "Pascal" == Pascal Obry <pascal@obry.net> writes:

Pascal> I have plenty of other permission changes in my commit that I
Pascal> do not want to loose!

Why do you do a "rebase" in this case rather than a merge? Doesn't it
make little sense to record a permission change on a *deleted* file?

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
