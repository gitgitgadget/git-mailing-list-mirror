From: "Gilbert Liddell" <gliddell@totalrepair.co.uk>
Subject: RE: svn clone Checksum mismatch question
Date: Thu, 26 Mar 2009 13:28:11 -0000
Message-ID: <D92CD911394B11428C65AFB4222835AE01255586@mercury.totalrepair.co.uk>
References: <22719363.post@talk.nabble.com> <20090326130213.GC3114@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?iso-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:45:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmptR-00083a-CD
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 14:45:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617AbZCZNnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 09:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757258AbZCZNnh
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 09:43:37 -0400
Received: from [194.73.118.11] ([194.73.118.11]:48058 "EHLO
	mail.totalrepair.co.uk" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756209AbZCZNng convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 09:43:36 -0400
X-Greylist: delayed 920 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2009 09:43:35 EDT
Received: from totalrepair.co.uk [10.0.100.85] by mail.totalrepair.co.uk - SurfControl E-mail Filter (6.0.1); Thu, 26 Mar 2009 13:28:11 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20090326130213.GC3114@atjola.homenet>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: svn clone Checksum mismatch question
thread-index: AcmuFi0OFpYGl7HoQFK1HUntnF2rpQAAEsOw
X-SEF-7853D99-ADF1-478E-8894-213D316B8FFA: 1
X-SEF-Processed: 6_0_1_111__2009_03_26_13_28_11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114777>

Hi Bj=F6rn,=0D
=0D
Thanks for the reply, i'm using git version 1.6.2.msysgit.0.186.gf7512=0D
=0D
Gilbert.=0D
=0D
-----Original Message-----=0D
=46rom: Bj=F6rn Steinbrink [mailto:B.Steinbrink@gmx.de] =0D
Sent: 26 March 2009 13:02=0D
To: Gilbert Liddell=0D
Cc: git@vger.kernel.org=0D
Subject: Re: svn clone Checksum mismatch question=0D
=0D
On 2009.03.26 03:31:53 -0700, Gilbert Liddell wrote:=0D
> This morning i decided to test the clone with the full project i'm wo=
rking=0D
> on (11,000 files) and I get the error message Checksum mismatch: vn2.=
sln=0D
> 0f7a82f1d38b819 expected: fde799e5ba0d1d07e6b539016bea3260=0D
> got: e71db1010a0da06ea76d4163c452df72=0D
> =0D
> Can someone help with why this error is happening? Is there an issue =
with=0D
> the GIT clone and large repositories?=0D
=0D
Which git version is that? There was some bug in git-svn that caused it=
=0D
to fill the disk with temporary files, without noticing that those file=
s=0D
get truncated when the disk is full. That was fixed in some 1.6.0.x=0D
release IIRC.=0D
=0D
Bj=F6rn=0D
=0D
Registered in Scotland=0D
32 Fountain Drive=0D
Inchinnan Business Park=0D
Renfrewshire,PA4 9RF.=0D
Company number:SC112872=0D
=0D
This e-mail and any files transmitted with it are confidential and=0D
intended solely for the use of the individual or entity to whom=0D
they are addressed.=0D
If you have received this e-mail in error please notify the=0D
originator of the message. This footer also confirms that this=0D
e-mail message has been scanned for the presence of computer viruses.=0D
=0D
Any views expressed in this message are those of the individual=0D
sender, except where the sender specifies and with authority,=0D
states them to be the views of Total Repair Solutions.=0D
=0D
Scanning of this message and addition of this footer is performed=0D
by SurfControl E-mail Filter software in conjunction with =0D
virus detection software.=0D
