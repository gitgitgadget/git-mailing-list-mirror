Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46AF91F855
	for <e@80x24.org>; Wed,  3 Aug 2016 09:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757405AbcHCJXv (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 05:23:51 -0400
Received: from mail-out7.apple.com ([17.151.62.29]:46574 "EHLO
	mail-in7.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757400AbcHCJXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 05:23:48 -0400
Received: from relay5.apple.com (relay5.apple.com [17.128.113.88])
	by mail-in7.apple.com (Apple Secure Mail Relay) with SMTP id A9.EA.17422.CDE91A75; Wed,  3 Aug 2016 00:35:56 -0700 (PDT)
X-AuditID: 11973e16-f793f6d00000440e-59-57a19edc4682
Received: from [17.153.45.195] (Unknown_Domain [17.153.45.195])
	(using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by relay5.apple.com (Apple SCV relay) with SMTP id 05.49.30701.CDE91A75; Wed,  3 Aug 2016 00:35:56 -0700 (PDT)
From:	Jeremy Huddleston Sequoia <jeremyhu@macports.org>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2ED1717F-FDC6-4573-9335-EBBA236FE941";
 protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3207.2\))
Subject: 2.9.2 test failures on macOS
Message-Id: <C4207508-629B-41DF-8E89-CDD1989BCF2E@macports.org>
Date:	Wed, 3 Aug 2016 00:35:55 -0700
To:	git@vger.kernel.org
X-Mailer: Apple Mail (2.3207.2)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsUi2FAYoXtn3sJwg65N4hZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mq4cLWTsWCrdcWkab4NjF/Muxg5OSQETCTOtbxkgrDFJC7cW8/W
	xcjFISSwl1Hiz8xFLDBFUzftAisSEpjKJNG0FCzOJmAu8eHBCVaQBmaBKYwSk9fdYgdJ8AoY
	Stye3s3YxcjBISygKtHUJQ8Rtpe4/e8xI4jNIqAi8e/ZJ7ByEQFxibfHZ7JD7JKXmNQ6hwVk
	poTAT1aJCz+mME9g5JuFbMcsJDtAbGYBbYllC18zzwLaxyygIzF5IVTYVOLJ2+1sELa1xM85
	j6DiihJTuh+yL2BkX8UolJuYmaObmWeul1hQkJOql5yfu4kRFKrT7cR2MD5cZXWIUYCDUYmH
	1+L8gnAh1sSy4srcQ4zSHCxK4rz+p4BCAumJJanZqakFqUXxRaU5qcWHGJk4OKUaGFN1Ntzt
	1Jc5LF9Y8OnLysNbf7M0aZx0mGZd/WzRseIsdVaOzwdnBPrfXhUU6v3z6TkRZ6W5p0zTNgiW
	v3X+G3lJzHPzLx2Zy9o8aYfWmZ+03S9iFGRecl/71CzOrYGCJsUNjFFv/izR9nRnCnlrVLb4
	l6vjiW+XK2/dlJ5ddKhL9dyVKXO2PVdiKc5INNRiLipOBACx7iaFNgIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsUiOFP3sO6deQvDDSbME7HoutLN5MDo8XmT
	XABjFJdNSmpOZllqkb5dAlfGhaudjAVbrSsmTfNtYPxi3sXIySEhYCIxddMuJghbTOLCvfVs
	ILaQwFQmiaalLCA2m4C5xIcHJ1i7GLk4mAWmMEpMXneLHSTBK2AocXt6N2MXIweHsICqRFOX
	PETYXuL2v8eMIDaLgIrEv2efwMpFBMQl3h6fyQ6xS15iUusclgmM3LOQjZ2FZCyIzSygLbFs
	4WvmWUArmAV0JCYvhAqbSjx5u50NwraW+DnnEVRcUWJK90P2BYzsqxgFilJzEitN9RILCnJS
	9ZLzczcxgkKroTBiB+P/ZVaHGAU4GJV4eC3OLwgXYk0sK67MPcSoAjTi0YbVFxilWPLy81KV
	RHg7Zi0MF+JNSaysSi3Kjy8qzUktPsQozcGiJM6beHx+uJBAemJJanZqakFqEUyWiYNTqoFx
	v/3UY1053hb9Wy7ELFlh9oMneIG1b/XMjq2tdxXaV81S1IoPk7AsP+mUwcR8XO79TabY1gnr
	msrsXsz9u9ilOPjutoUFi5RfOmxk6TpSIhcbJ54q6C0bLb5gcX65cqXm0+IvDJ9kb6w0P2bt
	e8rxRkf+urJ1+//eEmTabnY1qqh8rrfolWYlluKMREMt5qLiRAAtOTvdNQIAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--Apple-Mail=_2ED1717F-FDC6-4573-9335-EBBA236FE941
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

I have two test failures to report in git 2.9.2 on macOS:


t3210-pack-refs.sh has not changed between 2.8.4 and 2.9.2.  This test =
passed fine with 2.8.4, but it now fails with 2.9.2 at:

not ok 26 - retry acquiring packed-refs.lock
#=09
#		LOCK=3D.git/packed-refs.lock &&
#		>"$LOCK" &&
#		test_when_finished "wait; rm -f $LOCK" &&
#		{
#			( sleep 1 ; rm -f $LOCK ) &
#		} &&
#		git -c core.packedrefstimeout=3D3000 pack-refs --all =
--prune
#=09

=3D=3D=3D

t3700-add.sh recently added the 'git add --chmod=3D-x stages an =
executable file with -x' test.  This test passes when run as a normal =
user but fails when run as root:

$ ./t3700-add.sh
...
# passed all 40 test(s)
1..40

$ sudo ./t3700-add.sh
...
not ok 39 - git add --chmod=3D-x stages an executable file with -x
#=09
#		echo foo >xfoo1 &&
#		chmod 755 xfoo1 &&
#		git add --chmod=3D-x xfoo1 &&
#		case "$(git ls-files --stage xfoo1)" in
#		100644" "*xfoo1) echo pass;;
#		*) echo fail; git ls-files --stage xfoo1; (exit 1);;
#		esac
#=09
# failed 1 among 40 test(s)
1..40


--Apple-Mail=_2ED1717F-FDC6-4573-9335-EBBA236FE941
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIM5TCCBeIw
ggPKoAMCAQICEFy2SG5HDJjGf/aA22RK4o0wDQYJKoZIhvcNAQELBQAwfTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKzApBgNVBAsTIlNlY3VyZSBEaWdpdGFsIENlcnRpZmlj
YXRlIFNpZ25pbmcxKTAnBgNVBAMTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTE1MTIxNjAxMDAwNVoXDTMwMTIxNjAxMDAwNVowdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAO4PUIyVCSOErPVQao/WN6JOIf0yCWVHPq84+tUb94TQf8nhBAtX894vxFPjFzjh
sTOygm7QiHCcRyFv5PET+rDzzDuHE4O7Dc3wVrGLHprWOnzf5Fa9kdl/vz477cZgGl6Rl9M570D8
WhNdtyDBl8tMxCh2f5yQ2dffUz/UzZ/b/tUDtAGW+KGie3IdA6UiWvJBecYjRQwIPbWiikq1bjxy
S/TBRWDyKsEoYx4PrmBM438WzD9kFsGpp2gPWO3zkUgzWqXbhZQEQHA7V3TKQIo4huByp6zd9tyN
Cmu5Q0wFsi7UwwhEyrCPH8zsi9IpxLtVhFaXT8rZvLNa8EAeH/UCAwEAAaOCAWQwggFgMA4GA1Ud
DwEB/wQEAwIBBjAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwEgYDVR0TAQH/BAgwBgEB
/wIBADAyBgNVHR8EKzApMCegJaAjhiFodHRwOi8vY3JsLnN0YXJ0c3NsLmNvbS9zZnNjYS5jcmww
ZgYIKwYBBQUHAQEEWjBYMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5zdGFydHNzbC5jb20wMAYI
KwYBBQUHMAKGJGh0dHA6Ly9haWEuc3RhcnRzc2wuY29tL2NlcnRzL2NhLmNydDAdBgNVHQ4EFgQU
mZerGDU6i1lFQ5iycnHI9PsJzxYwHwYDVR0jBBgwFoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwPwYD
VR0gBDgwNjA0BgRVHSAAMCwwKgYIKwYBBQUHAgEWHmh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3Bv
bGljeTANBgkqhkiG9w0BAQsFAAOCAgEAmUFBBM72JPVOMDR4Q7tX/UBsG8wB+JuMCCh/GYnTWMGY
cqDSltONYidNNijFvcsGDPeZ+O+9LU+Och9vb0zJWbQb89IeOCrsTCzV0Qkw8L1dO7E9/Zz4xYuT
KcGWi1bnjYmmtb6JNZ9lp/JS3MgpbWGTRgBInzNJKPwP773JH7RSGRu+UQImR2LX563QRojschfp
xyPWt9wUV+VZf989Prh2f2OmD2zSe4m6DhaxWQQrbfpad1mgwetmaAXsIjJndPSa6pjCQBIMNxG3
0DbWj8xz4PxDoZWYpEYHeAQq862yKgdkSom/oJ0CbdrqCWijmlfdEvV4LNzwvN+zhPQhJmOvzE0x
tMaWy4doUf6y0N7Aqx+emjg3rg60AavOZV8UWwwhEQ1EexWVIR7/otWkGmOfTT7tuoQ3ep6pLEg6
tpgnXaYnTwbhic/ZTV9p0chpLnQ7lleoCK+gGX2mL/oIE1znAgyWRczIVnSwuwj70SsUO704mFfu
JYKjr1fTJ2XNePTz7YrU8rKv6Dr+9M8e6vrcmi02uHKhYQnJYSMEsDhCYld8akHm75sLA1+wWlxg
CWSIW3VGza96aBIHLergMcNs8q+vVgiZk1FIc/5Nf00/3glGSapzIP+po3u7YlXWlECXAbSenKuf
plAzVAdX6IVvBDhWosxaT/9BWj+tnLUwggb7MIIF46ADAgECAhAX8MOmbUCDPWU+X4TKPzSUMA0G
CSqGSIb3DQEBCwUAMHUxCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSkwJwYD
VQQLEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTEjMCEGA1UEAxMaU3RhcnRDb20g
Q2xhc3MgMiBDbGllbnQgQ0EwHhcNMTYwMTI4MDUzNDA3WhcNMTgwMTI4MDUzNDA3WjBzMQswCQYD
VQQGEwJVUzETMBEGA1UECAwKQ2FsaWZvcm5pYTERMA8GA1UEBwwIV29vZHNpZGUxGTAXBgNVBAMM
EEplcmVtaWFoIFNlcXVvaWExITAfBgkqhkiG9w0BCQEWEmplcmVteWh1QGdtYWlsLmNvbTCCAiIw
DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANJQpjXCVgn9Bf+x34nMseNlpLX3qKn9mGqv2uh2
gBPf++z3kXVI2c92FN/lEicsvvAnuo3q0RwJvh/Z++8dW+RRuAm58adZmXEJWwf90vLzH3hFDC4W
V6slcg3e5KvtcJ+u6BzT/WFRdDGEPqsYENI0OpEJK2NcfmRzkZ+CTitMp379Z7vV3ly3l72Y/I4E
UZgYSluez4qqwlljdOVgL7aTmrJuw2ZI5CoDpj2xiwvFxFm9vyfgyyh34p2sFhSR/AWZR5rsfyoM
fw0uJ7s7a5EgdOf/dS0eeqpohBAXvfHQ0AFq4Gx++bAxWCaogskAhTxGBoc9fn85CCyiwlrfNcZZ
6+L5rY+n7JoUHRYZjwYIBieI5YQ247GkN8R+fBjIrMCDl/+7uI/1Vg/hxstsrvUyLouuOl9k3WWu
PSiSHjKZGuNnZS4z1LXDBnOtUCsyjHs79L617AyFK3Mt+W5qdUK5ChPzNYL5IcNLkkLduy6WGsZH
39n9Lruemd6qr+T9Syd1x+Zz7+4xog6DFyML89nJT7mQ1MDUVEpyX2N1GvDCgnVJ7iOQB1mL7fKg
qEdLYkihyWy3SkJrmw/Ga+GOjr0DkmrUUWIYkAOF8mWKGoigayR3RMZhWDyRxpXyFF7jtphX9Fob
Td96tP4RWs9GrfD5BGVtdhVW97SW0A3D8UkxAgMBAAGjggKHMIICgzALBgNVHQ8EBAMCBLAwHQYD
VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAkGA1UdEwQCMAAwHQYDVR0OBBYEFMXHiWE0gVse
XU627q/t4qVnbDu6MB8GA1UdIwQYMBaAFJmXqxg1OotZRUOYsnJxyPT7Cc8WMG8GCCsGAQUFBwEB
BGMwYTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3Auc3RhcnRzc2wuY29tMDkGCCsGAQUFBzAChi1o
dHRwOi8vYWlhLnN0YXJ0c3NsLmNvbS9jZXJ0cy9zY2EuY2xpZW50Mi5jcnQwOAYDVR0fBDEwLzAt
oCugKYYnaHR0cDovL2NybC5zdGFydHNzbC5jb20vc2NhLWNsaWVudDIuY3JsMIHjBgNVHREEgdsw
gdiBEmplcmVteWh1QGdtYWlsLmNvbYESamVyZW15aHVAYXBwbGUuY29tgRFqZXJlbXlodWRAbWFj
LmNvbYEVamVyZW15aHVAbWFjcG9ydHMub3JngRhqZXJlbXlodUBmcmVlZGVza3RvcC5vcmeBEGpl
cmVteWh1ZEBtZS5jb22BFGplcmVteWh1ZEBpY2xvdWQuY29tgRRqZXJlbXlAamVyZW15aHUuaW5m
b4EUamVyZW15QGh1ZHNjYWJpbi5jb22BFmplcmVteUBvdXRlcnNxdWFyZS5vcmcwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMFQGA1UdIARNMEswDAYKKwYBBAGBtTcGATA7Bgsr
BgEEAYG1NwECBDAsMCoGCCsGAQUFBwIBFh5odHRwOi8vd3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kw
DQYJKoZIhvcNAQELBQADggEBANa+oip18OvH6LflykKaMt8qN07CwhNKYvWcCeTCR2IDJsDUbVXB
9H8RqqAgEs7pEjRY+gdJSzf8wqPzJ5n6zpyeJH7p1Rsvdx9UEknqgJlmKjzOJ15GFWMjhWjlg05n
SKJsGmJrpIHVjxSeq+q5RVizyxYh1OyRisKmSrJdrmqHeBcKjlfQjFtdEt/LZrJ/qzH4WaRohdoN
C5vXwIxdczlEnZc1+ZfM5j39unU1GAskIgQCHrUJcublS53ysYKo6JhidGUytVB5O0k6J1J73dCZ
DOhlN/np0KmCWDYx8UgdJHhEyhyAKSWWltf2U4bPpEI4BbOKwegeRJJqK1oRW9cxggROMIIESgIB
ATCBiTB1MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjEpMCcGA1UECxMgU3Rh
cnRDb20gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkxIzAhBgNVBAMTGlN0YXJ0Q29tIENsYXNzIDIg
Q2xpZW50IENBAhAX8MOmbUCDPWU+X4TKPzSUMAkGBSsOAwIaBQCgggGZMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MDgwMzA3MzU1NlowIwYJKoZIhvcNAQkEMRYE
FGa5WCZIZLRT7TOCh1pwmCu+s0L3MIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1l
Pl+Eyj80lDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1lPl+Eyj80lDANBgkq
hkiG9w0BAQEFAASCAgBQMGhyLOEYj8GQqe1oPUu5CFv5ShfvWrXf50kWG40yUz/y2JoSKkaU7+Sb
Q2hwxe7cyFgIOEvEuqTI+/dNRRcsRYZlJ8e+jKwvZShh+62pDnZKhiFScfAoJf2l1deh7yLwqh8D
p/cTJ6/G52MxRdyaUeluJ1e4LyjjLB0hzh3yredOvd7Cy5c1upbzHvD+YKwmmx8hjskp+5dcmAkY
QDorGJun7eYLmEIEnSCXieEn/zIb+hnfmnvp7ojM6SJ2MbPzW8XvFZwqe32k8iwgKPkCMA3HRofc
7Wx1vyBNeQ6B11QgOWWefC+39o5tnT59kTGyZk0xrXoennd3pKF9/TlyfHwaDlDg98g61Ii0C0Hk
DsCAgCYSXv4IRK9fT5sX0tGEoR5hNz46XXa9wTmhCvMTb0qMCS2yXknJoY5UkScaAlGeCK+jM9Ij
Nco4EKT4M/fNaSwmtTflx8y+OEMa7bKsVrJAyFqIIxGnTcqT4rj5QKtiNrY/fDea/LnQDjMRG2b1
weM08yk3GK3MdFy9WgoqJuIABrcJtjIHuk3qf7EAgIX+5XNBEtLXUAahQKiHBC6esgt4g4UtQpgz
RwsBd0YZMrldQka0BF4L4I45gCi8V1b1vU7CoRZ8FXh7DbsaPab9CJygiFy+36Y0AWekYrUPPiNQ
mHr4MR2MIo8Uvi6ahAAAAAAAAA==
--Apple-Mail=_2ED1717F-FDC6-4573-9335-EBBA236FE941--
