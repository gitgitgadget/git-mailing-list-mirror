From: Kevin Ballard <kevin@sb.org>
Subject: git fetch+rebase on a local tracking branch
Date: Thu, 17 Jan 2008 12:24:58 -0500
Message-ID: <6C0A045B-658F-4ECE-93DB-A61F77AAA1F8@sb.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-3--1054800308; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 17 18:25:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFYUf-0005gq-LJ
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbYAQRZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbYAQRZD
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:25:03 -0500
Received: from mailbigip.dreamhost.com ([208.97.132.5]:49521 "EHLO
	randymail-a7.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751427AbYAQRZA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 12:25:00 -0500
Received: from KBLAPTOP.WIFI.WPI.EDU (KBLAPTOP.WIFI.WPI.EDU [130.215.168.244])
	by randymail-a7.g.dreamhost.com (Postfix) with ESMTP id 28AFBB751D
	for <git@vger.kernel.org>; Thu, 17 Jan 2008 09:24:59 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70877>


--Apple-Mail-3--1054800308
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

When I'm working on a local tracking branch, is there an easier way to  
do `git fetch && git rebase origin/branch`? I could imagine either a  
config value like branch.master.rebase = remotes/origin/master  
(although it would be nice to avoid duplicating the remote name, since  
we already have branch.master.remote), or perhaps a --rebase command  
to git pull such that it simply performs a rebase instead of a merge.

Is there some reason there isn't already a solution like this, or am I  
simply missing something?

One of the reasons I really want a hands-off solution to rebasing is  
I'm somewhat paranoid of accidentally rebasing from origin/master when  
I'm sitting on another branch. If my branch knows where it's supposed  
to rebase from in normal usage, that solves the problem.

I'd like to mention that the largest conceptual hurdle in migrating  
from another VCS is that pull and push are not opposite commands, and  
that when I'm, say, using a clone of the git repository, unless I'm an  
integrator I should always rebase instead of merge. Also, fetch+rebase  
is so common I'm surprised it doesn't already have a single command  
shortcut.

Please note that I'm not asking for someone else to implement this,  
I'm simply asking for feedback so, if I choose to go forward on this  
myself, I don't end up implementing the wrong solution.

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com



--Apple-Mail-3--1054800308
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEDsG8BKvlrEW0HUBIxWIgjUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MDQyMzIxMjM0OVoXDTA4MDQyMjIxMjM0
OVowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAN/koURrN2ndrAiuAuHHrdFz+hLGQ7ZsXloGnObjALGOFY3Kmk2FCwAJPIha5GfM
YFmZIoqxs+DbOWOn6KZ9hcQ5wf4EOgokayrEs3G72T+G8ZE4aXrw0CWJzKLjaIQeDZNZoHA44jlZ
dG70wtZske898IoPz6YHpkcXiulllATfd8Pa7EgjPri5hKFiRXKI52OsOQTX6cNMMZJUIm8DvfQ5
jmDyAtywNZGSGeUAMbWnpuLq7H18zpye2Q1hr+p4kucazMb+i7OHXPvX7yx2jMjhN5jw/gYkuzQQ
JExp1fJyAZQ/av/ZgaxWchhhi4ziFXIlX3B09DTlOQlF53P3fi0CAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAw/qc6zq+0Qy2
XaodDlt2L6Vq1DzaVWjV152BFjidmsyhyCkCuyYdAcDp17opIfrNCBbOX5DdY6cpFpnSCxCZeIEB
PDc3TaaFPtzr8qrpcNDohRSdt+qFLUeMHzlidAiAjvjI3tPKv3JLTakWdQR/XPHsg4mWoaVQU2hM
HOQBw8EwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
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
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEDsG8BKvlrEW0HUBIxWI
gjUwCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMDgwMTE3MTcyNDU5WjAjBgkqhkiG9w0BCQQxFgQUzd3OeUC509EO2GHFNqlayf2F3u0wgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhA7BvASr5axFtB1ASMViII1MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA7BvASr5axFtB1ASMViII1MA0GCSqGSIb3DQEBAQUA
BIIBAL1l3NgPm8fifaaOKljAM+2sIzsC2JwxcJujpT2FXmvX0ow6DqHWzt7FQCfclQ16cgafLLFX
gO23CHEsV701ORVYf/JP0w26mtcpu0UY7bon17Pgi06KNGOzTEN6XXXG3GO7qewy69Y88VIhXZSK
2cKF0iPeEcmV+HOe5Rg/HCl2Fe0wx3J2k77DUn6X/lMZUUC466l3kuJcvtcUoa6HGo1hf1bSHEUL
6O8LahIuiGlZmhSktJglqkxRmaWr0WCJIvz/jiUH4X0J43MuV98kaOo3NKkn/3JoqOTNbRRdUDqi
6M0+kX6fXpQuctyTctmF/gJAhDu8DQYeARAiIpy5ya0AAAAAAAA=

--Apple-Mail-3--1054800308--
