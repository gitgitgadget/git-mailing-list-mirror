From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 09/19] Refactor Config hierarchy to make IO more explicit
Date: Sun, 26 Jul 2009 01:34:10 +0200
Message-ID: <200907260134.10820.robin.rosenberg.lists@dewire.com>
References: <1248547982-4003-1-git-send-email-spearce@spearce.org> <200907260054.06037.robin.rosenberg.lists@dewire.com> <20090725225504.GG11191@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 26 01:35:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUqly-0005rV-Ko
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 01:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbZGYXfD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 19:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbZGYXfD
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 19:35:03 -0400
Received: from mail.dewire.com ([83.140.172.130]:25815 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbZGYXfC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 19:35:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3F1711481DBD;
	Sun, 26 Jul 2009 01:35:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swPzLwk6r60O; Sun, 26 Jul 2009 01:34:28 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 98B441481DB2;
	Sun, 26 Jul 2009 01:34:13 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090725225504.GG11191@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124098>

s=F6ndag 26 juli 2009 00:55:04 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> >=20
> > This one does not apply for the Config class here.
>=20
> Did you apply with --whitespace=3Dstrip or something and fall afoul
> of a merge conflict due to changed context?
>=20

I tried both ways.


Config.java looks (partially) like this:

--------------------------
import java.util.Map;
import java.util.Set;

/**

----------------------------

and the patch looks (partially again) like this:

@@ -55,19 +49,18 @@
 import java.util.Map;
 import java.util.Set;

+import org.spearce.jgit.errors.ConfigInvalidException;
 import org.spearce.jgit.util.StringUtils;

+
 /**
----------------

So the import among other things, does not match.

-- robin
