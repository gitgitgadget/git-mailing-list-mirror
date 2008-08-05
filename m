From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: extracting to/cc addresses for stg mail
Date: Tue, 5 Aug 2008 11:43:19 -0600
Message-ID: <200808051143.19683.bjorn.helgaas@hp.com>
References: <200808011650.45915.bjorn.helgaas@hp.com> <20080805133922.GB29499@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 19:45:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQQbP-0002tK-CU
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 19:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753543AbYHERol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Aug 2008 13:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbYHERok
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 13:44:40 -0400
Received: from g4t0014.houston.hp.com ([15.201.24.17]:38510 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbYHERok (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 13:44:40 -0400
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g4t0014.houston.hp.com (Postfix) with ESMTP id 9AE7224623;
	Tue,  5 Aug 2008 17:44:39 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id ECA6924006;
	Tue,  5 Aug 2008 17:44:23 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 9AB1539C08A;
	Tue,  5 Aug 2008 11:44:18 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at ldl.fc.hp.com
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k+94NpriZbhx; Tue,  5 Aug 2008 11:44:17 -0600 (MDT)
Received: from tigger.helgaas (lart.fc.hp.com [15.11.146.31])
	by ldl.fc.hp.com (Postfix) with ESMTP id 9185C39C05D;
	Tue,  5 Aug 2008 11:44:17 -0600 (MDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <20080805133922.GB29499@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91449>

On Tuesday 05 August 2008 07:39:22 am Karl Hasselstr=F6m wrote:
> On 2008-08-01 16:50:45 -0600, Bjorn Helgaas wrote:
>=20
> > Is there a way to make stg pay attention to my "To:" lines in the
> > patch description? Or another way to accomplish this?
>=20
> It can't do it at the moment, but it should be easy to fix. In
> stgit/commands/mail.py, the following lines
>=20
>     if options.auto:
>         extra_cc =3D __get_signers_list(descr)
>     else:
>         extra_cc =3D []
>=20
> add the extra CC addresses. You could augment __get_signers_list to
> return a tuple of to and cc addresses instead of just cc addresses,
> pass those addesses to the same place extra_cc is fed now, and that's
> it.
>=20
> If you really hate Python, don't have time, etc., I can do it for you
> (as long as you agree to test it) -- just ask -- but I try to take
> every opportunity to get people to contribute patches. :-)

Thanks for the hints.  I'll take a look at it.  It'll take me a while,
but it's a good excuse to try to learn a little Python.

Bjorn
