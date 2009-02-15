From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Sun, 15 Feb 2009 19:42:14 +0100
Message-ID: <200902151942.15055.robin.rosenberg.lists@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902151715.19351.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0902151745270.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 19:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYlxz-00070Y-Fk
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 19:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518AbZBOSmU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 13:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754508AbZBOSmU
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 13:42:20 -0500
Received: from mail.dewire.com ([83.140.172.130]:20062 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbZBOSmT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 13:42:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 767D1147E8D5;
	Sun, 15 Feb 2009 19:42:16 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qd1G8mqtz2Fw; Sun, 15 Feb 2009 19:42:15 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id CCCB18006AA;
	Sun, 15 Feb 2009 19:42:15 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-11-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <alpine.DEB.1.00.0902151745270.10279@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110031>

s=F6ndag 15 februari 2009 17:46:59 skrev Johannes Schindelin:
> Hi,
>=20
> On Sun, 15 Feb 2009, Robin Rosenberg wrote:
> > -	exit 1
> > +	echo >&2 "INFO: We recovered from the repack error, but your repo=
"
> > +	echo >&2 "INFO: is probably suboptimally packed. You may try to r=
epack"
> > +	echo >&2 "INFO: later. A common reason for repacking failure is t=
hat"
> > +	echo >&2 "INFO: a Windows program was locking one of the old pack=
 files."
> > +	echo >&2 "INFO: To repack successfully you may have to close that=
 program"
> > +	echo >&2 "INFO: before repacking."
>=20
> cat >&2 << EOF?

Yeah, but I followed the pattern from the warnings just prior to these =
messages.

> > +	exit
>=20
> You lose the error condition here, but I cannot find a convincing arg=
ument=20
> about that in the commit message.

I was thinking of my patch as an ammendment to Junios patch. In that co=
ntext.

"Exit success if rollback fails after failing to rename old packs." Doe=
sn't this
count?

-- robin
