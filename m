Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6241C433E7
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 07:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B9C02071B
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 07:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wogra.net header.i=@wogra.net header.b="ThV73OpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgICHB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:01:29 -0400
Received: from www356.your-server.de ([78.46.154.174]:50846 "EHLO
        www356.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICHB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 03:01:26 -0400
X-Greylist: delayed 1343 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 03:01:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=wogra.net;
         s=default1905; h=MIME-Version:Content-Type:Subject:To:From:Message-ID:Date:
        Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References; bh=VkqKkI8M03ku/X8Z3oaPZRsVy6ufBXrqSEsu/MHA1dA=; b=Th
        V73OpY2WgvNDd/h9eibJif45T5MFMx75GjRRQuiFB6HT9j3uPOjiWhoWlsgtTn2lIxH3S42S8S+fW
        FwRLQUU7aDrf7jHoidzsQbfKd3dfezG3pG73pbQDLzBRbLBlxIBpcuK6k8y2Ix73xXMOB0M8Eju+u
        0H7ppLaCjEFMTAIuWTK+8ngCWfMoVA3UKpRwv96Yf7zbTkrpgZPbsmV1iIHReU3TCCyNM6k5vE5Tk
        roh/fD59LvDnN/sOpPY3xv6NsUYW2IqCcXnddOaLNPptu4BQ6eerenFpVnBX4rOe/YVUannqHZRHV
        m++7HU/uBKzW5Vmi2hgcdwSxRuHTFuaA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www356.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <wg@wogra.net>)
        id 1kDitf-0006D3-Uh
        for git@vger.kernel.org; Thu, 03 Sep 2020 08:39:00 +0200
Received: from [192.168.0.31] (helo=webmail02.your-server.de)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256)
        (Exim 4.92)
        (envelope-from <wg@wogra.net>)
        id 1kDitf-0007k4-SY
        for git@vger.kernel.org; Thu, 03 Sep 2020 08:38:59 +0200
Received: from p5489b4b7.dip0.t-ipconnect.de (p5489b4b7.dip0.t-ipconnect.de
 [84.137.180.183]) by webmail.your-server.de (Horde Framework) with HTTPS;
 Thu, 03 Sep 2020 08:38:59 +0200
Date:   Thu, 03 Sep 2020 08:38:59 +0200
Message-ID: <20200903083859.Horde.d_JTRsvdjC38RffOwMv54lJ@webmail.your-server.de>
From:   Wolfgang Graf <wg@wogra.net>
To:     git@vger.kernel.org
Subject: Sequent  repos ,, pull without checkout
User-Agent: Horde Application Framework 5
Content-Type: multipart/signed; boundary="=_80JAoFc4tT5TaL5nQHVfirV";
 protocol="application/pkcs7-signature"; micalg=sha-256
MIME-Version: 1.0
X-Authenticated-Sender: wg@wogra.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25918/Wed Sep  2 15:41:14 2020)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cryptographically signed message in MIME format.

--=_80JAoFc4tT5TaL5nQHVfirV
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Content-Disposition: inline


What did you do before the bug happened? (Steps to reproduce your issue)


We have three repos bt,bt2,bt3 where bt2 is a clone of bt and bt3 is a  
clone of bt2.
All remote destinations remain unchanged (pointing to the repo before).

Step 1: I'm creating a branch "b11" in bt, committing it.
Step 2: Going to bt2, doing git pull --all.
Step 3: Going to bt3, doing git pull --all.


What did you expect to happen? (Expected behavior)

The branch b11 is usable in bt3 also

What happened instead? (Actual behavior)

Either doing
Step 2a: If I'm doing a git checkout b11 in bt2 before Step 3
The branch b11 is also usable in bt3
This works

or doing
Step 2b: If I'm doing a fetch by name 'fetch origin master:master bt11:bt11"
This works

But if I'm only pushing through from bt to bt3 without doing checkout in bt2
the b11 is no more usable in bt3 when omitting step 2a or2b


What's different between what you expected and what actually happened?

The pull output did show me that there changes are tracked. But
only if a checkout in bt2 in the middle was made before the content
of the changes made within the origin change are really coming through to bt3



Anything else you want to add:

This might not be necessarily a bug. If this behavior is intended please
close it. It would be instead of that be nice if some guideline would exist
to deal with changes wired through a cascade of repositories in  
different branches.
As seen on the internet many people are asking for a solution for that.


Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.28.0.windows.1
cpu: x86_64
built from commit: 77982caf269b7ee713a76da2bcf260c34d3bf7a7
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 18362
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
-


Kind regards

Wolfgang

wg@wogra.net


-- 
**
I prefer signed and encrypted email messages.
If you are able to recieve encryted messages please let me know.
**

--=_80JAoFc4tT5TaL5nQHVfirV
Content-Type: application/pkcs7-signature; name=smime.p7s
Content-Description: S/MIME-Signatur
Content-Disposition: attachment; filename=smime.p7s
Content-Transfer-Encoding: base64

