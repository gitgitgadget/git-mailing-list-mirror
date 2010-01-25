From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 20:37:41 +0100
Message-ID: <201001252037.41497.robin.rosenberg@dewire.com>
References: <201001250155.47664.robin.rosenberg@dewire.com> <alpine.DEB.1.00.1001251553150.8733@intel-tinevez-2-302> <40aa078e1001250957h292f8b01me8f7dec4ba2b425b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 25 20:37:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZUkx-0007Ev-Cy
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 20:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab0AYThs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 14:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953Ab0AYThs
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 14:37:48 -0500
Received: from mail.dewire.com ([83.140.172.130]:20429 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab0AYThr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 14:37:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1CB521025B79;
	Mon, 25 Jan 2010 20:37:44 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a4GO8b3OVcKU; Mon, 25 Jan 2010 20:37:43 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 73015800353;
	Mon, 25 Jan 2010 20:37:43 +0100 (CET)
User-Agent: KMail/1.12.4 (Linux/2.6.31-17-generic; KDE/4.3.4; i686; ; )
In-Reply-To: <40aa078e1001250957h292f8b01me8f7dec4ba2b425b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137982>

m=E5ndagen den 25 januari 2010 18.57.06 skrev  Erik Faye-Lund:
> On Mon, Jan 25, 2010 at 6:34 PM, Johannes Schindelin
>=20
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Mon, 25 Jan 2010, Robin Rosenberg wrote:
> >> >From 37a74ccd395d91e5662665ca49d7f4ec49811de0 Mon Sep 17 00:00:00=
 2001
> >>
> >> From: Robin Rosenberg <robin.rosenberg@dewire.com>
> >> Date: Mon, 25 Jan 2010 01:41:03 +0100
> >> Subject: [PATCH] Handle UNC paths everywhere
> >>
> >> In Windows paths beginning with // are knows as UNC paths. They ar=
e
> >> absolute paths, usually referring to a shared resource on a server=
=2E
> >
> > And even a simple "cd" with them does not work.
>=20
> But it does, at least for me - both in bash and cmd.exe. I just needt=
=2E

In cmd,exe surprises me a bit. pushd \\server\share is not the same
as it maps a drive and then uses it to cd.

-- robin
