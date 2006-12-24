From: Alon Ziv <alonz@nolaviz.org>
Subject: Re: [PATCH 2/7] Switch git_mmap to use pread.
Date: Sun, 24 Dec 2006 21:30:01 +0200
Message-ID: <1166988601.31444.3.camel@bruno.nolaviz.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
 <20061224054547.GB8146@spearce.org>
 <Pine.LNX.4.63.0612241407250.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=sha1;
 protocol="application/x-pkcs7-signature"; boundary="=-ilKw391HSaSCe6tda+AM"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 20:45:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyZHm-0003Cj-17
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 20:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbWLXTpS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 14:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWLXTpS
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 14:45:18 -0500
Received: from mxout4.netvision.net.il ([194.90.9.27]:49238 "EHLO
	mxout4.netvision.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbWLXTpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 14:45:16 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Dec 2006 14:45:16 EST
Received: from mail.nolaviz.org ([194.90.198.244]) by mxout4.netvision.net.il
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTP id <0JAS0067WM6CXI10@mxout4.netvision.net.il> for
 git@vger.kernel.org; Sun, 24 Dec 2006 21:30:13 +0200 (IST)
Received: from [192.168.0.17] (bruno.nolaviz.org [192.168.0.17])
	(authenticated bits=0)	by mail.nolaviz.org (8.12.11.20060308/8.12.11)
 with ESMTP id kBOJEFua001540
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO); Sun,
 24 Dec 2006 21:14:16 +0200
In-reply-to: <Pine.LNX.4.63.0612241407250.19693@wbgn013.biozentrum.uni-wuerzburg.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Evolution 2.8.1
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on wonder.nolaviz.org
X-Spam-Status: No, score=-3.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35370>


--=-ilKw391HSaSCe6tda+AM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-12-24 at 14:09 +0100, Johannes Schindelin wrote:
> I don't think it matters much. The _only_ platform we really use NO_MMAP=20
> (other than for testing) is Windows, and AFAICT it does not have pread(),=
=20
> so it is emulated by lseek/read/lseek anyway.
>=20

Well, Win32 does have a pread()-like behavior in its generic ReadFile()
system call (using a curiously-named "lpOverlapped" parameter).  I would
have expected Cygwin to use it, but unfortunately from the CVS sources
it appears not to :(

	-az

--=-ilKw391HSaSCe6tda+AM
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEHw1bUWNdp/B9oSeG9KtSawwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA2MTExNTIwMTQ1MFoXDTA3MTExNTIwMTQ1
MFowUjEMMAoGA1UEBBMDWml2MQ0wCwYDVQQqEwRBbG9uMREwDwYDVQQDEwhBbG9uIFppdjEgMB4G
CSqGSIb3DQEJARYRYWxvbnpAbm9sYXZpei5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQC3C23WvGhRate09g2kwMKrzyx0Qmo9piF6HI+Iu7xKK+G4W7XN8mx+duffJlb5NZX3Bqx+
ntmMOU0rA1UiE/v49WYarcv9ql7UeUqplNXpznJgW0MoNW5TIOa75harixGlU6VCxgFVANioTn5m
IbvTYbETWr9H1FCGSHM8yCurYxpzrAQ6BsD99ocyeGs7dbBFW1odbfl8CxxJi0O84OBq+BeUtowg
YEFOIoSbKvsmLNdkquqdxG4bSdicx2U9mw87u1QeFhtPmb/b+A0MgpLTa3IqqV+ieH30kb9cFUqT
uIs46nOoifE2aScCak3FgCKinot5rVZveGGE91RkJRv1AgMBAAGjLjAsMBwGA1UdEQQVMBOBEWFs
b256QG5vbGF2aXoub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw0TO94UflUqj
t3uf/aD0JbRNXWbKvg/+dLgBB3kr/eV5JxNWIAfnKGeKsRMd6DiLIVHvg73RATtm15+vbXMht/lR
Wu2NyZ5F9+xY9pb5j6jRphqbM7MxUcP4BoYnBOTVeexUmx0IPrqvQtRVfw8qmlYP+OXgtjGO8QLb
M4rpaSgwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIB/DCCAfgCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEHw1bUWNdp/B9oSeG9Kt
SawwCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8X
DTA2MTIyNDE5Mjk1N1owIwYJKoZIhvcNAQkEMRYEFPvmaGWacW4Pdo0sZEVF0lftMYXRMA0GCSqG
SIb3DQEBAQUABIIBAAcx4vc2ZKBg6nZH5gP67dWjiA7wK32PqMzOIEqUgXPbO+tnnSr+dUQc36Br
jzwOtkdm8HHiOIeg+4tSQMOHKoArGrwXaKKx/9DNX+IY0S7X4F19/DMeY8IvwMNf5Sr4brGcBtBI
dIljJTiP1HWoSzDJIRcFWnWoZp9tgutc2w+mG1+//VM3irsyf+uKWGDNtMGArhslNU6Gy8nPjhjV
BYHizwa6qTs+4SrzJgdGcNVL+nDb1hTFEIP8wfN+B0boYuAoSRR0fVY/wqC9TDJ6dwYPvAwv+SR3
HzuLLYMoqbyo+XAQdl3/gBVNXp9jMbzCIc0oSRoEDG2cSZc7NKKqxiUAAAAAAAA=


--=-ilKw391HSaSCe6tda+AM--
