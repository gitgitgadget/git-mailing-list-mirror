Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E21207EC
	for <e@80x24.org>; Mon, 10 Oct 2016 04:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbcJJEJD (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 00:09:03 -0400
Received: from mail-out5.apple.com ([17.151.62.27]:58216 "EHLO
        mail-in5.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750729AbcJJEJC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 00:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
        q=dns/txt; i=@apple.com; t=1476072521;
        h=From:Sender:Reply-To:Subject:Date:Message-id:To:Cc:MIME-version:Content-type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-reply-to:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0NK1mnq7rLUcjPlJSO9jpgv7QQYv12Ew4mNJWEyuUYs=;
        b=zZcc76HmHMe8no0Kuny2LovrQ8hP/or8rO3kJ2n+j9nRhDRWmKMCbJ95TiAkTsag
        WlX+up8DmBMZS7OE/PnUqAT0YK/GivaZd1M9a64gQ0pXzY2DC+ys5fmZl0Inyxdr
        jZRaEd1ZXzmri5D9ergrSZjdacIc1bZHVgrjQ+8dflgkuDTlpFoHvyw5aHpXSC7O
        1FG8tDvb9aJvMJSrNiyUyrlizNoYlq+EcwrBIf3Ur8Nh5j18qTr9CbQ02kymm7aP
        VTktHeQEx/5bEUU4THMiHG893meyqvV3Yi/xS8hogfHICZtMKsC8wMSuAyvYVl2Q
        FYGhacfLWkI+v6AU72z3+w==;
Received: from relay8.apple.com (relay8.apple.com [17.128.113.102])
        by mail-in5.apple.com (Apple Secure Mail Relay) with SMTP id BD.C6.07165.9441BF75; Sun,  9 Oct 2016 21:08:41 -0700 (PDT)
X-AuditID: 11973e13-41e679a000001bfd-38-57fb14493a26
Received: from kencur (kencur.apple.com [17.151.62.38])
        by relay8.apple.com (Apple SCV relay) with SMTP id 84.29.29380.9441BF75; Sun,  9 Oct 2016 21:08:41 -0700 (PDT)
MIME-version: 1.0
Received: from [17.153.27.88] (unknown [17.153.27.88])
 by kencur.apple.com (Oracle Communications Messaging Server 8.0.1.2.0 64bit
 (built Sep 28 2016)) with ESMTPSA id <0OET00G6ACUGNB70@kencur.apple.com>; Sun,
 09 Oct 2016 21:08:41 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Message-id: <BC856B6F-B18F-41AF-BE60-973B8CFFC973@apple.com>
Content-type: multipart/signed;
 boundary="Apple-Mail=_3473DF47-34B7-4949-AACD-FFAF91D621A5";
 protocol="application/pkcs7-signature"; micalg=sha1
Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better
 handle distro changes to DEF_VER
Date:   Sun, 09 Oct 2016 21:08:41 -0700
In-reply-to: <E0254A0C-8BEC-4B88-A352-BA075B49BFA7@joshtriplett.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
References: <20161010025323.9415-1-jeremyhu@apple.com>
 <E0254A0C-8BEC-4B88-A352-BA075B49BFA7@joshtriplett.org>
X-Mailer: Apple Mail (2.3249)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsUi2FCYpusp8jvcYOdyGYuuK91MFg29V5gt
        /i/Id2D2uPXa1uPiJWWPz5vkApijuGxSUnMyy1KL9O0SuDL+f17CVHDTtmLmjYMsDYz7rboY
        OTkkBEwkOu5NYe9i5OIQEtjHKLHq6GV2mMTmBUuZQGwhgRWMEn273UBsXgFBiR+T77FANPxg
        lJj3ZwsjSEJYQEpi9Zt/zCA2G1DzrT+nWSAabCRezvjBCtLALDCFUeJ1bwc7REOexP1rJ4Aa
        ODhYBFQlHnRZgIQ5BVwk2p8tAFvMLGAtce/IUUaQEhEBTYnpm5Ug7imQmLt/MSvEnbISe+ae
        ABsvIfCdTaL/7CvmCYxCs5DcOgvZ6llgc7Ulli18zTwLaC6zgI7E5IWMEGFTiSdvt7PNglr9
        c84jqLiixJTuh+wLGNlXMQrlJmbm6GbmmeolFhTkpOol5+duYgTFy3Q74R2Mp1dZHWIU4GBU
        4uFNmPErXIg1say4MvcQozQHi5I478UdQCGB9MSS1OzU1ILUovii0pzU4kOMTBycUg2MNier
        k5wtFgvEL60OC2vesmOmMVcs6+SJ/uu/zld/vSZoZmjlkofX78x+yLGW96xz9IFK1uutdgIW
        z1dlRS150iC4282AbXFnZqyp8CVBM/2jazV/aluuv20UmjvD5M9zQdvH2RIV9VGfnr94MZU7
        6dRE6+uHY58peh1/dYP/8gbJNz8PTFXUUWIpzkg01GIuKk4EAFLsRZp4AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsUiON1OTddT5He4wfvtYhZdV7qZLBp6rzBb
        /F+Q78Dsceu1rcfFS8oenzfJBTBHcdmkpOZklqUW6dslcGX8/7yEqeCmbcXMGwdZGhj3W3Ux
        cnJICJhIbF6wlAnCFpO4cG89G4gtJLCCUaJvtxuIzSsgKPFj8j2WLkYuoPgPRol5f7YwgiSE
        BaQkVr/5xwxiswENuvXnNAtEg43Eyxk/WEEamAWmMEq87u1gh2jIk7h/7QRQAwcHi4CqxIMu
        C5Awp4CLRPuzBWBHMAtYS9w7cpQRpEREQFNi+mYliHsKJObuX8wKcaesxJ65J1gnMArMQnLe
        LGTbZoGN0pZYtvA18yygUcwCOhKTFzJChE0lnrzdzjYLatvPOY+g4ooSU7ofsi9gZF/FKFCU
        mpNYaaGXWFCQk6qXnJ+7iREU9g2FaTsYm5ZbHWIU4GBU4uF1qPkVLsSaWFZcmXuIUQVoxKMN
        qy8wSrHk5eelKonwbhL6HS7Em5JYWZValB9fVJqTWnyIsQro9YnMUqLJ+cBYzSuJNzQxMTAx
        NjYzNjY3MaeKsJI4r7vGj3AhgfTEktTs1NSC1CKY5UwcnFINjE0PFzHVCQakd6YppkZGhgZJ
        liX532a5tCfjIUOf44mZZ41tOVvm7d7SxHbIm2XD5q9Tl5a9+Sl9rOjRVw6eE5myG5LnTJh3
        IvKz/4rQtxPcBM8+OpGg+D313YKPHdoKKwxeGtoHPRVYybaoy9zRozM73ax55Xa9KG6GCboR
        K9c+v7Aspcp6iRJLcUaioRZzUXEiAM7U9OHiAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_3473DF47-34B7-4949-AACD-FFAF91D621A5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 9, 2016, at 20:04, Josh Triplett <josh@joshtriplett.org> wrote:
>=20
> On October 9, 2016 7:53:23 PM PDT, Jeremy Huddleston Sequoia =
<jeremyhu@apple.com> wrote:
>> Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>> CC: Josh Triplett <josh@joshtriplett.org>
>> CC: Junio C Hamano <gitster@pobox.com>
>=20
> Looks reasonable to me. Didn't realize git versions could have spaces.
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Thanks, Josh.

If anyone feels strongly that they shouldn't, I'd be happy to change our =
DEF_VER patch to play nicer.

cf =
https://github.com/jeremyhu/git/commit/f99905d0752d923e5ec61e14c675a300c6d=
04284

>=20
>> t/t4014-format-patch.sh | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
>> index 8d90a6e..33f6940 100755
>> --- a/t/t4014-format-patch.sh
>> +++ b/t/t4014-format-patch.sh
>> @@ -754,7 +754,7 @@ test_expect_success 'format-patch
>> --ignore-if-in-upstream HEAD' '
>> 	git format-patch --ignore-if-in-upstream HEAD
>> '
>>=20
>> -git_version=3D"$(git --version | sed "s/.* //")"
>> +git_version=3D"$(git --version | sed "s/git version //")"
>>=20
>> signature() {
>> 	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
>=20
>=20


--Apple-Mail=_3473DF47-34B7-4949-AACD-FFAF91D621A5
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MTAxMDA0MDg0MVowIwYJKoZIhvcNAQkEMRYE
FP9g9jDmK83onTjWo1Av58vr4PEWMIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1l
Pl+Eyj80lDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1lPl+Eyj80lDANBgkq
hkiG9w0BAQEFAASCAgANNZEuqV8l5pe6G1cfU4xh3ptsorngG6fV9663jSc19/W5HSzyGMc6SUrj
RjHYmtwegnkmXNfVEswAL08NbxQHZT8sAHZvP0LR7fIqxbBGqIeGMJ/jq2h6hjoTWrmRlBzt+J+G
6CrNvQskYWDIB77qp4hPE9LzBs6UrUE0igoHfTj2PsnoAo9IqiA7LKS08hbm+F3aCnTuCfXhw4Kd
ZNDBcIpGOOeMIcVefixU6YdVTD7VhYe9WI6dzxLD7hASKzTfYcye48h5K29Y/D+W2QQ1v8kygqac
+1kYjz4YOdbcBDv8EKDPgQNXK28RpK6Yg6QQer6nj2XuMtPJxLBnghcagQDDzQCSeclk0e6XHtTe
Tm72BqvXpRPWjL+ZVHcWMXdaDUEgTCrLe+LXUVyzH+57e0OAcua3/sHXRgd9nZUOx3dXOZvRK4q3
rJnoyQ8hxtVtGGo/mSxc+C1tqGXuMwYPwGQJRt5SiUFCqG7aNRoBpSuIX9IzITTc5xiCUZMz0Kql
lhvIPWwWByCzS/m/FILdYIDspFRZs6uozR3zfl2w4J8JgIrgDHKoa8JJm4sf18vXoceKuaQkxKlC
eoHD49KX9/qS0gnxB6jXL9lTQt7O24M9+VzLx5EWYITlII4cb3+Ulp9rV4WKy1voLIik5A9zRUfd
VtOabUvmBQjf5nkoRQAAAAAAAA==
--Apple-Mail=_3473DF47-34B7-4949-AACD-FFAF91D621A5--
