From: Edward Thomson <ethomson@microsoft.com>
Subject: RE: Rename conflicts in the index
Date: Tue, 2 Apr 2013 21:29:30 +0000
Message-ID: <A54CE3E330039942B33B670D971F857403A0F593@TK5EX14MBXC253.redmond.corp.microsoft.com>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
 <7va9q72n1u.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0AA7A@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vboa6t14w.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0BA54@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vk3osn3vs.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0BB93@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7v38vgmxty.fsf@alter.siamese.dyndns.org>
 <A54CE3E330039942B33B670D971F857403A0E20C@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <A54CE3E330039942B33B670D971F857403A0F540@TK5EX14MBXC253.redmond.corp.microsoft.com>
 <7vr4isaath.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 23:30:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN8mV-0003mO-3S
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 23:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761033Ab3DBV3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 17:29:46 -0400
Received: from mail-bn1lp0153.outbound.protection.outlook.com ([207.46.163.153]:53380
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760829Ab3DBV3q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 17:29:46 -0400
Received: from BN1AFFO11FD013.protection.gbl (10.58.52.201) by
 BN1BFFO11HUB026.protection.gbl (10.58.53.136) with Microsoft SMTP Server
 (TLS) id 15.0.651.3; Tue, 2 Apr 2013 21:29:40 +0000
Received: from TK5EX14HUBC103.redmond.corp.microsoft.com (131.107.125.37) by
 BN1AFFO11FD013.mail.protection.outlook.com (10.58.52.73) with Microsoft SMTP
 Server (TLS) id 15.0.651.3 via Frontend Transport; Tue, 2 Apr 2013 21:29:39
 +0000
Received: from TK5EX14MBXC253.redmond.corp.microsoft.com ([169.254.3.151]) by
 TK5EX14HUBC103.redmond.corp.microsoft.com ([157.54.86.9]) with mapi id
 14.02.0318.003; Tue, 2 Apr 2013 21:29:30 +0000
Thread-Topic: Rename conflicts in the index
Thread-Index: Ac4f8fcF2rzNm40zS7GBMxbrAtW2UQAI1oifAoxQUOAABEG55gAtP7SQAAEvx18AAmt9kAACJe2MAPKwK3AAPU21cAABG5FgAAAQp6A=
In-Reply-To: <7vr4isaath.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.54.51.37]
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(24454001)(189002)(199002)(51704002)(5343635001)(69226001)(46102001)(74502001)(55846006)(49866001)(54356001)(66066001)(50986001)(23726001)(47776003)(46406002)(50466001)(74662001)(47736001)(80022001)(76482001)(47446002)(33656001)(65816001)(31966008)(47976001)(20776003)(4396001)(59766001)(16406001)(77982001)(56816002)(53806001)(79102001)(54316002)(56776001)(51856001)(63696002)(81342001);DIR:OUT;SFP:;SCL:1;SRVR:BN1BFFO11HUB026;H:TK5EX14HUBC103.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 08041D247D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219889>

Junio C Hamano [mailto:gitster@pobox.com] wrote:
> Edward Thomson <ethomson@microsoft.com> writes:
> > Junio, did you have additional thoughts on this?
> 
> Not at this moment.
> 
> I think we have covered the principles (do not unnecessarily duplicate
> information, do not break existing implementations unnecessarily, etc.) already,
> and we know how we want to record "one side renamed A to B, the other side
> renamed A to C" case, but I do not think the discussion covered all cases yet.

Sorry, I'm not sure what you're asking for - would you just like some more
examples of what this looks like with aforementioned exotic conflict types?
Or are you looking for something more strict - BNF format, for example?

-ed
