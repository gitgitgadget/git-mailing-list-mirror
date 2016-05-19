From: "Hawk, Jeff" <jeff.hawk@here.com>
Subject: Re: since/after not working properly
Date: Thu, 19 May 2016 17:37:42 +0000
Message-ID: <AM4PR0401MB184426EE089AE65941C5F7869B4A0@AM4PR0401MB1844.eurprd04.prod.outlook.com>
References: <573DDEBF.7000903@here.com>,<CAPc5daXPWiY8=NtOcsjMcVN2MiwaaQUbVY6GBn2Eu31Q0fZrUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 19:59:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3S8j-0008Mw-HB
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754819AbcESRxd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 13:53:33 -0400
Received: from mail-db5eur01on0115.outbound.protection.outlook.com ([104.47.2.115]:1728
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754530AbcESRxc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 13:53:32 -0400
X-Greylist: delayed 5832 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 May 2016 13:53:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmcs.onmicrosoft.com;
 s=selector1-here-com;
 h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=J75a4Bw4F3/FjkTzhCryNZYG2wmG/L1J5JxTpknXX/4=;
 b=KQebReb5xEcwlTmWyxAz1WOKv2vAnIDGh+a0OhQlhi8RcK0CRRgn6NQGU98dV0CstkORfqgE2HdbwUTjdGeqBCV9chC8PdoGzVMwXGYj3BplnWdVLubZPrYTzy9zvSHG6qhHX4iiURm589eVqRbk2bzU4TYXU5AoWVo2Bqt1nKs=
Received: from AM4PR0401MB1844.eurprd04.prod.outlook.com (10.165.245.19) by
 AM4PR0401MB1843.eurprd04.prod.outlook.com (10.165.245.18) with Microsoft SMTP
 Server (TLS) id 15.1.497.12; Thu, 19 May 2016 17:37:43 +0000
Received: from AM4PR0401MB1844.eurprd04.prod.outlook.com ([10.165.245.19]) by
 AM4PR0401MB1844.eurprd04.prod.outlook.com ([10.165.245.19]) with mapi id
 15.01.0497.019; Thu, 19 May 2016 17:37:43 +0000
Thread-Topic: since/after not working properly
Thread-Index: AQHRseUkX+tAMLq9k0a7tYzRmYa1YZ/Ag5eAgAACGdg=
In-Reply-To: <CAPc5daXPWiY8=NtOcsjMcVN2MiwaaQUbVY6GBn2Eu31Q0fZrUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=here.com;
x-originating-ip: [25.164.243.132]
x-ms-office365-filtering-correlation-id: 5d28ecbd-4229-4a78-de0e-08d3800c484d
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1843;5:QwycjHzZKC4EZuwGCMDlG8vYA292VMM+WHLBRHLgmU/tsTFQuOH8EnWOz4uNdYGVq/cPEGj1Wz0BW9KxXiIgSdDHZrbEdyHhbYoc8KY0tkPHIwyqrsr6wYPs5ueoMOmTlS0VhHKKnBf/zeAKT6X/3g==;24:gmLQBV98sv4KUKiT4iq5FU6WueRLmIp7HLRIEUOkhjwsm2/RNwWHFNZaHXkhf7Rg57euk+/tqggC5NM+5kybjMvDpMnLvrsx0xk4dL+T9IY=;7:aP365dWK3cyGYld5GFFX3Rkl9ksDEw9syjnRGMfnsd2LaPFt9j4uyQ6f8n7vXIYVM0aE4JFdbzs+IxUDK7PmRpP7nuo1bT9j+MAw6TcnHJiPy66gLNiumWO+pSOEVl6UN/IoTZq3Zi6LUnTgPtZqTLP61hs0s3OJstQf+W04DFJPrk9uiAK6eopKKq1Ekfv1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1843;
x-microsoft-antispam-prvs: <AM4PR0401MB1843EB47AA0B33CD4A2A9D6B9B4A0@AM4PR0401MB1843.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6055026);SRVR:AM4PR0401MB1843;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1843;
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(377454003)(24454002)(74316001)(1220700001)(189998001)(5004730100002)(92566002)(76576001)(3280700002)(33656002)(4326007)(6116002)(586003)(86362001)(77096005)(9686002)(2950100001)(2906002)(2900100001)(102836003)(3480700004)(5008740100001)(3846002)(11100500001)(19580395003)(76176999)(3660700001)(15975445007)(81166006)(8936002)(8676002)(5003600100002)(66066001)(110136002)(5002640100001)(122556002)(19580405001)(106116001)(87936001)(50986999)(10400500002)(54356999)(7059030);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0401MB1843;H:AM4PR0401MB1844.eurprd04.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
X-OriginatorOrg: here.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2016 17:37:42.8678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d4034cd-7225-4f72-b853-91feaea64919
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1843
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295084>

Thanks Junio,

Do you think that code-maat has the wrong format documented on their gi=
thub page?

At: https://github.com/adamtornhill/code-maat

They suggest this:
git log --all --numstat --date=3Dshort --pretty=3Dformat:'--%h--%ad--%a=
N' --no-renames

Seems like the %ad should be %cd.

Regards,
Jeff H

________________________________________
=46rom: jch2355@gmail.com <jch2355@gmail.com> on behalf of Junio C Hama=
no <gitster@pobox.com>
Sent: Thursday, May 19, 2016 12:27:17 PM
To: Hawk, Jeff
Cc: Git Mailing List
Subject: Re: since/after not working properly

On Thu, May 19, 2016 at 8:41 AM, Jeff Hawk <jeff.hawk@here.com> wrote:
> [jeff:~/src/git] master* 2s =B1 git log --pretty=3Dformat:"%ad" --dat=
e=3Dshort

Perhaps try it with %cd instead of %ad?
