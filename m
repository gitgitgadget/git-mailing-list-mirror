From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH]  Test and fix handling of quotes in ~/.ssh/config
Date: Mon, 22 Sep 2008 22:42:29 +0200
Message-ID: <200809222242.29165.robin.rosenberg.lists@dewire.com>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl> <bd6139dc0809201819o5d6eb5b1r7bf0e46702c711d7@mail.gmail.com> <20080921112519.GA24200@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sverre@rabbelier.nl, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Sep 22 23:06:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khsav-00053E-CZ
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbYIVVEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Sep 2008 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753307AbYIVVEM
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 17:04:12 -0400
Received: from av6-1-sn3.vrr.skanova.net ([81.228.9.179]:49514 "EHLO
	av6-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbYIVVEL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2008 17:04:11 -0400
Received: by av6-1-sn3.vrr.skanova.net (Postfix, from userid 502)
	id A7369382DD; Mon, 22 Sep 2008 23:04:09 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av6-1-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 626FE38172; Mon, 22 Sep 2008 23:04:09 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id B427737E45;
	Mon, 22 Sep 2008 23:04:08 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20080921112519.GA24200@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96511>

s=F6ndagen den 21 september 2008 13.25.19 skrev Jonas Fonseca:
> +		assertEquals("bad.tld\"", osc.lookup("bad").getHostName());
This one is really (as you noted) bad so we shouldn't allow it at all. =
A new=20
subclass of TransportExcpeption should be thrown to indicate a serious
configuration problem when attempting to use the option.

-- robin
