From: Glenn Rempe <glenn@rempe.us>
Subject: git-daemon fatal error running with monit
Date: Sun, 18 Nov 2007 17:09:45 -0800
Message-ID: <965F6462-8FD1-4884-9AF9-DC75927637C2@rempe.us>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: multipart/signed; boundary=Apple-Mail-5-231537403; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 02:10:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itv9N-0005e4-AP
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 02:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbXKSBJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 20:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXKSBJu
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 20:09:50 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:34059 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbXKSBJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 20:09:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1286976rvb
        for <git@vger.kernel.org>; Sun, 18 Nov 2007 17:09:48 -0800 (PST)
Received: by 10.140.199.19 with SMTP id w19mr425024rvf.1195434588667;
        Sun, 18 Nov 2007 17:09:48 -0800 (PST)
Received: from ?10.66.66.23? ( [64.142.55.10])
        by mx.google.com with ESMTPS id f42sm6956095rvb.2007.11.18.17.09.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2007 17:09:48 -0800 (PST)
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65397>


--Apple-Mail-5-231537403
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

hello git masters.

I am having a problem running git-daemon from within 'monit' (http://www.tildeslash.com/monit/index.php 
).  I can run git-daemon every time without error if I manually issue  
the command to run it in a terminal.  However, if I have monit execute  
the exact same command I get an error from git-daemon in syslog and  
the client request fails every time.  Running on Ubuntu 7.04.  Can you  
take a look?

Unfortunately the error info in the logs is minimal.  All details of  
my config and the error can be found here in this pastie:  http://git.pastebin.com/m20fab0a9

Thanks in advance.
--Apple-Mail-5-231537403
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGHTCCAtYw
ggI/oAMCAQICEHK8AVT+9qlBEcV0Yul7SwMwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA3MTEwODIxMzExMFoXDTA4MTEwNzIxMzEx
MFowQDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEdMBsGCSqGSIb3DQEJARYOZ2xl
bm5AcmVtcGUudXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7gHa30/P6rHOlbCtY
DPX35pdWuESvChD37sVh7JbG7N4bRIera66g8U4zXZcHW+OjDNTViBPRVjScDHVGAHlZiTd1hqOT
AOlM9fH6ypUetppS6x9SyC2H+aDrlYDx5oakGLNn1IbcX3cCfGTuKSlGgnr5m3xP9EgH0eWAfFY+
zhK5yh2ymUXh1ycpm4VA+qMmZp0+Udrf4c5hrGrRsZZSkN2kXboxNTSn6F73HF4VppPAKrh9O0+y
0p5Rx/UFswXnwb86uyPJEqJyA6BGW76H06WTJqUPVnG4Xqtzj4z2JaDZ42flDAzU/O3F5+C3OKIf
91wjE15ff+vfAFIWpXMfAgMBAAGjKzApMBkGA1UdEQQSMBCBDmdsZW5uQHJlbXBlLnVzMAwGA1Ud
EwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAWSsXEiKmnmsDHJWAphj69+Ks6PxVm1Jn70hm4JQI
JCN9EAk3VG6w/7b0XJXlIxoLdt6iz9OBYhWXbzTAfbFHbBZhABfjUPizlVnwkkToqgY1hMsyWvMC
Yg8/5k5XRBFrp6tbkuRT+SKMYPMS1AMicEUcKEofXaxyhk4dfcIUU4EwggM/MIICqKADAgECAgEN
MA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMGA1UECBMMV2VzdGVybiBDYXBlMRIw
EAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9D
ZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20w
HhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMc
VGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZy
ZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZ
Wh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuv
PAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBly
YLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRw
Oi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMC
AQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9reFh
YsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo05RAaWzVN
d+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBiMQswCQYDVQQGEwJaQTElMCMGA1UE
ChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFs
IEZyZWVtYWlsIElzc3VpbmcgQ0ECEHK8AVT+9qlBEcV0Yul7SwMwCQYFKw4DAhoFAKCCAW8wGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMDcxMTE5MDEwOTQ2WjAjBgkq
hkiG9w0BCQQxFgQUlqZLRsaBZmrJNq2qFRTCW1vRHKowgYUGCSsGAQQBgjcQBDF4MHYwYjELMAkG
A1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhByvAFU/vapQRHFdGLpe0sDMIGH
BgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0
aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5n
IENBAhByvAFU/vapQRHFdGLpe0sDMA0GCSqGSIb3DQEBAQUABIIBAEJWlVusMYwk/Ug1gvmqii54
ZPkMCfqtPHX9dXnl4LytVKhDZOV09fMtCVLVWbACWe8wyJb5GkloXPRs7xGSTreSvyaZL1OPkVeU
snQdJNsAF+o64QyKDUZwq+9ADdfVWZuIp0pW16Los0sTl27qSyUsG2SEr85UREvpW1VUDV8F2Q8V
SxMSk8z84tr0vhjQp+GVzLF2CuOPCXKrkWGpYgP8pPoeESon+41NynvBUo4DQOOD0IGplfWrM10D
Rr48oH1SmRK+CetH0VmssorzuKiDF9LcmXhV/U3qwtCwuZAq7tVOWORs6WNxCDprVKy/qF3ey2jm
yL42bnfFVFDw88IAAAAAAAA=

--Apple-Mail-5-231537403--
