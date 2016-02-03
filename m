From: =?iso-8859-1?Q?Johnsen=2C_Per_J=F8rgen?= <perjorgen.johnsen@dnb.no>
Subject: SV: Using Git for Cobol source
Date: Wed, 3 Feb 2016 09:19:33 +0000
Message-ID: <15b48134f6734b19a779269cf54d7c1c@ERFWEXM01.ERF01.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 10:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQtbT-0000Hw-1G
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 10:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbcBCJTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 04:19:54 -0500
Received: from mailhost1.dnb.no ([185.68.171.22]:34779 "EHLO mailhost1.dnb.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbcBCJTf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2016 04:19:35 -0500
Authentication-Results: mailhost1.dnb.no; spf=None smtp.mailfrom=perjorgen.johnsen@dnb.no; spf=None smtp.helo=postmaster@ERFWEXM09.ERF01.NET
Received-SPF: None (mailhost1.dnb.no: no sender authenticity
  information available from domain of
  perjorgen.johnsen@dnb.no) identity=mailfrom;
  client-ip=10.182.43.19; receiver=mailhost1.dnb.no;
  envelope-from="perjorgen.johnsen@dnb.no";
  x-sender="perjorgen.johnsen@dnb.no"; x-conformance=spf_only
Received-SPF: None (mailhost1.dnb.no: no sender authenticity
  information available from domain of
  postmaster@ERFWEXM09.ERF01.NET) identity=helo;
  client-ip=10.182.43.19; receiver=mailhost1.dnb.no;
  envelope-from="perjorgen.johnsen@dnb.no";
  x-sender="postmaster@ERFWEXM09.ERF01.NET";
  x-conformance=spf_only
IronPort-PHdr: =?us-ascii?q?9a23=3AUjQngxAbw51JvcE8qw+BUyQJP3N1i/DPJgcQr6Af?=
 =?us-ascii?q?oPdwSP78osbcNUDSrc9gkEXOFd2CrakU1KyP7+u5AjdIyK3CmU5BWaQEbwUCh8?=
 =?us-ascii?q?QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYsExnyfTB4?=
 =?us-ascii?q?Ov7yUtaLyZ/niKbrp9aKOF4ArQH+SI0xBS3+lR/WuMgSjNkqAYcK4TyNnEF1ff?=
 =?us-ascii?q?9Lz3hjP1OZkkW0zM6x+Jl+73YY4Kp5pIYTGZn9Ku43TKBwEjsrKSY26dftuB2F?=
 =?us-ascii?q?ShGArDNIXWQKugRHDhKD7xzgWJr19Czgubwu9jOdOJjUSrAyQjmkq5BTRQXfqr?=
 =?us-ascii?q?cdODM/uDXPh9Zyi7hUrRTnpRt/xZXZZqmZMvA4eKSLLoBSfnZIQssED38JOYi7?=
 =?us-ascii?q?dYZaV+c=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CpBABdxbFW/xMrtgpIFoR/iFWzOogCE?=
 =?us-ascii?q?AEBAQEBAQEBfguCLYIbgQsBM00mAQQbyCaGEYgvCBEBhFgFjV2JFGmFSYcUgWK?=
 =?us-ascii?q?EQohUjj8BN4QPiSU0fAEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2CpBABdxbFW/xMrtgpIFoR/iFWzOogCEAEBAQEBAQEBfgu?=
 =?us-ascii?q?CLYIbgQsBM00mAQQbyCaGEYgvCBEBhFgFjV2JFGmFSYcUgWKEQohUjj8BN4QPi?=
 =?us-ascii?q?SU0fAEBAQ?=
X-IronPort-AV: E=Sophos;i="5.22,389,1449529200"; 
   d="scan'208";a="22042302"
Received: from smtp-scan.dnbnor.no (HELO ERFWEXM09.ERF01.NET) ([10.182.43.19])
  by mailhost1.dnb.no with ESMTP; 03 Feb 2016 10:16:51 +0100
Received: from ERFWEXM01.ERF01.NET (10.182.43.11) by ERFWEXM09.ERF01.NET
 (10.182.43.19) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Wed, 3 Feb
 2016 10:19:33 +0100
Received: from ERFWEXM01.ERF01.NET ([10.182.42.100]) by ERFWEXM01.ERF01.NET
 ([10.182.42.100]) with mapi id 15.00.1076.000; Wed, 3 Feb 2016 10:19:33 +0100
Thread-Topic: Using Git for Cobol source
Thread-Index: AdFeYTnox4QhOfiYQl27a9oD0iUEbAAAi86gAAAcgKA=
Accept-Language: nb-NO, en-GB, en-US
Content-Language: nb-NO
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.182.43.7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285343>

Hi

I wonder if it is ok to use Git for source control for Cobol programs a=
nd take advantage of parallel development ?

Today we are using VSS and needs to be replaced. Our Cobol development =
is done by an Eclipse tool (Micro Focus Enterprise Developer)

Regards
_______________________________________________

Per J=F8rgen Johnsen | Technical Coordinator

DNB Bank ASA
Norway
________________________________
 This email with attachments may be confidential and intended solely fo=
r the use of the individual or entity to whom it is addressed. The emai=
l may contain legally protected information. If you have received this =
communication in error, be aware that making use of the information, fo=
rwarding it, copying it, or disclosing its content to other persons, is=
 strictly prohibited and may be punishable by law. Please inform the se=
nder about the error in transmission immediately.
________________________________
