From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: SPEC files for Git
Date: Mon, 01 Dec 2008 17:00:03 +0100
Message-ID: <49340A03.5090708@drmicha.warpmail.net>
References: <4933FFC6.8080306@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: devel@morey-chaisemartin.com
X-From: git-owner@vger.kernel.org Mon Dec 01 17:01:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7BDD-0006U1-Pi
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 17:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbYLAQAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 11:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYLAQAJ
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 11:00:09 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57822 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752006AbYLAQAH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2008 11:00:07 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id AC5071CA2DB;
	Mon,  1 Dec 2008 11:00:06 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 01 Dec 2008 11:00:06 -0500
X-Sasl-enc: eSnbdMDNodzYUSR1Y4f15LyrJH/1JGyMONVv9fUzrG45 1228147206
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 11AEA27BB7;
	Mon,  1 Dec 2008 11:00:05 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <4933FFC6.8080306@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102055>

Nicolas Morey-Chaisemartin venit, vidit, dixit 01.12.2008 16:16:
> Hi,
> 
> I'm trying to recompile gitweb1.6.0.4-1 for RHEL5, but I'm missing the
> spec file.
> I've checked the git SRP. It generates a lot of things but no RPM for
> gitweb.

RHEL5 probably comes with git 1.5.something, and its spec file won't
work nicely with git 1.6.x (because of new install locations).

> Is there any place with an official spec file? Or has anyone made one
> which he could share?

git source comes with a spec file template. If you have a git checkout
(or source tree) then "make git.spec" will generate it.

It does not generate a gitweb subpackage, but you only need to add a few
lines, following the example of the archimport package, say.

Or, even simpler: Just take the srpm from Fedora 10 and rebuild (gitweb
is a subpackage of git in F10, so you need the git srpm (e.g.
'yumdownloader --source gitweb' on an F10 instance). Installing the srpm
(as non-root) gives you the spec, I'm sure you know ;)

Michael
