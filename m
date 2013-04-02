From: Edward Thomson <ethomson@microsoft.com>
Subject: RE: Rename conflicts in the index
Date: Tue, 2 Apr 2013 20:55:37 +0000
Message-ID: <A54CE3E330039942B33B670D971F857403A0F540@TK5EX14MBXC253.redmond.corp.microsoft.com>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
 <7va9q72n1u.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vboa6t14w.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vk3osn3vs.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0BB93@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7v38vgmxty.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0E20C@TK5EX14MBXC253.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 22:56:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN8FZ-0005pR-6r
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 22:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762452Ab3DBUzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 16:55:43 -0400
Received: from mail-by2lp0242.outbound.protection.outlook.com ([207.46.163.242]:24651
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762433Ab3DBUzm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 16:55:42 -0400
Received: from BL2FFO11FD023.protection.gbl (10.173.161.204) by
 BL2FFO11HUB033.protection.gbl (10.173.161.113) with Microsoft SMTP Server
 (TLS) id 15.0.651.3; Tue, 2 Apr 2013 20:55:40 +0000
Received: from TK5EX14MLTC103.redmond.corp.microsoft.com (131.107.125.37) by
 BL2FFO11FD023.mail.protection.outlook.com (10.173.161.102) with Microsoft
 SMTP Server (TLS) id 15.0.664.0 via Frontend Transport; Tue, 2 Apr 2013
 20:55:39 +0000
Received: from TK5EX14MBXC253.redmond.corp.microsoft.com ([169.254.3.151]) by
 TK5EX14MLTC103.redmond.corp.microsoft.com ([157.54.79.174]) with mapi id
 14.02.0318.003; Tue, 2 Apr 2013 20:55:38 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQAI1oifAoxQUOAABEG55gAtP7SQAAEvx18AAmt9kAACJe2MAPKwK3AAPU21cA==
In-Reply-To: <A54CE3E330039942B33B670D971F857403A0E20C@TK5EX14MBXC253.redmond.corp.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.37]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(51704002)(189002)(199002)(24454001)(63696002)(54316002)(59766001)(53806001)(74662001)(50986001)(51856001)(47976001)(56816002)(20776003)(47776003)(47446002)(23726001)(77982001)(44976002)(74502001)(79102001)(49866001)(33656001)(31966008)(81342001)(50466001)(47736001)(16406001)(65816001)(55846006)(46406002)(54356001)(46102001)(4396001)(69226001)(76482001)(66066001)(56776001)(80022001);DIR:OUT;SFP:;SCL:1;SRVR:BL2FFO11HUB033;H:TK5EX14MLTC103.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 08041D247D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219885>

Edward Thomson [ethomson@microsoft.com] wrote:
> Junio C Hamano [mailto:gister@pobox.com] wrote:
> >  * Path A may have only stage #1, while path B and C has only stage
> >    #2 and stage #3 (the user would have to notice these three
> >    correspond to each other, and resolve manually).
> >
> >    You would want to annotate "B at stage #2 seems to have been at A
> >    in the original" (similarly for C#3) if you choose to do so.
> 
> If we're going to make changes to the way conflicts are recorded in the main
> index, then I would prefer this approach.  It is unambiguous and all data about
> all sides are recorded, including the names that items had in their respective
> branches.

Junio, did you have additional thoughts on this?

What would you like from me to proceed?  If the aforementioned seems
reasonable, I can update Documentation/technical/index-format.txt and
we can iron out the details in that fashion?

Thanks-
-ed
