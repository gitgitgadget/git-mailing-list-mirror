From: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
Subject: Re: [PATCH 1/3] git-p4: default submit to use rename detection
Date: Thu, 21 Jan 2010 19:01:30 -0800
Message-ID: <4B59150A.8000002@naughtydog.com>
References: <4B590778.30403@naughtydog.com> <alpine.LFD.2.00.1001212139540.1726@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jan 22 04:01:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9lp-0003Z7-H1
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 04:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894Ab0AVDBJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jan 2010 22:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816Ab0AVDBI
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 22:01:08 -0500
Received: from ironport01a.scea.com ([160.33.44.41]:15037 "EHLO
	ironport01a.scea.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab0AVDBF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 22:01:05 -0500
X-IronPort-AV: E=Sophos;i="4.49,322,1262592000"; 
   d="scan'208";a="10635743"
Received: from inbetweener01.scea.com ([160.33.45.195])
  by ironport01a.scea.com with ESMTP; 21 Jan 2010 19:01:02 -0800
Received: from postal1-dog.naughtydog.com (intmail.naughtydog.com [10.15.0.14])
	by inbetweener01.scea.com (Postfix) with ESMTP id 2E6FCF017A;
	Thu, 21 Jan 2010 19:01:02 -0800 (PST)
Received: from [127.0.0.1] ([150.0.6.116]) by postal1-dog.naughtydog.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Jan 2010 19:01:29 -0800
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LFD.2.00.1001212139540.1726@xanadu.home>
X-OriginalArrivalTime: 22 Jan 2010 03:01:29.0978 (UTC) FILETIME=[320985A0:01CA9B0F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137729>

Nicolas Pitre wrote:
> On Thu, 21 Jan 2010, Pal-Kristian Engstad wrote:
>=20
>> Enable git's rename detection by default. This is needed to preserve
>> Perforce's history.
>>
>> Removed the '-M' flag and added a '--no-detect' flag to preserve the
>> old behavior.
>=20
> You should keep the -M flag, even if it ends up doing nothing, for=20
> backward compatibility.  And --no-detect is really a bad flag name. =20
> Maybe --no-detect-renames instead?

I'm not sure if git-p4 wants to keep backwards compatibility. I doubt t=
here's
many scripts out there that calls git-p4, but Simon should decide.

I have no problem with the --no-detect-renames flag, though.

PKE.
--=20
P=E5l-Kristian Engstad (engstad@naughtydog.com),=20
Lead Graphics & Engine Programmer,
Naughty Dog, Inc., 1601 Cloverfield Blvd, 6000 North,
Santa Monica, CA 90404, USA. Ph.: (310) 633-9112.

"Emacs would be a far better OS if it was shipped with=20
 a halfway-decent text editor." -- Slashdot, Dec 13. 2005.