MIIMbQYJKoZIhvcNAQcCoIIMXjCCDFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggm7MIIE6zCCA9OgAwIBAgIUHp4DgUufWvRdhyS6Q521kvpnLNQwDQYJKoZIhvcNAQELBQAwTDEL
MAkGA1UEBhMCQ0gxEDAOBgNVBAoTB1dJU2VLZXkxKzApBgNVBAMTIldJU2VLZXkgQ2VydGlmeUlE
IFBlcnNvbmFsIEdCIENBIDIwHhcNMjAwNDEwMDgxMDIyWhcNMjEwNDExMDgyNjAwWjB4MUIwQAYD
VQQLDDlQZXJzb24ncyBJZGVudGl0eSBub3QgVmVyaWZpZWQgLSBXSVNlSUQgRnJlZSBDZXJ0aWZp
Y2F0ZXMxFTATBgNVBAMMDHdnQHdvZ3JhLm5ldDEbMBkGCSqGSIb3DQEJARYMd2dAd29ncmEubmV0
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArv1Sa+C8Gm0fzE4aHD4IUT3sLsjbjNoq
AKpch2pGH1zxQJdJGTzyPzpkNQVv/QUMNy/w8Jo+YQb8rTpb6Rjc0nSZmqcKTNzjCq6vChGcIhDx
NRxSqKAzCDXda4c0IZLpIMNqXQ1IUPJFukwi1n8mnt1YY2bj2pbI2xPkhA4cU5UYklYFHO5XCSZD
7ZVyrpiFzMEo7MP/BNJdCAQvr4OzsEQbd77UyxRU8ad3sHyPQJbRGQD7sgvxZr5WB1sLj8CzHSUx
KCAOrGnYJjvkSvSiP9rCTGPppFzSoxm/JQDD0oVg1gmo/3OPIg0McPO2GfVlsa3PxuKqMSRkOi3v
3OUtjwIDAQABo4IBlzCCAZMwDAYDVR0TAQH/BAIwADAfBgNVHSMEGDAWgBRgnKR/N147LwxxzY4A
SWg5BRStVTBwBggrBgEFBQcBAQRkMGIwOwYIKwYBBQUHMAKGL2h0dHA6Ly9wdWJsaWMud2lzZWtl
eS5jb20vY3J0L3djaWRwZXJzZ2JjYTIuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC53aXNl
a2V5LmNvbTAXBgNVHREEEDAOgQx3Z0B3b2dyYS5uZXQwRwYDVR0gBEAwPjA8BghghXQFDgcEATAw
MC4GCCsGAQUFBwIBFiJodHRwOi8vd3d3Lndpc2VrZXkuY29tL3JlcG9zaXRvcnkvMEAGA1UdHwQ5
MDcwNaAzoDGGL2h0dHA6Ly9wdWJsaWMud2lzZWtleS5jb20vY3JsL3djaWRwZXJzZ2JjYTIuY3Js
MB0GA1UdDgQWBBSeIYxdUjV0pHFxhLzVZeDiURFFOjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYB
BQUHAwQwDgYDVR0PAQH/BAQDAgWgMA0GCSqGSIb3DQEBCwUAA4IBAQCU6mV2aPcLg8B7mM5ZdEC7
cxrErBddkgl0IVRqUHjLh6L7D8ggkX66luIh3sSc/RJSypBmhJhBKlanyAPgzam7/XdpQFSufdJQ
sUFr6Yh31ngV5RVxH3ydHrosFqhrdkPOLGsXBbeb+YlfYRthTy4GxtWPV4eJ0IhDDuD093bni0pI
ryVG6XVDPOijz0mqlvNWbVJ3Hj7XaiorTsG6zc9OdO9URdd8a9oC6d9sBvHxVN1r0z2tOcFiElh7
j+HdIGc3ih3WMsCMCwsQGLhLRPNFBt10e4nZNIzrTu0PD5KUAtfo+DC9Tz6tc9IPT6dmppvOONSp
h2e/klqime2bTxQmMIIEyDCCA7CgAwIBAgITMwAAABlYd6BT3GiY9gAAAAAAGTANBgkqhkiG9w0B
AQsFADBtMQswCQYDVQQGEwJDSDEQMA4GA1UEChMHV0lTZUtleTEiMCAGA1UECxMZT0lTVEUgRm91
bmRhdGlvbiBFbmRvcnNlZDEoMCYGA1UEAxMfT0lTVEUgV0lTZUtleSBHbG9iYWwgUm9vdCBHQiBD
QTAeFw0xOTA1MTYxMDM1MzFaFw0zOTEyMDExNTEwMzFaMEwxCzAJBgNVBAYTAkNIMRAwDgYDVQQK
EwdXSVNlS2V5MSswKQYDVQQDEyJXSVNlS2V5IENlcnRpZnlJRCBQZXJzb25hbCBHQiBDQSAyMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxz4T1YH6AqtIjgG96sOemnxEc1cF5h5EZmIX
5+8OmxBFCSos1EartuZ2fN6A0p9dnDOR/713JwmNboYJTa1520FDaaqb4etC0wEB1QFadRf/YYHt
aBYB0vm5nh8g3/8yHzdhY05OPPDepQm9kbEioZfUH1STW8NlTrdPg88JyFGH1XZY22UnBhlBAqIb
3Sg94s0pgl49CRZayJX4siK/Oot2fhcfYS7gEZdhGo/RUXp434lOJ2AzxrFYMrifKhVO2gpOWFMH
MHbBI9xpAtZfqh6rY0QJxTNcZ3SBDqJUqFLK4O+jjeqq2IedtbjMcWebkFKMCUbyoOHGaxVWq3cO
5QIDAQABo4IBgDCCAXwwHQYDVR0OBBYEFGCcpH83XjsvDHHNjgBJaDkFFK1VMB8GA1UdIwQYMBaA
FDUPyDZjXuKj7Pk7ZhXOUVLjkZo9MDsGA1UdHwQ0MDIwMKAuoCyGKmh0dHA6Ly9wdWJsaWMud2lz
ZWtleS5jb20vY3JsL293Z3JnYmNhLmNybDBsBggrBgEFBQcBAQRgMF4wNgYIKwYBBQUHMAKGKmh0
dHA6Ly9wdWJsaWMud2lzZWtleS5jb20vY3J0L293Z3JnYmNhLmNydDAkBggrBgEFBQcwAYYYaHR0
cDovL29jc3Aud2lzZWtleS5jb20vMEIGA1UdIAQ7MDkwNwYEVR0gADAvMC0GCCsGAQUFBwIBFiFo
dHRwOi8vd3d3Lndpc2VrZXkuY29tL3JlcG9zaXRvcnkwJwYDVR0lBCAwHgYIKwYBBQUHAwQGCCsG
AQUFBwMCBggrBgEFBQcDCTASBgNVHRMBAf8ECDAGAQH/AgEAMA4GA1UdDwEB/wQEAwIBBjANBgkq
hkiG9w0BAQsFAAOCAQEAsj5vzm7U6/mwYPJN/TRY0emYSPbtpfRO0F7JNS0jxILczi+ZpzD9nXMH
Tjt4sxU5MB+TjxAztnKN92p7mG3rOfAWzqPYD0AthnTNxr8cYSb+d6J4WOWO+dksIZD2rW4355QK
bE2b63TDsqLE23xDcBxSXx+VxJPvjvyUThMFJRqjil5EkhDTFtmHTmYblBXsfWG7/6j6it2KqXxf
xbBpRukdMUh3WDfMGgVtxkWhZMtNhLQnKuVEFub4ws+NL4xCekAN9j0cYLR5wKTHa2Q3zxf26yZi
CBMVi3ULm0bo+98yM/kiPuKDapBBFrB8zCG4bTaPXPAt1H26akmHDu8GKDGCAnYwggJyAgEBMGQw
TDELMAkGA1UEBhMCQ0gxEDAOBgNVBAoTB1dJU2VLZXkxKzApBgNVBAMTIldJU2VLZXkgQ2VydGlm
eUlEIFBlcnNvbmFsIEdCIENBIDICFB6eA4FLn1r0XYckukOdtZL6ZyzUMA0GCWCGSAFlAwQCAQUA
oIHkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDkwMzA2Mzg1
OVowLwYJKoZIhvcNAQkEMSIEINnY9hHi9n7GPbHiUPYjcuWFGXSFeYoPuz0xPDwPCbEYMHkGCSqG
SIb3DQEJDzFsMGowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZI
hvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMC
AgEoMA0GCSqGSIb3DQEBAQUABIIBAJ5Ltb0I6L3A0/2jt0zO5RMOeeLlyNpB6JfvaalRQwL90TgP
hMufOnDI6VI+oybzWUINYirRcVuIDPOuwZFuPiF/QAh4XC7YgePvtunFBX/ijNDnm2xf09qpCt81
mJoy6lHXHZdaHZZe1+vs/ViJ96MJ5bgggtI7SVLcu9yxurzz+3fvv88Jf82RkU5vEX7bc3VKLUFt
hP0llMDCC0ZMhB611AhrsPMM2v9eh7PApCF8tXiEraNFoim5wzpmvsPHMWpDulY1dgM6Uyc6wbwG
II4BVCYqcoY4A7uOSmO1ypZo6a+w0IVci1mIrfoxvIUjlusmbEiKSMlYBQXC3qOzMVc=
--=_80JAoFc4tT5TaL5nQHVfirV--

