From: "Rice, James M CIV NSWCDD, K73" <james.rice2@navy.mil>
Subject: RE: Tracking changes in git with a change number....
Date: Tue, 12 Jul 2011 17:28:15 -0400
Message-ID: <C785F567A08DDE449FD4590C91E6AD13D2046E@naeamillez01v.nadsusea.nads.navy.mil>
References: <20110712055008.GC11644@sigill.intra.peff.net> <2077407.34684.1310475245616.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_00BA_01CC40B9.14EDD4C0"
Cc: <git@vger.kernel.org>
To: "Stephen Bash" <bash@genarts.com>, "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 12 23:28:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgkVJ-0003r7-EV
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 23:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab1GLV2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 17:28:21 -0400
Received: from naeanrfkax06o.nmci.navy.mil ([138.162.5.146]:47110 "EHLO
	naeanrfkax06o.nmci.navy.mil" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754984Ab1GLV2U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2011 17:28:20 -0400
X-AuditID: 8aa20591-b7b5aae000006af7-ea-4e1cbc71046e
Received: from naeanrfkeg03v.nadsusea.nads.navy.mil (gate5-norfolk.nmci.navy.mil [138.162.0.45])
	by  (Symantec Mail Security) with SMTP id 64.24.27383.17CBC1E4; Tue, 12 Jul 2011 21:28:17 +0000 (GMT)
Received: from naeanrfkeb07v.nadsusea.nads.navy.mil ([10.16.20.110]) by naeanrfkeg03v.nadsusea.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 12 Jul 2011 17:28:17 -0400
Received: from naeanrfkeb01v.nadsusea.nads.navy.mil ([10.16.20.105]) by naeanrfkeb07v.nadsusea.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 12 Jul 2011 17:28:16 -0400
Received: from naeamillez01v.nadsusea.nads.navy.mil ([10.16.20.30]) by naeanrfkeb01v.nadsusea.nads.navy.mil with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 12 Jul 2011 17:28:16 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <2077407.34684.1310475245616.JavaMail.root@mail.hq.genarts.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Tracking changes in git with a change number....
Thread-Index: AcxAks1YdZLa8LDxSj6n9URgh7vsSgAR4Bxg
X-OriginalArrivalTime: 12 Jul 2011 21:28:16.0065 (UTC) FILETIME=[9C904310:01CC40DA]
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176982>

This is a multi-part message in MIME format.

------=_NextPart_000_00BA_01CC40B9.14EDD4C0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit



> -----Original Message-----
> From: Stephen Bash [mailto:bash@genarts.com]
> Sent: Tuesday, July 12, 2011 8:54
> To: Jeff King
> Cc: git@vger.kernel.org; Rice, James M CIV NSWCDD, K73
> Subject: Re: Tracking changes in git with a change number....
> 
> ----- Original Message -----
> > From: "Jeff King" <peff@peff.net>
> > Sent: Tuesday, July 12, 2011 1:50:08 AM
> > Subject: Re: Tracking changes in git with a change number....
> >
> > > Restating the problem. I wish for our developers to be able to
> > > reference multiple commits with one number, and then find those
> > > commits via that number. And I don't mind scripting to accomplish
> > > this. I know, that CR # can be put in the commit message, then I
> can
> > > grep and parse the log, that is the hard way.
> >
> > There are two ways to approach this: tell the CM tool about some git
> > commits, or tell some git commits about the CR number.
> >
> > ... snip ...
> >
> > If you want to do the reverse and tell git about CR numbers, then I
> > don't think you have much option besides putting them in the commit
> > message. Which means you'll need to grep to get them out. You can do
> > something like:
> >
> > $ git log --grep='CR#' --pretty=format: --name-only
> 
> To add to what Jeff said, in our office we automate the 'grep' step
> using a git post-receive hook in our central/canonical repo.  We happen
> to be using Trac for issue tracking, so the post-receive hook
> enumerates the new commit ids, calls Trac to parse the commit messages,
> and Trac then updates the appropriate tickets.  But I've seen the same
> done with many different issue trackers.
> 
> Thanks,
> Stephen

Unfortunately our issue tracker is used by multiple organizations, is in windows and would be a pain to integrate in that manner, if it can be done at all.

That being said, Jeff's answer was what I was looking for!  Thanks to all of you for your help!

Thanks,
James.

------=_NextPart_000_00BA_01CC40B9.14EDD4C0
Content-Type: application/x-pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

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
dsHK0Daw4NKeilKy8gLyn5yhwB5AAtqWJnQwqbvR+T8ABcvKXEIS8YOI4rYvS38fHaUSmdCtb5zV
kkUHW2QI3XvS21uq1XXqZZT87ePkiK7LX9s+2m0GSnlj9M7vPdOXx5Jg/Umo+Kk3Ssyu/BTE7C2u
ugBv1O7J+y4TuaXNFhDSkLBqYhm5CGrPayJL2vjSLxlO+lS7yrVv+VQvyVWdqCSX4F4T/a8xgIiz
HDQ7PXkeMIIEcDCCA1igAwIBAgIDAIVdMA0GCSqGSIb3DQEBBQUAMF0xCzAJBgNVBAYTAlVTMRgw
FgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMDUEtJMRgwFgYD
VQQDEw9ET0QgRU1BSUwgQ0EtMjAwHhcNMDgwODI2MDAwMDAwWhcNMTEwODI1MjM1OTU5WjBzMQsw
CQYDVQQGEwJVUzEYMBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNV
BAsTA1BLSTEMMAoGA1UECxMDVVNOMSAwHgYDVQQDExdSSUNFLkpBTUVTLk0uMTIzMDQ2MTY4MjCB
nzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAvQb9NfvzuH9f1YFCqpbriJfjFXP64ZbXeCYgRM/V
qCcyKa4w6PUFUq3iq/f5YGDFFOHPmFOHYWQWlDh5XEdQ5HuozH8EYfra0BO5THzYAageNzxWvu1g
rv3u2TPSMogcMKewaCHidP62Y2fXQ45ZNByMeKylxeBOQUH0dF6yCYkCAwEAAaOCAaUwggGhMB8G
A1UdIwQYMBaAFLK/bgBtuUBJL2AK9HjVeYQlqTG6MD8GA1UdHwQ4MDYwNKAyoDCGLmh0dHA6Ly9j
cmwuZGlzYS5taWwvZ2V0Y3JsP0RPRCUyMEVNQUlMJTIwQ0EtMjAwDgYDVR0PAQH/BAQDAgbAMBYG
A1UdIAQPMA0wCwYJYIZIAWUCAQsJMB0GA1UdDgQWBBQYaBgpSaSUBisfyV7QcvxpKur0AzBtBggr
BgEFBQcBAQRhMF8wOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcmwuZGlzYS5taWwvZ2V0c2lnbj9ET0Ql
MjBFTUFJTCUyMENBLTIwMCAGCCsGAQUFBzABhhRodHRwOi8vb2NzcC5kaXNhLm1pbDA/BgNVHREE
ODA2gRRqYW1lcy5yaWNlMkBuYXZ5Lm1pbKAeBgorBgEEAYI3FAIDoBAMDjEyMzA0NjE2ODJAbWls
MBsGA1UdCQQUMBIwEAYIKwYBBQUHCQQxBBMCVVMwKQYDVR0lBCIwIAYKKwYBBAGCNxQCAgYIKwYB
BQUHAwIGCCsGAQUFBwMEMA0GCSqGSIb3DQEBBQUAA4IBAQB9/jZBLRJmg/JMjywlQKQJaoGls9Ji
BO+LOR34rWAKo0NZaIQmVaI3F/kKaoK80j2qem+cI5yHF8Z0hIJo1UoBNmyKvYLuyt4ghrxo1fB9
JDU0WBoRkbxbXdGM190ojHDK5IFhPORzWiK2FpHFTG7jOxlTA6FNKIiCrepvZIFSitbCogidX4A2
G0HmsJBAPpFsNCng3y2w2McLpE4c7jL7g9Sog5kcL29ozKqD4riQ7zMw7jGlcHWpErYno26zzeVT
5grlxbshHOmDcF+xGgJ0JziMfHaa6VgVpPwULXmL4WV9wR2cgd7CB3sI5+6/VnmR/YRA1zsRqW0s
uKZip2/AMIIFRjCCBC6gAwIBAgIBKzANBgkqhkiG9w0BAQUFADBbMQswCQYDVQQGEwJVUzEYMBYG
A1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEWMBQGA1UE
AxMNRG9EIFJvb3QgQ0EgMjAeFw0wODA0MjMyMTA4NTZaFw0xNDA0MjMyMDA4NTZaMF0xCzAJBgNV
BAYTAlVTMRgwFgYDVQQKEw9VLlMuIEdvdmVybm1lbnQxDDAKBgNVBAsTA0RvRDEMMAoGA1UECxMD
UEtJMRgwFgYDVQQDEw9ET0QgRU1BSUwgQ0EtMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQC3GpCJHIAL26G6Jewuo/YtAYhV5hbRT53JU5ymKfmIQfHdnTImnwczIbZHQQIgPKXSSsu7
y4FPYUHQ9sjuaKbG93h6tCxQHf6LMrZaMnmRMFHwIUqYqRLTLnSZT+b61bgniPjJIaDFs323Vqp7
l0OcIDROgYk6jjwWEoy7qLOMYNd5vO/hK7R8kQQnjnNOSDQC5fuutM6DndiV5BT4M982rE746VI5
11bkMsJNbkg3b/XlRjcSYzJJwk+L/jSZyOz45t+uhqB/PUggY6RJLUE+/p1CfIFG5h2S43TSAghU
iGArZTGpc4D6l/hqNtSDK2TwzWFh4cJYlLbK4jGy2RphAgMBAAGjggIRMIICDTAOBgNVHQ8BAf8E
BAMCAYYwHwYDVR0jBBgwFoAUSXS7DF66ev4CVO97oMaVxgmAcJYwHQYDVR0OBBYEFLK/bgBtuUBJ
L2AK9HjVeYQlqTG6MAwGA1UdJAQFMAOAAQAwEgYDVR0TAQH/BAgwBgEB/wIBADBXBgNVHSAEUDBO
MAsGCWCGSAFlAgELBTALBglghkgBZQIBCwkwCwYJYIZIAWUCAQsKMAsGCWCGSAFlAgELEjALBglg
hkgBZQIBCxMwCwYJYIZIAWUCAQsUMD8GA1UdHwQ4MDYwNKAyoDCGLmh0dHA6Ly9jcmwuZGlzYS5t
aWwvZ2V0Y3JsP0RvRCUyMFJvb3QlMjBDQSUyMDIwgf4GCCsGAQUFBwEBBIHxMIHuMD8GCCsGAQUF
BzAChjNodHRwOi8vY3JsLmRpc2EubWlsL2dldElzc3VlZFRvP0RvRCUyMFJvb3QlMjBDQSUyMDIw
IAYIKwYBBQUHMAGGFGh0dHA6Ly9vY3NwLmRpc2EubWlsMIGIBggrBgEFBQcwAoZ8bGRhcDovL2Ny
bC5nZHMuZGlzYS5taWwvY24lM2REb0QlMjBSb290JTIwQ0ElMjAyJTJjb3UlM2RQS0klMmNvdSUz
ZERvRCUyY28lM2RVLlMuJTIwR292ZXJubWVudCUyY2MlM2RVUz9jQUNlcnRpZmljYXRlO2JpbmFy
eTANBgkqhkiG9w0BAQUFAAOCAQEAbQVlP8HZ1fGyBtYIzY7li6DmRgJ9paZkmy8TErQBmKH1jDqB
SwUjpu3N67AFK0QxTgTXbUMd2ilRq/nBr5Z04WgeSE9OXLzKsCRDouxAKxEC2wgjXJW8NXY10GKx
dvLZOf/Atdio266hafql/l30PgW1DIX3zD7QwrBEWwnD5oNczi5LdSip+O1YLJZLnSYGvXaGjTck
JFQdz8wXUQjwhpJ8R7+37fs4XRRuLupT06rhrvsmkPT69O9Za3VvLyhZmx8evted3q5VXSsUnxaa
C3CG85FC0yNoovK/NjevFLqAb2FHMr6HTHd5bqhZzMQXFDkjva4hnP25uvhz3OCnGjGCArEwggKt
AgEBMGQwXTELMAkGA1UEBhMCVVMxGDAWBgNVBAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMD
RG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMTD0RPRCBFTUFJTCBDQS0yMAIDAIVdMAkGBSsOAwIa
BQCgggGjMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTExMDcxMjIx
MjgxNVowIwYJKoZIhvcNAQkEMRYEFFQ4b+6+GtoPl23keMNmHjhB1xE4MFgGCSqGSIb3DQEJDzFL
MEkwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMAcG
BSsOAwIaMAoGCCqGSIb3DQIFMHMGCSsGAQQBgjcQBDFmMGQwXTELMAkGA1UEBhMCVVMxGDAWBgNV
BAoTD1UuUy4gR292ZXJubWVudDEMMAoGA1UECxMDRG9EMQwwCgYDVQQLEwNQS0kxGDAWBgNVBAMT
D0RPRCBFTUFJTCBDQS0yMAIDAIVVMHUGCyqGSIb3DQEJEAILMWagZDBdMQswCQYDVQQGEwJVUzEY
MBYGA1UEChMPVS5TLiBHb3Zlcm5tZW50MQwwCgYDVQQLEwNEb0QxDDAKBgNVBAsTA1BLSTEYMBYG
A1UEAxMPRE9EIEVNQUlMIENBLTIwAgMAhVUwDQYJKoZIhvcNAQEBBQAEgYA0EWFtAgmgM5bF4Vkb
120tBB9wEZA8xzx9etmJb65v9bqQZKzwO6YHG0fXZRvcG2gHFpFcYi/oeVL9m6BuT+ptAdkmLie3
rzh4ISyHrPYdd9F79Sl1B0KjxTGG159dJjhkV45oykh2DP6QQPw0ONGh59yMaWMovpRRN3EFNP0L
OgAAAAAAAA==

------=_NextPart_000_00BA_01CC40B9.14EDD4C0--
