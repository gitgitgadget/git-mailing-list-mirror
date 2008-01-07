From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 19:47:28 +0100
Message-ID: <200801071947.28586.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se> <5C0F88FD-AB2F-4BAD-ADEC-75428F14260F@zib.de> <20080107101256.GA25047@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 07 19:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBx16-0001kI-Up
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 19:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756430AbYAGSri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2008 13:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756260AbYAGSrh
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 13:47:37 -0500
Received: from [83.140.172.130] ([83.140.172.130]:7526 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755952AbYAGSrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 13:47:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B1741802893;
	Mon,  7 Jan 2008 19:47:34 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G6+HPLtZfbUn; Mon,  7 Jan 2008 19:47:33 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id AB1F3802641;
	Mon,  7 Jan 2008 19:47:33 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <20080107101256.GA25047@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69799>

m=E5ndagen den 7 januari 2008 skrev Jeff King:
> On Mon, Jan 07, 2008 at 10:57:52AM +0100, Steffen Prohaska wrote:
>=20
> I don't know if there are other options that might impact how clone
> works, but something like the patch below might make sense. It would
> allow:
>=20
>   git clone -c core.autocrlf=3Dtrue ...

You can also set the option globally. Maybe something for the installer=
 or a first time wizard.
But I do think git should have this option set right from the beginning=
=2E It could print out somethig
to notify the user that (and which) some options are not set the same a=
s on unix.

-- robin
