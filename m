Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A248220989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbcJJRCk (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:02:40 -0400
Received: from mail-out2.apple.com ([17.151.62.25]:51394 "EHLO
        mail-in2.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752277AbcJJRCi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
        q=dns/txt; i=@apple.com; t=1476118912;
        h=From:Sender:Reply-To:Subject:Date:Message-id:To:Cc:MIME-version:Content-type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-reply-to:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PqmJoQqusYcA0am1p+4/4aXGBtD4FpfXP4gBytcygMA=;
        b=oKkcKY5FyKyRf5rEQklT1ZmNDEUEMTHCnf43I+Xl92O6guUPNikjROvLldZoXvZl
        JNXQswtLoNDzc5ED+qU7SWUfHibi9cmOhOjXmZmqMbrDi4orKsMwUgYEP+qa1I2v
        GsNKI79MYFBk3hyyAXcPbnme7H6u5JfRJk3JlLUV0AhTJH++eSIqO9fMg21u2LuA
        C3uGC+1meWTvs348cpHz7dRyWU62ZYaF/3AMpazHeAcO6fWGFzmLBvSIIKpZWlRS
        1dPcvRRYLVSt9E2eSwyPvoNLAwfRdEcbuplYts/8I67KwKJF/BX3ziJIq/wRzO5T
        8GOfqDIXU2TJTWv6M1TWGA==;
Received: from relay8.apple.com (relay8.apple.com [17.128.113.102])
        by mail-in2.apple.com (Apple Secure Mail Relay) with SMTP id 03.DC.06856.089CBF75; Mon, 10 Oct 2016 10:01:52 -0700 (PDT)
X-AuditID: 11973e11-ece309a000001ac8-8a-57fbc9805fb7
Received: from kencur (kencur.apple.com [17.151.62.38])
        by relay8.apple.com (Apple SCV relay) with SMTP id B9.6B.29380.089CBF75; Mon, 10 Oct 2016 10:01:52 -0700 (PDT)
MIME-version: 1.0
Received: from [17.153.36.200] (unknown [17.153.36.200])
 by kencur.apple.com (Oracle Communications Messaging Server 8.0.1.2.0 64bit
 (built Sep 28 2016)) with ESMTPSA id <0OEU00C4PCN3OJ10@kencur.apple.com>; Mon,
 10 Oct 2016 10:01:52 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Message-id: <A7BDC661-317E-49C1-A8B1-534A0DC26501@apple.com>
Content-type: multipart/signed;
 boundary="Apple-Mail=_6EE58441-5FE2-465E-9E7E-4A4D1684075E";
 protocol="application/pkcs7-signature"; micalg=sha1
Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better
 handle distro changes to DEF_VER
Date:   Mon, 10 Oct 2016 10:01:51 -0700
In-reply-to: <xmqqpon8gnp3.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To:     Junio C Hamano <gitster@pobox.com>
References: <20161010025323.9415-1-jeremyhu@apple.com>
 <xmqqpon8gnp3.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3249)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsUi2FCYpttw8ne4wbPthhZdV7qZLBp6rzBb
        /F+Q78Dsceu1rcfFS8oenzfJBTBHcdmkpOZklqUW6dslcGVMaTEtOOVbsfbfcvYGxstuXYyc
        HBICJhKzvt9j6WLk4hAS2Mco8XftM1aYxInZF5ghEisYJa713GUDSfAKCEr8mAzSwQmU+MUo
        cfugLogtLCAlsfrNP2YQmw2o+daf0ywQ9TYSe9dPA7OZBaYwSpycpANRnydx/9oJoHoODhYB
        VYnnBxNAwpwC1hINe7+xQZTbSdx79o4dxBYRUJOY2HaIBaRcSCBdYt8lFYgzZSX2zD0BdfIZ
        Nol1U9wmMArNQnLoLCSLIWxtiWULXzPPAprELKAjMXkhI0TYVOLJ2+1sELa1xM85j6DiihJT
        uh+yL2BkX8UolJuYmaObmWekl1hQkJOql5yfu4kRFCfT7QR3MB5fZXWIUYCDUYmHd8Li3+FC
        rIllxZW5hxilOViUxHkv7fgVDnR5YklqdmpqQWpRfFFpTmrxIUYmDk6pBkatmRdbP+r8vn2d
        51F7W9r0tvmbhNf5nrsyed6EGEPeafPEf5cbT+yX3/J2xsEPx37adbGzHJ6U0HXQ72J2+to5
        53v//vCI9pVaeCrYs4enPislPGGq/l7/X8m9SrsPPo1WVzQVOrnUrf51/RMvfscLP/jWneT9
        IqWjvnoV9x25Netm9s4vLbJXYinOSDTUYi4qTgQAoVL1M3QCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsUiON1OTbfh5O9wg0d9uhZdV7qZLBp6rzBb
        /F+Q78Dsceu1rcfFS8oenzfJBTBHcdmkpOZklqUW6dslcGVMaTEtOOVbsfbfcvYGxstuXYyc
        HBICJhInZl9ghrDFJC7cW8/WxcjFISSwglHiWs9dNpAEr4CgxI/J91hAbCGBX4wStw/qgtjC
        AlISq9/8A2tmAxp0689pFoh6G4m966eB2cwCUxglTk7SgajPk7h/7QRQPQcHi4CqxPODCSBh
        TgFriYa939ggyu0k7j17xw5iiwioSUxsO8QCUi4kkC6x75IKxJmyEnvmnmCdwCgwC8lxs5As
        g7C1JZYtfM08C6ibWUBHYvJCRoiwqcSTt9vZIGxriZ9zHkHFFSWmdD9kX8DIvopRoCg1J7HS
        Qi+xoCAnVS85P3cTIyjgGwrTdjA2Lbc6xCjAwajEw/ti6e9wIdbEsuLK3EOMKkAjHm1YfYFR
        iiUvPy9VSYR361GgNG9KYmVValF+fFFpTmrxIUZpDhYlcV53jR/hQC8llqRmp6YWpBbBZJk4
        OKUaGOennYu40nzvYP2Rpxdu77K4fKM9N6jwk6Zi96xl5xYmelReUNyvfihG56jjUl4XXR2X
        xYf6duznvf1Jkr+9yXbWkUb/qAesZytyPpo+ZOQTeLlyVXSys2nF1Zdq2yem71fImbGtI+Dh
        1EVGoW1fVVsPujMcE3sTvOnnJt2Y1IrO+U0zYv9uOqfEUpyRaKjFXFScCAATcAGPgAIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_6EE58441-5FE2-465E-9E7E-4A4D1684075E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 10, 2016, at 09:42, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
>=20
>> Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae
>=20
> Please be considerate to future readers of "git log" to help them
> avoid mistakes earlier commits made that caused you troubles.
>=20
> This line by itself without any explanation of what was broken is
> quite useless as a commit message.  What can the readers do?  They'd
> go back and say "git show 480871e09" and then what?  The test added
> or modified by the commit has been working quite well for others
> since it was made, so it is very likely the reader wouldn't be able
> to tell if anything is wrong in it.
>=20
> You would help if you said what is different in _your_ environment
> from others who have happily been running and passing this test for
> others to understand and learn from your fix.  What is it?
>=20
> The "Adjust ... distro changes" in the title offers some hint but it
> could be more explicit.  Please write something along this line
> instead.
>=20
>    Subject: t4014: git --version can have SP in it
>=20
>    480871e09e ("format-patch: show base info before email
>    signature", 2016-09-07) added a helper function to recreate the
>    signature at the end of the e-mail, i.e. "-- " line followed by
>    the version string of Git, using output from "git --version" and
>    stripping everything before the last SP.
>=20
>    Because the default Git version string looks like "git version
>    2.10.0-1-g480871e09e", this was mostly OK, but people can change
>    this version string to arbitrary thing while compiling, which
>    can break the assumption if they had SP in it.  Notably, Apple
>    ships modified Git with " (Apple Git-xx)" appended to its
>    version number.
>=20
>    Instead, come up with the version string by stripping the "git
>    version " from the beginning.

Ok, I'll add that explanation to the commit message, thanks.


>=20
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>=20
> Good.
>=20
>> CC: Josh Triplett <josh@joshtriplett.org>
>> CC: Junio C Hamano <gitster@pobox.com>
>=20
> Please don't do this in your log message.  These belong to your
> e-mail headers, not here.

Sorry, we do that consistently on other projects during the review =
process, so git send-email picks them up and adds them automatically for =
each patch being sent out.  It's quite useful, actually.

>=20
>> ---
>> t/t4014-format-patch.sh | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index 8d90a6e..33f6940 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -754,7 +754,7 @@ test_expect_success 'format-patch =
--ignore-if-in-upstream HEAD' '
>> 	git format-patch --ignore-if-in-upstream HEAD
>> '
>>=20
>> -git_version=3D"$(git --version | sed "s/.* //")"
>> +git_version=3D"$(git --version | sed "s/git version //")"
>=20
> Anchor the fixed prefix to the beginning, so that we can protect
> ourselves from another distro that would add "git version" in the
> middle of their arbitrary versioning scheme ;-).  I.e.
>=20
>    sed "s/^git version //"

Ok.

>=20
>>=20
>> signature() {
>> 	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"


--Apple-Mail=_6EE58441-5FE2-465E-9E7E-4A4D1684075E
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MTAxMDE3MDE1MVowIwYJKoZIhvcNAQkEMRYE
FHdiDacwhDaK094gsENS8sDmHGFPMIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1l
Pl+Eyj80lDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1lPl+Eyj80lDANBgkq
hkiG9w0BAQEFAASCAgAUB60B7G83wwfdrf4WgLwuoEHnNfkWG6PsRPjIXxVmRHTIxwW4FrJ5SwGN
pe+/SQdwVi35V7vEsc63otCHuB4esfeB6m7Lr/G8+XPwpGnYofkLoCAQz9lg57hEv3X0ADLPkvSE
3vKdEIYoCLOaDrcijfvr56/fRHnqfoVTRodKfqTR8Btw2xuEhS/pTtsN2SuBxljiPDChGrabLP/4
Rfr0sRxJMmSykKwIV+4v/Cyzl2dIQyUWUqOnU0XNWVZwPZdujQbtoHC3IqdwELBm4r1Lsd7Z4la7
ZSNrN52RdAv5scYsDzDWeAn1sDWfzHQNCR3NehxxLdxkA2WvkgHqB47JMwcq9sLVsfp7tDqLOTPW
pUOwawWU/dNnL8m7OBx6TcIBZATG4kz1LLKeAWqBfrWARVVvzHHJQgMpLT7s0GiIPLJvoqR27bwy
vy9FluE6uLKIwe+VVyocYrlG0ENdDk2x0bAbsf1REXttg42XJ0Oz++IvN9i1nZ0qMB/1lNB3Pw4p
k8PmHV1LW2v9jqjBNbd9tVRrFHQsR+2v6btXhdg1spaYFK2U5jdr5TopVNIyOv32FjKuBELjlJeS
jFWo/ZkNl+3rOGFFZ4kzxbNEafDgPhBuB4rhmkcZlrWlRCLICFoTrW5C/VMu1GWqQ1KFxIlw5bZj
SZG+nZf1STbn6i0QugAAAAAAAA==
--Apple-Mail=_6EE58441-5FE2-465E-9E7E-4A4D1684075E--
