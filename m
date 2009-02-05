From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH 06/11] Implement basic customizable label decorations with preferences
Date: Thu, 5 Feb 2009 22:36:01 +0100
Message-ID: <200902052236.01478.robin.rosenberg@dewire.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com> <498B4A66.9020108@gmail.com> <498B5374.1030305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Tor Arne =?iso-8859-1?q?Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 22:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVBuv-0000iS-2F
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 22:37:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbZBEVgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 16:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZBEVgH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 16:36:07 -0500
Received: from mail.dewire.com ([83.140.172.130]:3140 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbZBEVgG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Feb 2009 16:36:06 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CAB00147E888;
	Thu,  5 Feb 2009 22:36:02 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id shQSP4kBwCJ1; Thu,  5 Feb 2009 22:36:02 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 4CB04147E7FF;
	Thu,  5 Feb 2009 22:36:02 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <498B5374.1030305@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108624>

torsdag 05 februari 2009 22:00:36 skrev Tor Arne Vestb=F8:
> Here are two alternatives. The first one (A) uses the same icons as
> before, but adds red and green shading. The second one (B) uses the
> green plus sign for added (which is used all over the place in Eclips=
e
> to mean 'added'), and the gray x for removed (which is also used all
> over the place in Eclipse for that same concept).
>=20
> http://img443.imageshack.us/img443/5138/egitmockupmm7.png
>=20
> I favor solution B, as it uses recognizable concepts from the existin=
g
> Eclipse UI, plus that having a red removed-icon conflicts too much wi=
th
> the conflict-icon (pun intended). There's also a very similar red ico=
n
> in JDT that indicates that something needs fixing (a red medic kit),
> which is another reason to go with solution B.

I go with B.

Btw, shouldn't staged, added and removed also count as outgoing, i.e. "=
>" ?

-- robin
