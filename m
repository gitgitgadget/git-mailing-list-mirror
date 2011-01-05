From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [minor BUG] cherry-pick -x doesn't work if a conflict occurs
Date: Wed, 5 Jan 2011 07:31:05 +0100
Message-ID: <24C35180-AED6-4848-9F05-908831F911F9@dewire.com>
References: <20101229141638.GA14865@pengutronix.de>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jan 05 07:31:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaMuD-0006iG-GH
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 07:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab1AEGbJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 01:31:09 -0500
Received: from mail.dewire.com ([83.140.172.130]:1946 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab1AEGbI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 01:31:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3460D8003A0;
	Wed,  5 Jan 2011 07:31:07 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AHdnnamyZ58a; Wed,  5 Jan 2011 07:31:06 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B7E9A80025B;
	Wed,  5 Jan 2011 07:31:06 +0100 (CET)
In-Reply-To: <20101229141638.GA14865@pengutronix.de>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164551>


29 dec 2010 kl. 15:16 skrev Uwe Kleine-K=F6nig:

> Hello,
>=20
> when hitting a conflict cherry-pick suggests using
>=20
> 	git commit -c $sha1
>=20
> but the resulting (suggested) commit log doesn't have the extra
> reference requested by -x.
>=20

The man page says -x only takes effect when you do not have a conflict,=
 so there
is no bug.

-- robin
