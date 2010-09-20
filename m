From: <nolan.ring@emc.com>
Subject: RE: svn2git question: error: unknown switch `t'
Date: Mon, 20 Sep 2010 15:19:04 -0400
Message-ID: <4E10ACF241081344B9702AA8C6440440C5B14FB337@MX01A.corp.emc.com>
References: <4E10ACF241081344B9702AA8C6440440C5B14FB331@MX01A.corp.emc.com>,<AANLkTik_ouA-AD+tmGEvvcJeZqVj4Rge=hcoJ5Bqgt-R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 21:22:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxlx0-0000q2-Bw
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 21:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757162Ab0ITTWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 15:22:49 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:59959 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717Ab0ITTWs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 15:22:48 -0400
Received: from hop04-l1d11-si04.isus.emc.com (HOP04-L1D11-SI04.isus.emc.com [10.254.111.24])
	by mexforward.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8KJMkOY020620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 20 Sep 2010 15:22:46 -0400
Received: from mailhub.lss.emc.com (mailhub.lss.emc.com [10.254.221.251]) by hop04-l1d11-si04.isus.emc.com (RSA Interceptor); Mon, 20 Sep 2010 15:22:35 -0400
Received: from corpussmtp5.corp.emc.com (corpussmtp5.corp.emc.com [128.221.166.229])
	by mailhub.lss.emc.com (Switch-3.4.3/Switch-3.4.3) with ESMTP id o8KJLSCl029187;
	Mon, 20 Sep 2010 15:21:45 -0400
Received: from mxhub06.corp.emc.com ([128.221.46.114]) by corpussmtp5.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 20 Sep 2010 15:21:31 -0400
Received: from mxhub04.corp.emc.com (10.254.141.106) by mxhub06.corp.emc.com
 (128.221.46.114) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 20 Sep
 2010 15:21:31 -0400
Received: from MX01A.corp.emc.com ([169.254.1.232]) by mxhub04.corp.emc.com
 ([10.254.141.106]) with mapi; Mon, 20 Sep 2010 15:21:31 -0400
Thread-Topic: svn2git question: error: unknown switch `t'
Thread-Index: ActY7YySYLDZMdkZSaedC8CTZXEDNAACyQPb
In-Reply-To: <AANLkTik_ouA-AD+tmGEvvcJeZqVj4Rge=hcoJ5Bqgt-R@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 20 Sep 2010 19:21:31.0999 (UTC) FILETIME=[08539EF0:01CB58F9]
X-EMM-MHVC: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156653>

Hmmm, guess it wasn't that obvious to me!! :-)

I have 1.6.0.2 installed, which does support the --track option; did a =
later git support -t as well as --track?

> git --version
git version 1.6.0.2

Is there some way to know what version of git the svn2git I have instal=
led supports?  And any way to get a version of svn2git that supports th=
e one I have.

Thanks for your patience.

Nolan
________________________________________
=46rom: =C6var Arnfj=F6r=F0 Bjarmason [avarab@gmail.com]
Sent: Monday, September 20, 2010 1:58 PM
To: Ring, Nolan
Cc: git@vger.kernel.org
Subject: Re: svn2git question: error: unknown switch `t'

On Mon, Sep 20, 2010 at 17:39,  <nolan.ring@emc.com> wrote:
> Where did the -t come from?  What is this telling me?

git branch supports the -t or --track option. You obviously have too
old a git with too new a svn2git.
