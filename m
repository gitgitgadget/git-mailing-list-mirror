From: "Hawk, Jeff" <jeff.hawk@here.com>
Subject: Re: since/after not working properly
Date: Thu, 19 May 2016 19:43:09 +0000
Message-ID: <DB5PR0401MB184571A07FD0E88F5ADD60569B4A0@DB5PR0401MB1845.eurprd04.prod.outlook.com>
References: <573DDEBF.7000903@here.com>
	<CAPc5daXPWiY8=NtOcsjMcVN2MiwaaQUbVY6GBn2Eu31Q0fZrUQ@mail.gmail.com>
	<AM4PR0401MB184426EE089AE65941C5F7869B4A0@AM4PR0401MB1844.eurprd04.prod.outlook.com>,<xmqqeg8xj2ed.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 21:58:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3U5P-0004Kp-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 21:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932960AbcEST6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 15:58:19 -0400
Received: from mail-am1on0144.outbound.protection.outlook.com ([157.56.112.144]:55869
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932719AbcEST6S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 15:58:18 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 May 2016 15:58:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmcs.onmicrosoft.com;
 s=selector1-here-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=S+7PcLXYQeXnY0yPKW9mWeOlf+KDA/cv1XbaVVWk97s=;
 b=vPXhbqee+zFwqGtBXIr3DWlzHs5vKr/i/bzFw2CWlZ6On1wy1743vrXxRNTnIwr4g0t+Xt4+YKinzDsXNyRuNUn3YUlNJPXBYOUP1LIvmIUJWQC8dPFyRs8v5zIoOwzQ9OYPlwyw5WkK3+jhREyRU4eJ+Jsc4yjhdT+QmOdvTaE=
Received: from DB5PR0401MB1845.eurprd04.prod.outlook.com (10.165.6.15) by
 DB5PR0401MB1845.eurprd04.prod.outlook.com (10.165.6.15) with Microsoft SMTP
 Server (TLS) id 15.1.497.12; Thu, 19 May 2016 19:43:09 +0000
Received: from DB5PR0401MB1845.eurprd04.prod.outlook.com ([10.165.6.15]) by
 DB5PR0401MB1845.eurprd04.prod.outlook.com ([10.165.6.15]) with mapi id
 15.01.0497.019; Thu, 19 May 2016 19:43:09 +0000
Thread-Topic: since/after not working properly
Thread-Index: AQHRseUkX+tAMLq9k0a7tYzRmYa1YZ/Ag5eAgAACGdiAABjs9oAACtJX
In-Reply-To: <xmqqeg8xj2ed.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pobox.com; dkim=none (message not signed)
 header.d=none;pobox.com; dmarc=none action=none header.from=here.com;
x-originating-ip: [25.164.12.4]
x-ms-office365-filtering-correlation-id: 0fb8c5b5-d5bc-442c-2169-08d3801dce98
x-microsoft-exchange-diagnostics: 1;DB5PR0401MB1845;5:ICkDz48Iesj+xi8/X54NbzpzQtD+HJwgp2jCWUsQNlCigq/3znYaFie6E8hyCz6G3zYUzEqgMyUlSr3ck5vpOv3d5oZ/aoaTG3HA09s+6+Hwb6WyN8EEAW5SfX+sWVdGMaXuyt2p/q0av82A+s4scg==;24:L/PDp27ANBRJHWoQrcRS+/k+DNIdQqXxMm3FUcGFQudha3R+EBYttXWufoBDsXMikRKr9JzLx9QfVlvVLLVGHkTuaaJp7usgdrJkD3A4B6s=;7:9yp3SPAWp5WRqyIk+8JVqGzURCvgE4xvO1ZN1IwCcQyvH7/j3quLCV71F01U6/Nc94NEqNnFysoQrP5Tv94UxVbohNg4owBIQrTykvwGg3Z9VbdLtH1WYYuvVyF+JVUJxXDWzjfSGP5Ne669vYPLl3chS8DQoInz72B0pUZ5/9Gz5+F02pgtrSiTJJl/+lf+
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0401MB1845;
x-microsoft-antispam-prvs: <DB5PR0401MB1845E614E6D142C55F66AA609B4A0@DB5PR0401MB1845.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:DB5PR0401MB1845;BCL:0;PCL:0;RULEID:;SRVR:DB5PR0401MB1845;
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(40764003)(377454003)(4326007)(3660700001)(2906002)(3280700002)(9686002)(3480700004)(11100500001)(5004730100002)(10400500002)(2900100001)(74316001)(122556002)(2950100001)(1220700001)(106116001)(110136002)(189998001)(76576001)(19580405001)(19580395003)(87936001)(66066001)(92566002)(86362001)(76176999)(54356999)(50986999)(93886004)(102836003)(3846002)(6116002)(77096005)(81166006)(8676002)(5008740100001)(5002640100001)(33656002)(586003)(5003600100002)(8936002)(7059030);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR0401MB1845;H:DB5PR0401MB1845.eurprd04.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2016 19:43:09.4105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR0401MB1845
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295095>


Thanks for your help and sorry for my confused regarding ad and cd.
________________________________________
From: Junio C Hamano <gitster@pobox.com>
Sent: Thursday, May 19, 2016 2:03:54 PM
To: Hawk, Jeff
Cc: Git Mailing List
Subject: Re: since/after not working properly

"Hawk, Jeff" <jeff.hawk@here.com> writes:

> They suggest this:
> git log --all --numstat --date=short --pretty=format:'--%h--%ad--%aN' --no-renames
>
> Seems like the %ad should be %cd.

I have no opinion on that.  If somebody wants to show author dates,
that's her choice.
