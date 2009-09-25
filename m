From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/2] add support for core.logAllRefUpdates configuration parameter
Date: Sat, 26 Sep 2009 00:52:39 +0200
Message-ID: <200909260052.39469.robin.rosenberg.lists@dewire.com>
References: <D35B4A582834DC418CCF9AF41AB69B70016953F62F@DEWDFECCR04.wdf.sap.corp> <200909260045.21171.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Halstrick, Christian" <christian.halstrick@sap.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 00:52:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrJeh-0000qI-O1
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 00:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbZIYWwi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 18:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbZIYWwh
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 18:52:37 -0400
Received: from mail.dewire.com ([83.140.172.130]:17054 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbZIYWwh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 18:52:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A1FA1147DB35;
	Sat, 26 Sep 2009 00:52:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1Z9onwOdhpJ; Sat, 26 Sep 2009 00:52:40 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 2CAC3147DB30;
	Sat, 26 Sep 2009 00:52:40 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <200909260045.21171.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129131>

l=C3=B6rdag 26 september 2009 00:45:20 skrev Robin Rosenberg <robin.ros=
enberg@dewire.com>:
> onsdag 23 september 2009 18:42:29 skrev "Halstrick, Christian" <chris=
tian.halstrick@sap.com>:
> > From: Christian Halstrick <christian.halstrick@sap.com>
> >=20
> > JGit should understand configuration parameter logAllRefUpdates and=
 should
> > only log updates of refs when
> >   either the log file for this ref is already present
> >   or this configuration parameter is set to true
> > Before this commit JGit was always writing logs, regardless of this
> > parameter or existence of logfiles.
>=20
> A few minor things:
=46orgot: Please:
> Format the comment nicely and space betwee paragraphs.
[...]

-- robin
