From: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Subject: RE: git bundle format
Date: Mon, 26 Nov 2012 20:50:11 +0000
Message-ID: <871B6C10EBEFE342A772D1159D13208537ABF676@umechphj.easf.csd.disa.mil>
References: <871B6C10EBEFE342A772D1159D13208537ABF5AB@umechphj.easf.csd.disa.mil>
 <CAMP44s03QiO15jODBD4JO_JF8tCOT9OJG1tb4+r+L4dgPUOLFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_014C_01CDCBED.6A6BA6A0"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:51:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td5e2-0007ZD-AZ
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab2KZUuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:50:54 -0500
Received: from edge-mech.mail.mil ([214.21.82.10]:28303 "EHLO
	edge-mech.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563Ab2KZUux (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:50:53 -0500
Received: from umechpjb.easf.csd.disa.mil (214.21.83.155) by
 umechpik.easf.csd.disa.mil (214.21.82.10) with Microsoft SMTP Server (TLS) id
 14.2.309.2; Mon, 26 Nov 2012 20:50:12 +0000
Received: from UMECHPHJ.easf.csd.disa.mil ([169.254.5.252]) by
 umechpjb.easf.csd.disa.mil ([214.21.83.155]) with mapi id 14.02.0309.003;
 Mon, 26 Nov 2012 20:50:12 +0000
Thread-Topic: git bundle format
Thread-Index: Ac3MC2nDG5IUvl+lTGGFopK+o2ENNwACAgWAAACihOA=
In-Reply-To: <CAMP44s03QiO15jODBD4JO_JF8tCOT9OJG1tb4+r+L4dgPUOLFg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [214.21.83.188]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210485>

------=_NextPart_000_014C_01CDCBED.6A6BA6A0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Felipe Contreras
> Sent: Monday, November 26, 2012 3:20 PM
> 
> On Mon, Nov 26, 2012 at 8:24 PM, Pyeron, Jason J CTR (US)
> <jason.j.pyeron.ctr@mail.mil> wrote:
> > I may need to be nudged in a better direction, but please try to
> understand my intentions.
> >
> > I am facing a situation where I would like to use git bundle but at
> the same time inspect the contents to prevent a spillage[1].
> >
<snip/>
> >
> > Am I barking up the right tree?
> 
> Have you tried 'git fast-export'? The output is definitely not human
> inspectable, but should be relatively easy to parse to generate such a
> format. And instead of 'git bundle unbundle' you could use 'git
> fast-import'. or simply do the conversion in your script.

No. But I am going to read up on it today. It clearly says "You can use it as a human-readable bundle replacement"[4]. My initial question is does it ever use deltas? The repositories I just tested it on only seem to output full blobs (which is really nice from this use case point of view).

-Jason


4: http://www.kernel.org/pub/software/scm/git/docs/git-fast-export.html

------=_NextPart_000_014C_01CDCBED.6A6BA6A0
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
GDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AOYpItQUJtGYGlJexYSDc37BYLOz0JS+/RyUVb/2hCybycB0c+/MwpnymcltyhTTdP++EPL3Lb/L
uwaj7phQQWUB4VcstsvkyhysflI0DrGOByY+MjWvo2EKxeUIthJ5jFTBeunxUB9dgzpnMLMp2x06
TDkhUNgYLI0Gde5jcnhorWKcdaSUBtMyaxKvBgcpvhOgwKfwJU+3/h+3V+AYEo0hahW5WlT7d2XY
TD/1ujzAN+EGfsK+niOMKNGa18ZnONdzyb0HHYVv1ZUKmtzaOk4o8KXrCd/l2wvNR6+KzbtvlEDj
WZxQn8kOqXECudzpaYA6iTtFBSIYBYS1EvA8wIECAwEAAaOCAhwwggIYMA4GA1UdDwEB/wQEAwIB
hjAfBgNVHSMEGDAWgBRJdLsMXrp6/gJU73ugxpXGCYBwljAdBgNVHQ4EFgQUNWFmKAm8ViVbi8y/
gV5hLDA50yEwEgYDVR0TAQH/BAgwBgEB/wIBADAMBgNVHSQEBTADgAEAMGYGA1UdIARfMF0wCwYJ
YIZIAWUCAQsFMAsGCWCGSAFlAgELCTALBglghkgBZQIBCxEwCwYJYIZIAWUCAQsSMAsGCWCGSAFl
AgELEzAMBgpghkgBZQMCAQMaMAwGCmCGSAFlAwIBAxswNwYDVR0fBDAwLjAsoCqgKIYmaHR0cDov
L2NybC5kaXNhLm1pbC9jcmwvRE9EUk9PVENBMi5jcmwwggEBBggrBgEFBQcBAQSB9DCB8TA6Bggr
BgEFBQcwAoYuaHR0cDovL2NybC5kaXNhLm1pbC9pc3N1ZWR0by9ET0RST09UQ0EyX0lULnA3YzAg
BggrBgEFBQcwAYYUaHR0cDovL29jc3AuZGlzYS5taWwwgZAGCCsGAQUFBzAChoGDbGRhcDovL2Ny
bC5nZHMuZGlzYS5taWwvY24lM2REb0QlMjBSb290JTIwQ0ElMjAyJTJjb3UlM2RQS0klMmNvdSUz
ZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2MlM2RVUz9jcm9zc0NlcnRpZmljYXRlUGFp
cjtiaW5hcnkwDQYJKoZIhvcNAQEFBQADggEBAAqIVhylVyZaYst10N2GxVLiL/O8EWQ/jC8+EfyY
YEDygA0ogppo/uBISyfTOgp7lfYDDIEUkUI6YGziK1Mt7N8RrvVUF/AB+ZcHp5urC9usl4kJxu/5
BzQWAKh+EVOefC+hOKKZeTk0QW59uFgwVoie5KpkRdmgRGI6t+Ux05GA8RsQsmdw1VurWbRaSBZC
xAJM2mxoylAdMb43mcfPU8xCKVbDnRfKA+cQWvE5PBzM+xuXCibzMd/gq1wknZ7eOH0CUWdG+ZNw
he0KVcL0wWhanwjJHXubdtxU7zmMGOUMRO73BrIf9cvmDr3Uof/U+ZEHIlJ5t8D97LL4hfRE+1wx
ggMyMIIDLgIBATBkMF0xCzAJBgNVBAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAK
BgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbDjAJ
BgUrDgMCGgUAoIIBozAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0x
MjExMjYyMDQ4MDFaMCMGCSqGSIb3DQEJBDEWBBScXuDa1COC+LsFrI023ylepmYSOjBYBgkqhkiG
9w0BCQ8xSzBJMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAHBgUrDgMCBzANBggqhkiG9w0D
AgIBKDAHBgUrDgMCGjAKBggqhkiG9w0CBTBzBgkrBgEEAYI3EAQxZjBkMF0xCzAJBgNVBAYTAlVT
MRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgw
FgYDVQQDEw9ET0QgRU1BSUwgQ0EtMzACAyLbETB1BgsqhkiG9w0BCRACCzFmoGQwXTELMAkGA1UE
BhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQ
S0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0zMAIDItsRMA0GCSqGSIb3DQEBAQUABIIBAKR1Al65
egUQJVauThZW/dU0R7/NpwnQTwZLus9TP1j+vXASme4NRC/PP0eCHab2QUW/zGZ1W/Ydf5JOqFcV
LVu/ffJRLdxd4ULtprCMT0Y0FfA+0rgNu9fA5vA0dMvFFAtAchyahE3gikRQmjJDf1P/EikWNkna
aZMvoN5bh/ab+JaNtiExekhkxHFfP/f82jUREdPcjDDVqxdoFIopm42B9GWVs9j5L14LTWyPzmE/
o263SiEH6rrltzCe5Qa7zWNwQKu31i339JoKz2dYDjbkbn16rrI8zmHldkIm9BMgCykQ7DgvIYly
hPrRhD7qFcleCKw4eyytsdUBoEVZXWcAAAAAAAA=

------=_NextPart_000_014C_01CDCBED.6A6BA6A0--
