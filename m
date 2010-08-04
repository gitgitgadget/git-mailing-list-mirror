From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: Inspecting a corrupt git object
Date: Wed, 04 Aug 2010 13:11:31 +0200
Message-ID: <4C594AE3.4000708@ira.uka.de>
References: <20100804092530.GA30070@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 13:29:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogc9u-00082f-7o
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 13:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757404Ab0HDL3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 07:29:10 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49805 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932638Ab0HDL3J (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Aug 2010 07:29:09 -0400
X-Greylist: delayed 1115 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2010 07:29:09 EDT
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1Ogbre-0005gP-QK
	for <git@vger.kernel.org>; Wed, 04 Aug 2010 13:10:31 +0200
Received: from i20smtp.iaks.uni-karlsruhe.de ([141.3.32.226])
	by irams1.ira.uni-karlsruhe.de with esmtps port 25 
	for <git@vger.kernel.org>
	id 1Ogbre-0000eR-KZ; Wed, 04 Aug 2010 13:10:26 +0200
Received: from throatwobbler.iaks.uka.de ([172.16.22.120])
	by i20smtp.iaks.uni-karlsruhe.de with esmtp (Exim 4.50)
	id 1Ogbsh-00006H-HX
	for git@vger.kernel.org; Wed, 04 Aug 2010 13:11:31 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100302)
In-Reply-To: <20100804092530.GA30070@jpl.local>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1280920232.028611000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1280921348.078808000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152573>

Magnus B=E4ck schrieb:
> Any other ideas why we would see such a difference? Hardware
> malfunction or memory corruption I guess, but something else?
> I can supply the actual object files if necessary.
>=20

I checked with a repository here and all objects seem to start with 78
01. That means it is a common prefix. Ergo no malicious tampering, as
that would make only sense if the contents of the blob had changed.

So a random hardware or software malfunction is left as explanation IMH=
O

Holger
