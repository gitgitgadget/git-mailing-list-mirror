From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [StGit PATCH 9/9] Use the default git colouring scheme rather than specific scripts
Date: Wed, 29 Apr 2009 13:56:16 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2009-04-29-13-56-16+trackit+sam@rfc1149.net>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
	<20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>
	<20090429064331.GI18483@diana.vm.bytemark.co.uk>
	<2009-04-29-13-48-29+trackit+sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 13:56:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz8Ox-0004e2-4o
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 13:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZD2L41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 07:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbZD2L41
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 07:56:27 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:49093 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbZD2L40 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 07:56:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id 94F66110264;
	Wed, 29 Apr 2009 13:56:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zoidberg.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0UC4Z6wQOScl; Wed, 29 Apr 2009 13:56:18 +0200 (CEST)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "CAcert Class 3 Root" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 30DF010E8EB;
	Wed, 29 Apr 2009 13:56:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 34989C40C5;
	Wed, 29 Apr 2009 13:56:17 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KFkR1PFCurSV; Wed, 29 Apr 2009 13:56:17 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 079E2C40C6; Wed, 29 Apr 2009 13:56:16 +0200 (CEST)
In-Reply-To: <2009-04-29-13-48-29+trackit+sam@rfc1149.net> (Samuel Tardieu's message of "Wed\, 29 Apr 2009 13\:48\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117876>

Karl> But config.get() should be dirt cheap, because we should be
Karl> reading in all the config values at once the first time we need
Karl> one of them. But as I recall we don't currently do that, so my
Karl> one-liner might not be so clever after all ...

Sam> Something like this may be useful then.

Btw, the patch is against kha/experimental.

  Sam
-- 
Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
