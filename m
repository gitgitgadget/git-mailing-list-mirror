From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 02/10] Rename the objectsUrl in the nested HttpObjectDB to
Date: Mon, 16 Mar 2009 22:25:00 +0100
Message-ID: <200903162225.00347.robin.rosenberg.lists@dewire.com>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com> <20090316202513.GS22920@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@sparce.org, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 16 22:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjKKw-0000JS-Q4
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 22:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758972AbZCPVZL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Mar 2009 17:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758601AbZCPVZL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 17:25:11 -0400
Received: from mail.dewire.com ([83.140.172.130]:5836 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756512AbZCPVZK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 17:25:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 556A0138AD51;
	Mon, 16 Mar 2009 22:25:05 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OskWP7fDMqfI; Mon, 16 Mar 2009 22:25:04 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 3F3F58006AD;
	Mon, 16 Mar 2009 22:25:04 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <20090316202513.GS22920@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113385>

m=E5ndag 16 mars 2009 21:25:13 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > It is used for looking at alternate objects, so name it such
>=20
> No SOB?
>=20
> But I disagree with this name change.  Its pointing at the
> objects directory of a repository.  It may also be used to
> point at an alternate when opening an alternate, in which
> case it points at the alternate's objects directory.
>=20
> IMHO, objectsUrl is the right name for this.

Ok, I missed the real reason in the comment. It is name hiding. objects=
Url
is the name of another variable in the outer scope.

-- robin
