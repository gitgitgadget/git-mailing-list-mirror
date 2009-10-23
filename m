From: "Zivkov, Sasa" <sasa.zivkov@sap.com>
Subject: RE: Unreachable code in builtin-merge.c ?
Date: Fri, 23 Oct 2009 17:39:03 +0200
Message-ID: <B221C4384AE5104EB414A877DFD0372C0B0092C117@DEWDFECCR04.wdf.sap.corp>
References: <B221C4384AE5104EB414A877DFD0372C0B0092C0C5@DEWDFECCR04.wdf.sap.corp>
 <4AE1C863.3070907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 23 17:39:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1MEZ-0008WL-VS
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 17:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbZJWPjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 11:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752224AbZJWPjG
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 11:39:06 -0400
Received: from smtpde01.sap-ag.de ([155.56.68.171]:64940 "EHLO
	smtpde01.sap-ag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZJWPjF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 11:39:05 -0400
Received: from mail.sap.corp
	by smtpde01.sap-ag.de (26) with ESMTP id n9NFd91x020663
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 23 Oct 2009 17:39:09 +0200 (MEST)
Thread-Topic: Unreachable code in builtin-merge.c ?
Thread-Index: AcpT85OaecrgcHGzQxaZDHa8Guim1QAA0HCw
In-Reply-To: <4AE1C863.3070907@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Scanner: Virus Scanner virwal04
X-SAP: out
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131109>

> Not quite :)  The strcmp() function actually returns 0 when the strin=
gs
> match (I know, it looks weird "!strcmp" -> "not string compare?!"), s=
o

Right! Now I remember it :-)

This is what happens when one looks at C code after some 10+ years of !=
C development ;-)

Sa=B9a =AEivkov
