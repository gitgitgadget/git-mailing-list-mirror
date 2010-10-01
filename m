From: <nolan.ring@emc.com>
Subject: RE: Svn2git: question about --branches
Date: Fri, 1 Oct 2010 07:24:00 -0400
Message-ID: <4E10ACF241081344B9702AA8C6440440C5B15CB726@MX01A.corp.emc.com>
References: <20100930160734.056754ec@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <jk@jk.gs>
X-From: git-owner@vger.kernel.org Fri Oct 01 13:24:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1djW-0002IF-VC
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 13:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444Ab0JALYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 07:24:54 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:15657 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab0JALYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 07:24:53 -0400
Received: from hop04-l1d11-si03.isus.emc.com (HOP04-L1D11-SI03.isus.emc.com [10.254.111.23])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o91BOm4m029169
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Oct 2010 07:24:49 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.221.253]) by hop04-l1d11-si03.isus.emc.com (RSA Interceptor); Fri, 1 Oct 2010 07:24:41 -0400
Received: from corpussmtp4.corp.emc.com (corpussmtp4.corp.emc.com [10.254.169.197])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o91BO19N004728;
	Fri, 1 Oct 2010 07:24:04 -0400
Received: from mxhub06.corp.emc.com ([128.221.46.114]) by corpussmtp4.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Fri, 1 Oct 2010 07:24:02 -0400
Received: from MX01A.corp.emc.com ([169.254.1.232]) by mxhub06.corp.emc.com
 ([128.221.46.114]) with mapi; Fri, 1 Oct 2010 07:24:02 -0400
Thread-Topic: Svn2git: question about --branches
Thread-Index: ActgqVYDLj1x+wZdTAShoVItZ0UmYQAVeC4w
In-Reply-To: <20100930160734.056754ec@jk.gs>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 01 Oct 2010 11:24:02.0367 (UTC) FILETIME=[265BF4F0:01CB615B]
X-EMM-MHVC: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157744>

=20
Thanks for your response.  I'm sorry that I missed it in the documentat=
ion.

I'm trying using --branches twice but the init command that the -v opti=
on returns would seem to indicate that "--branches branches" isn't bein=
g picked up.

pocadmin@usd-ubuntu-poc:~/pocc4core$ svn2git -v --trunk sspg --branches=
 branches --branches REbranches --tags tags http://poc.emc.com/svn/repo=
s/pocc4core/c4
Running command: git svn init --no-metadata --trunk=3Dsspg --tags=3Dtag=
s --branches=3DREbranches http://poc.emc.com/svn/repos/pocc4core/c4
Initialized empty Git repository in /home/pocadmin/pocc4core/.git/
Using higher level of URL: http://poc.emc.com/svn/repos/pocc4core/c4 =3D=
> http://poc.emc.com/svn/repos/pocc4core
Running command: git svn fetch

The conversion completed overnight and only REbranches was converted.  =
Nothing under branches was converted.  Assuming my syntax is correct is=
 there anything else that's obviously wrong?

Thanks again.

-----Original Message-----
=46rom: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On=
 Behalf Of Jan Kr=FCger
Sent: Thursday, September 30, 2010 10:08 AM
To: Ring, Nolan
Cc: git@vger.kernel.org
Subject: Re: Svn2git: question about --branches

Hi,

--- nolan.ring@emc.com <nolan.ring@emc.com> wrote:

> Our svn directory structure at the top level is:
> [...]
> branches
> REbranches
> [...]
> Branches is developer branches; REbranches is release engineering
> branches.  Is there any way to specify both using --branches?

Yep... just use --branches twice. The documentation for these options
even mentions that you can do that, actually. Just saying. :)

-Jan
