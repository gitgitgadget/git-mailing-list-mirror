From: Edward Thomson <ethomson@microsoft.com>
Subject: Re: Merge with staged and unstaged changes
Date: Wed, 20 Feb 2013 21:46:08 +0000
Message-ID: <A54CE3E330039942B33B670D971F85740396C4F8@TK5EX14MBXC254.redmond.corp.microsoft.com>
References: <7vobfeybwt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 22:47:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8HVL-0001Cb-OE
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 22:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138Ab3BTVqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 16:46:43 -0500
Received: from na01-by2-obe.ptr.protection.outlook.com ([207.46.100.27]:2355
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab3BTVqm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2013 16:46:42 -0500
Received: from BL2FFO11FD006.protection.gbl (10.173.161.203) by
 BL2FFO11HUB016.protection.gbl (10.173.160.108) with Microsoft SMTP Server
 (TLS) id 15.0.620.12; Wed, 20 Feb 2013 21:46:39 +0000
Received: from TK5EX14MLTC102.redmond.corp.microsoft.com (131.107.125.37) by
 BL2FFO11FD006.mail.protection.outlook.com (10.173.161.2) with Microsoft SMTP
 Server (TLS) id 15.0.620.12 via Frontend Transport; Wed, 20 Feb 2013 21:46:38
 +0000
Received: from TK5EX14MBXC254.redmond.corp.microsoft.com ([169.254.2.84]) by
 TK5EX14MLTC102.redmond.corp.microsoft.com ([157.54.79.180]) with mapi id
 14.02.0318.003; Wed, 20 Feb 2013 21:46:09 +0000
Thread-Topic: Merge with staged and unstaged changes
Thread-Index: AQHOD576PkYsSA9sEkyCP3OW/l2NPJiDMHeK//+zFoA=
In-Reply-To: <7vobfeybwt.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.0.121105
x-originating-ip: [157.54.51.36]
Content-ID: <065E92E12BA9C6428CB401E7BF0F8B0E@microsoft.com>
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(189002)(199002)(24454001)(43784002)(377454001)(479174001)(52034002)(54356001)(5343635001)(80022001)(53806001)(44976002)(47446002)(79102001)(16406001)(31966008)(23726001)(46406002)(59766001)(47776003)(65816001)(77982001)(33656001)(76482001)(63696002)(20776003)(74662001)(56776001)(66066001)(51856001)(54316002)(49866001)(74502001)(47736001)(4396001)(46102001)(47976001)(50466001)(55846006)(50986001)(56816002);DIR:OUT;SFP:;SCL:1;SRVR:BL2FFO11HUB016;H:TK5EX14MLTC102.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 07630F72AD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216736>

On 2/20/13 2:21 PM, "Junio C Hamano" <gitster@pobox.com> wrote:

>Both are very much on purpose. The integrator may have seen the
>patch on the list, ran "git apply [--index]" on it to contemplate on
>it, and before commiting the result, saw a pull request for a branch
>that contains the change.  The above two allow the pull from such a
>state to succeed without losing any information.

>I think we have a similar table in Documentation/technical area that
>explains these things, by the way.

I believe you are referring to trivial-merge.txt which has been
exceptionally helpful in understanding "what" unpack trees does.
I appreciate this detailed explanation in providing the "why".

I also appreciate your explanation of the affect of the workdir,
and that makes sense.  I would have expected that the default was
to presume the workdir files were existent, rather than the
other way around, but we can agree that is an implementation detail.

My biggest concern, of course, was having the unstaged files in my
workdir overwritten or deleted.

Thanks again-

-ed
