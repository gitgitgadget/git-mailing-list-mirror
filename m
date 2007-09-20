From: "Matt Seitz \(matseitz\)" <matseitz@cisco.com>
Subject: RE: Symbolic link documentation
Date: Thu, 20 Sep 2007 12:11:28 -0700
Message-ID: <70952A932255A2489522275A628B97C3052E99F9@xmb-sjc-233.amer.cisco.com>
References: <70952A932255A2489522275A628B97C3052E98EB@xmb-sjc-233.amer.cisco.com> <Pine.LNX.4.64.0709201819340.28395@racer.site> <20070920172736.GU3099@spearce.org> <70952A932255A2489522275A628B97C3052E993B@xmb-sjc-233.amer.cisco.com> <20070920181100.GV3099@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C7FBB9.F94ED640"
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:11:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYRRH-00017N-Kz
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 21:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758539AbXITTLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 15:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbXITTK7
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 15:10:59 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:15117 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758501AbXITTK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 15:10:58 -0400
X-IronPort-AV: E=Sophos;i="4.20,280,1186383600"; 
   d="vcf'?scan'208";a="222015108"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-6.cisco.com with ESMTP; 20 Sep 2007 12:10:58 -0700
Received: from sj-core-2.cisco.com (sj-core-2.cisco.com [171.71.177.254])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id l8KJAvVk002902
	for <git@vger.kernel.org>; Thu, 20 Sep 2007 12:10:57 -0700
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by sj-core-2.cisco.com (8.12.10/8.12.6) with ESMTP id l8KJAvX1004827
	for <git@vger.kernel.org>; Thu, 20 Sep 2007 19:10:57 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 20 Sep 2007 12:10:57 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20070920181100.GV3099@spearce.org>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Symbolic link documentation
Thread-Index: Acf7sZxw/2QiNqxiTeKPjr0wvgjdFgABgvVw
X-OriginalArrivalTime: 20 Sep 2007 19:10:57.0500 (UTC) FILETIME=[F964C1C0:01C7FBB9]
DKIM-Signature: v=0.5; a=rsa-sha256; q=dns/txt; l=1339; t=1190315457; x=1191179457;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=matseitz@cisco.com;
	z=From:=20=22Matt=20Seitz=20\(matseitz\)=22=20<matseitz@cisco.com>
	|Subject:=20RE=3A=20Symbolic=20link=20documentation
	|Sender:=20;
	bh=xBSc+qIBekVOKRfzqrFNJUI+yPliUvNqgCZXRYD9zLY=;
	b=HjNOFpx3R0ZisRajrccmuF0nzJmzEjOTQjIlv+ebhPEEQwLIiJYYSL9HWRoevg5FPek/5l9P
	4vwI9QIOIS03oV+ElFEACJJtSCs0oDBAUEgTAkrGzviinmQh3WEu2VX30Ggyr9WOxwDZBtVZj0
	kis4Z34KmxUnPDJR97AmSK6BY=;
Authentication-Results: sj-dkim-1; header.From=matseitz@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58798>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7FBB9.F94ED640
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: spearce@spearce.org [mailto:spearce@spearce.org]=20
>=20
> So Git handles symlinks in the working tree *without*=20
> dereferencing them. =20

Thanks.  Is there a recommended procedure for tracking changes when the
symlink target is outside the working tree?

--
Matt Seitz
Manager, File System Virtualization
Cisco Systems, Inc.
.:|:.:|:.

------_=_NextPart_001_01C7FBB9.F94ED640
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

------_=_NextPart_001_01C7FBB9.F94ED640--
