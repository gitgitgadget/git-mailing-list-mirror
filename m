From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Using Git for Cobol source
Date: Wed, 3 Feb 2016 08:30:58 -0500
Message-ID: <003801d15e87$1e160310$5a420930$@nexbridge.com>
References: <15b48134f6734b19a779269cf54d7c1c@ERFWEXM01.ERF01.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "=?iso-8859-1?Q?'Johnsen=2C_Per_J=F8rgen'?=" 
	<perjorgen.johnsen@dnb.no>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 15:04:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQy2Y-00070a-79
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 15:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756283AbcBCOD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2016 09:03:58 -0500
Received: from elephants.elehost.com ([216.66.27.132]:52637 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbcBCOD4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2016 09:03:56 -0500
X-Greylist: delayed 1921 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Feb 2016 09:03:55 EST
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u13DV0LZ032555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Feb 2016 08:31:01 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <15b48134f6734b19a779269cf54d7c1c@ERFWEXM01.ERF01.NET>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJQqC0FvieRhrV4akJ7wy6xjCIPd54bvILQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285369>

On February 3, 2016 4:20 AM, Per J=F8rgen Johnsen wrote:
> Subject: SV: Using Git for Cobol source
> I wonder if it is ok to use Git for source control for Cobol programs=
 and
take
> advantage of parallel development ?
>=20
> Today we are using VSS and needs to be replaced. Our Cobol developmen=
t is
> done by an Eclipse tool (Micro Focus Enterprise Developer)

COBOL should be no problem for git. The one caution I would have for yo=
u is
that if you happen to be using fixed-format mode with column-based sequ=
ence
numbers (that would be really old COBOL 74 mode), the sequence numbers =
may
give false positives on diff results. If you have those, lose them. Thi=
s
would apply to VSS also, so you're probably not using those anyway.

If you are functional in VSS for COBOL, you should be fine. Your challe=
nge
will be migrating history, which is possible, but will involve some eff=
ort.

Regards,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
