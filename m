From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 8/8] Define a basic merge API, and a two-way tree merge strategy
Date: Sun, 18 Jan 2009 21:21:01 +0100
Message-ID: <200901182121.01469.robin.rosenberg.lists@dewire.com>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org> <20090115210936.GI10179@spearce.org> <f299b4f30901171116y216835c9jc11df2d424ee0377@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: tomi.pakarinen@iki.fi
X-From: git-owner@vger.kernel.org Sun Jan 18 21:22:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOeAC-0005J2-J4
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 21:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbZARUVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 15:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbZARUVH
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 15:21:07 -0500
Received: from mail.dewire.com ([83.140.172.130]:27029 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754447AbZARUVG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 15:21:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C4B50147E6DB;
	Sun, 18 Jan 2009 21:21:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H+1JM0voUIHR; Sun, 18 Jan 2009 21:21:02 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 258AC147E6D9;
	Sun, 18 Jan 2009 21:21:01 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <f299b4f30901171116y216835c9jc11df2d424ee0377@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106275>

l=F6rdag 17 januari 2009 20:16:21 skrev Tomi Pakarinen:
> testTrivialTwoWay_disjointhistories() failed because merge strategy
> didn't handle missing base
> version. Am'i right?
Kyll=E4

Or so it seems. My test cases pass. I'll see if I can come up with some=
hing nasty.
If not I'll apply=20

-- robin
