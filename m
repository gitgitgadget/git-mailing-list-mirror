From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT] Re: blinking test WindowCacheGetTest.testCache_TooSmallLimit
Date: Sat, 25 Jul 2009 19:34:36 +0200
Message-ID: <200907251934.37145.robin.rosenberg.lists@dewire.com>
References: <85647ef50907220623i2b7e50dal67650a638921ec0f@mail.gmail.com> <20090724225118.GZ11191@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUl96-0000zu-Pl
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 19:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbZGYReq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 13:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZGYReq
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 13:34:46 -0400
Received: from mail.dewire.com ([83.140.172.130]:21666 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbZGYRep convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jul 2009 13:34:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B6D481481DBD;
	Sat, 25 Jul 2009 19:34:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eg5Wk5Oca0J3; Sat, 25 Jul 2009 19:34:40 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 183241481DB2;
	Sat, 25 Jul 2009 19:34:40 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090724225118.GZ11191@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124024>

l=F6rdag 25 juli 2009 00:51:18 skrev "Shawn O. Pearce" <spearce@spearce=
=2Eorg>:
> Constantine Plotnikov <constantine.plotnikov@gmail.com> wrote:
> > The test WindowCacheGetTest.testCache_TooSmallLimit sometimes fails
> > (on less than third of runs on Windows) with the following stacktra=
ce:
> >=20
> > junit.framework.AssertionFailedError
> > at junit.framework.Assert.fail(Assert.java:47)
> > at junit.framework.Assert.assertTrue(Assert.java:20)
> > at junit.framework.Assert.assertTrue(Assert.java:27)
> > at org.spearce.jgit.lib.WindowCacheGetTest.checkLimits(WindowCacheG=
etTest.java:112)
> > at org.spearce.jgit.lib.WindowCacheGetTest.testCache_TooSmallLimit(=
WindowCacheGetTest.java:106)
> >=20
> > This happens on Windows and Linux, but I do not know about
> > frequency on Linux.
>=20
> I'd say the frequency on Linux is about 1/6 for me.  I have yet to
> be bothered enough to track it down, but its starting to get there.
> Maybe I'll try to look at it tomorrow.

Could it be threading-related (cache). I've never seen it on the machin=
e where I build for
the update site and it is a single core machine, but I "this" machine t=
hat has two cores it happens, not
as offen as 1/6, but enough to annoy me a bit, perhaps 1/20. If it is r=
elated to bad synchronization
it should happen more often the more cores you have.

-- robin
