From: =?ISO-8859-1?Q?Florian_K=F6berle?= <FloriansKarten@web.de>
Subject: Code Formatting vs Trailing Whitespaces
Date: Mon, 23 Jun 2008 20:15:50 +0200
Message-ID: <485FE856.1080808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 20:18:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAqcu-00044N-A2
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 20:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759382AbYFWSQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 14:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbYFWSQe
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 14:16:34 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:41528 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754172AbYFWSQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 14:16:33 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4D2C3E2DCE96;
	Mon, 23 Jun 2008 20:15:53 +0200 (CEST)
Received: from [84.150.93.234] (helo=[192.168.1.50])
	by smtp07.web.de with asmtp (WEB.DE 4.109 #226)
	id 1KAqa0-0000bH-00; Mon, 23 Jun 2008 20:15:52 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX19hMgDSoHqKYy7PN1oz6e2vsPqQj0g3nEaK7OTF
	EF8F74B/eO4o/oRhM55j7iZ4jdKEYlNd7BTg3D6xobMEcvsApz
	U3BwGG9OVJri6eHSo5Dw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85897>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

I noticed that Robin removed trailing whitespaces from my patch(thanks).
It appears that if you enable code formatting and the removement of
trailing whitespaces in the save actions option that the formatting
option will win.
It will add a space at the second line of a javadoc comment:
/**
~ * <----

I think this is a bug in eclipse, did any of you create a bug report for
that? Or a feature request for an "no whitespace after javadoc" option
in the code formatter page?

I want to have both options active, because I don't want to commit wrong
formatted patches.

Best regards,
Florian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIX+hW59ca4mzhfxMRApU4AKCbYzwRFqVcBCr11zc9lk6jqick2ACeMBhW
nXOoN4nIsTjzWWhQzDOxiz4=
=bm+i
-----END PGP SIGNATURE-----
