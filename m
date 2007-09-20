From: "Matt Seitz \(matseitz\)" <matseitz@cisco.com>
Subject: RE: Symbolic link documentation
Date: Thu, 20 Sep 2007 10:52:07 -0700
Message-ID: <70952A932255A2489522275A628B97C3052E993B@xmb-sjc-233.amer.cisco.com>
References: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com> <Pine.LNX.4.64.0709201819340.28395@racer.site> <20070920172736.GU3099@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C7FBAE.E319FB10"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:01:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYQLe-0007AC-6f
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 20:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbXITSBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 14:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbXITSBx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 14:01:53 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:17076 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbXITSBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 14:01:52 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2007 14:01:52 EDT
X-IronPort-AV: E=Sophos;i="4.20,279,1186383600"; 
   d="vcf'?scan'208";a="19148147"
Received: from sj-dkim-3.cisco.com ([171.71.179.195])
  by sj-iport-1.cisco.com with ESMTP; 20 Sep 2007 10:51:36 -0700
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-3.cisco.com (8.12.11/8.12.11) with ESMTP id l8KHpaum026469
	for <git@vger.kernel.org>; Thu, 20 Sep 2007 10:51:36 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id l8KHpZX1010272
	for <git@vger.kernel.org>; Thu, 20 Sep 2007 17:51:35 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 20 Sep 2007 10:51:35 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20070920172736.GU3099@spearce.org>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Symbolic link documentation
Thread-Index: Acf7q4yyJgm8gcjCSmCPnZsFtS2dQwAAGy1A
X-OriginalArrivalTime: 20 Sep 2007 17:51:35.0717 (UTC) FILETIME=[E3265550:01C7FBAE]
DKIM-Signature: v=0.5; a=rsa-sha256; q=dns/txt; l=2000; t=1190310696; x=1191174696;
	c=relaxed/simple; s=sjdkim3002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=matseitz@cisco.com;
	z=From:=20=22Matt=20Seitz=20\(matseitz\)=22=20<matseitz@cisco.com>
	|Subject:=20RE=3A=20Symbolic=20link=20documentation
	|Sender:=20;
	bh=wTX7YOglA8WBKBvO2vHRpgrat5uNRYdLvJNpD6cws3g=;
	b=KhBJPqsez5IWZIvPhxWGPoFj014hh6bEpgcufu0aFiP51Wdt4/QVUUjJDyavcsBy7GNr/tfM
	g7ZAaHLYDpaxJqbhlkTgU2xT2KSFvOl6Nr1PiAtp3GBpT2L+P0bUDPz+;
Authentication-Results: sj-dkim-3; header.From=matseitz@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58794>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7FBAE.E319FB10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: spearce@spearce.org [mailto:spearce@spearce.org]=20
>=20
> > Documentation/git-update-index.txt:to 'false' (see=20
> > gitlink:git-config[1]), symbolic links are checked out=20
> Documentation/git-update-index.txt:from symbolic link to regular file.
> > Documentation/technical/racy-git.txt:files vs symbolic links) and=20
> > executable bits (only for regular
>=20
> These are probably what Matt was looking for.

The git-update-index and git-update-ref manual references are the
closest to what I was looking for.  Both are more low-level and
technical than what I was hoping for, and the discussion in
git-update-index seems targeted primarily at how symlinks are translated
on file systems that don't support symlinks.

I guess I was looking for something like the GNU "tar" documentation of
how symlinks are handled
(http://www.gnu.org/software/tar/manual/html_node/dereference.html#deref
erence).

--
Matt Seitz
Manager, File System Virtualization
Cisco Systems, Inc.
.:|:.:|:. =20

------_=_NextPart_001_01C7FBAE.E319FB10
Content-Type: text/x-vcard;
	name="Matt Seitz.vcf"
Content-Transfer-Encoding: base64
Content-Description: Matt Seitz.vcf
Content-Disposition: attachment;
	filename="Matt Seitz.vcf"

QkVHSU46VkNBUkQNClZFUlNJT046Mi4xDQpOOlNlaXR6O01hdHQNCkZOOk1hdHQgU2VpdHoNCk9S
RzpDaXNjbyBTeXN0ZW1zLCBJbmMNClRJVExFOk1hbmFnZXINClRFTDtXT1JLO1ZPSUNFOjQwOC0y
MDAtODAwMA0KQURSO1dPUks6OzszOTc1IEZyZWVkb20gQ2lyY2xlLCBGbG9vciA4O1NhbnRhIENs
YXJhO0NBOzk1MDU0O1VuaXRlZCBTdGF0ZXMgb2YgQW1lcmljYQ0KTEFCRUw7V09SSztFTkNPRElO
Rz1RVU9URUQtUFJJTlRBQkxFOjM5NzUgRnJlZWRvbSBDaXJjbGUsIEZsb29yIDg9MEQ9MEFTYW50
YSBDbGFyYSwgQ0EgOTUwNTQ9MEQ9MEFVbml0ZWQgU3RhdGVzIG89DQpmIEFtZXJpY2ENCkVNQUlM
O1BSRUY7SU5URVJORVQ6bWF0c2VpdHpAY2lzY28uY29tDQpSRVY6MjAwNzA3MDlUMjM0MDQ5Wg0K
RU5EOlZDQVJEDQo=

------_=_NextPart_001_01C7FBAE.E319FB10--
