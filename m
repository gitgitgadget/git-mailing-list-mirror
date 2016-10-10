Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDB320989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbcJJRJJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:09:09 -0400
Received: from mail-out5.apple.com ([17.151.62.27]:45435 "EHLO
        mail-in5.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752245AbcJJRJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
        q=dns/txt; i=@apple.com; t=1476119346;
        h=From:Sender:Reply-To:Subject:Date:Message-id:To:Cc:MIME-version:Content-type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-reply-to:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/d12KY9kNLDxNAP6C++RkJnUmViJZGgzbpFgntKTOwg=;
        b=0+iJ3wd8dUBM0prF/qZgPVakK1CAmY7QR6usUUDRWXhDcRLJtwjYL4ZbIwE2EbNp
        2fmWTl21Z1jHfHcLgvjvUh7BeMBcw7uYXJipx9ArzqIn7ELcZfWmcg8I46pueDaq
        hC3NWTiFoa3gBQy4MZ+dSHCi8Yu4ZOKRTExxCwV1M1CUI1BKoopJMnj1Awqoc5Vh
        +jhIMJ9bt4hmaBfd+zLbz2FXuli/w1/NlOmeIdBgFAXP0aWTjWLpVpmVIU76E4rc
        G9oje56wJxbtGySsERHED8KxX4PHtGJqqLA4zkwroAYk/W+3186OakNI7ivNOZta
        JhO8I0knI0B1JEevQHfymA==;
Received: from relay6.apple.com (relay6.apple.com [17.128.113.90])
        by mail-in5.apple.com (Apple Secure Mail Relay) with SMTP id 26.93.07165.23BCBF75; Mon, 10 Oct 2016 10:09:06 -0700 (PDT)
X-AuditID: 11973e13-e1fff70000001bfd-3d-57fbcb32e4e7
Received: from nwk-phonehomebzp-sz01 (nwk-phonehomebzp-sz01.apple.com [17.151.62.64])
        by relay6.apple.com (Apple SCV relay) with SMTP id 42.FA.23613.23BCBF75; Mon, 10 Oct 2016 10:09:06 -0700 (PDT)
MIME-version: 1.0
Received: from [17.153.36.200] (unknown [17.153.36.200])
 by nwk-phonehomebzp-sz01.apple.com
 (Oracle Communications Messaging Server 8.0.1.2.0 64bit (built Sep 28 2016))
 with ESMTPSA id <0OEU008GCCZ5DG70@nwk-phonehomebzp-sz01.apple.com>; Mon,
 10 Oct 2016 10:09:06 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Message-id: <D7AF680C-1BED-431C-980E-5895B3848815@apple.com>
Content-type: multipart/signed;
 boundary="Apple-Mail=_02FA5452-C324-4094-BFF5-75F38BD3676F";
 protocol="application/pkcs7-signature"; micalg=sha1
Subject: Re: [PATCH] t3700-add.sh: Avoid filename collission between tests
 which could lead to test failure
Date:   Mon, 10 Oct 2016 10:09:04 -0700
In-reply-to: <xmqqlgxwgnmu.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
References: <20161010035756.38408-1-jeremyhu@apple.com>
 <xmqqlgxwgnmu.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3249)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsUi2FAYpWt0+ne4wb07whZdV7qZLBp6rzBb
        XFh9m92B2WPnrLvsHhcvKXt83iQXwBzFZZOSmpNZllqkb5fAlbHvQwdjwQa7ikvHN7A2MB6z
        6mLk5JAQMJHoX7+ftYuRi0NIYC+jRMvmh6wwiZ4pZ9ggEscYJd7sXskCkuAVEJT4MfkeC0Ri
        FpPEs5dnmUASwgJSEqvf/GMGsdmAum/9OQ3VYCPxobuFCaSBWWAKo8SinfNYIRpyJc5e3Q1k
        c3CwCKhKbFnvCRLmFLCWmHVyNVgvs4C9xN0pi8HKRQTUJCa2HQKLCwlkSHyetIcR4lJZiT1z
        T4C9ICFwnU3i681TzBMYhWYhOXYWst2zwAZrSyxb+Jp5FtBuZgEdickLGSHCphJP3m5ng7Ct
        JX7OeQQVV5SY0v2QfQEj+ypGodzEzBzdzDxTvcSCgpxUveT83E2MoLiZbie8g/H0KqtDjAIc
        jEo8vC+W/g4XYk0sK67MPcQozcGiJM57ccevcCGB9MSS1OzU1ILUovii0pzU4kOMTBycUg2M
        M09fVHSLaGSwXBf75zkD35/jq78+PqHq/dKX7eDkrXUMRcskRDwKCmcsDT2wLGr6N+sAk7kd
        Bq3pi1OnCW6dwRad7PfoyeT2hp7LolEvzArkOVezXH/64dTvpuCXZ9o9pA/uVdh6pU05vMes
        6U1J3vMLvvNZJI7PivixTvuc/PNnJXVdS6ebKrEUZyQaajEXFScCAM2qOO18AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsUiON3OQdfo9O9wg1d93BZdV7qZLBp6rzBb
        XFh9m92B2WPnrLvsHhcvKXt83iQXwBzFZZOSmpNZllqkb5fAlbHvQwdjwQa7ikvHN7A2MB6z
        6mLk5JAQMJHomXKGDcIWk7hwbz2QzcUhJHCMUeLN7pUsIAleAUGJH5PvsUAkZjFJPHt5lgkk
        ISwgJbH6zT9mEJsNaNKtP6ehGmwkPnS3MIE0MAtMYZRYtHMeK0RDrsTZq7uBbA4OFgFViS3r
        PUHCnALWErNOrgbrZRawl7g7ZTFYuYiAmsTEtkNgcSGBDInPk/YwQlwqK7Fn7gnWCYwCs5Dc
        NwvZullgs7Qlli18zTwLaB2zgI7E5IWMEGFTiSdvt7NB2NYSP+c8goorSkzpfsi+gJF9FaNA
        UWpOYqWZXmJBQU6qXnJ+7iZGUPg3FEbtYGxYbnWIUYCDUYmH98XS3+FCrIllxZW5hxhVgEY8
        2rD6AqMUS15+XqqSCO/Wo0Bp3pTEyqrUovz4otKc1OJDjNIcLErivO4aP8KFBNITS1KzU1ML
        UotgskwcnFINjFYV77ZNdX/9cPWyY1OCtzaq3EnarvH497281XsvHCx9YSD91u/z5xtue/Pc
        522r2Trf9Vj+zKy6kKOeYS5qBybqvNH+UquvVzmF+WrkHr3DCSVvbF03nxTg3az7xORyQpmc
        v7d3svWNUoUF7axzv9kKLZ9gZzDtNeP5mzbuFbbaU3OP/vIMmq7EUpyRaKjFXFScCACELVPo
        hwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_02FA5452-C324-4094-BFF5-75F38BD3676F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Oct 10, 2016, at 09:44, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:
>=20
>> Regressed-in: 610d55af0f082f6b866dc858e144c03d8ed4424c
>> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
>> CC: Thomas Gummerer <t.gummerer@gmail.com>
>> CC: Junio C Hamano <gitster@pobox.com>
>=20
> This is also under-explained.  Was the test broken for everybody and
> you are the first to report, or was your environment somehow different
> that the existing problem was revealed there first?

There is nothing obviously different about my environment.  I'd expect =
this test to fail for everyone that runs the entire test because xfoo3 =
is not cleaned up after this earlier test:

test_expect_success \
        'git update-index --add: Test that executable bit is not =
used...' \
        'git config core.filemode 0 &&
         test_ln_s_add xfoo2 xfoo3 &&   # runs git update-index --add
         test_mode_in_index 120000 xfoo3'

If anyone ran the test by itself or otherwise skipped the 'git =
update-index --add: Test that executable bit is not used...' test, they =
would not encounter the issue.  However, the normal case is to run all =
of the tests, so I would expect everyone to be tripping over this issue. =
 If they're not, then that itself might be indicative of another bug =
because clearly that previous test just added xfoo3 as a symlink.

--Jeremy=

--Apple-Mail=_02FA5452-C324-4094-BFF5-75F38BD3676F
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
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE2MTAxMDE3MDkwNVowIwYJKoZIhvcNAQkEMRYE
FH3ojkNoiMnQDg50F9HUBK1jOKc6MIGaBgkrBgEEAYI3EAQxgYwwgYkwdTELMAkGA1UEBhMCSUwx
FjAUBgNVBAoTDVN0YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24g
QXV0aG9yaXR5MSMwIQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1l
Pl+Eyj80lDCBnAYLKoZIhvcNAQkQAgsxgYyggYkwdTELMAkGA1UEBhMCSUwxFjAUBgNVBAoTDVN0
YXJ0Q29tIEx0ZC4xKTAnBgNVBAsTIFN0YXJ0Q29tIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MSMw
IQYDVQQDExpTdGFydENvbSBDbGFzcyAyIENsaWVudCBDQQIQF/DDpm1Agz1lPl+Eyj80lDANBgkq
hkiG9w0BAQEFAASCAgBkYDQVPo5j9OTS7XtBZUn8jix9eMcEWjtb3EtGVsL31zNgd9+rag44Wk5J
RSS7ogqU1WIvvxyY+j+iAggWNZqEatoZnA7UrjzkzrEcZUn1HzLs2wJhiKiP3eVVzdnj10FnRnTe
d1pfD3GsmDPj7IJtE3z69o0QGwwcHlTPtkoLep1jWImnDP0AQdjwIfgrC7SjtYd+9Ld9PA8x2J6u
tOUz4DM4szhfat0ppKM2jWemMXJFbK1RZfJWmqtkLKaAMCjK9mdlNtLbXYvDMeOIEfAnxlbDudSb
mJyH82dDgRtmm6yCKLoegbF49rSqHv50n/MxbxJl8TJngM3qpzidpAor9CnLo1+Vci1wDsprLhBz
eMFASDCT0LYS1uSD7IIKQpNQtSqxBG00jiFFdifgPkUI1qvE3/dwjwA27qB++rtrsVxoPOWU+OZE
5OqZGrLHdCzUFe4ywuu1gzazvSCq4V7S5m22JREXjPn8cKFseX3wGE6JmpCY93ucosal2GxoPcw0
tqz6TBqpdajb5j6r13he2A8Sdi+5KpxWEWmL+XrrI5mp4KEnOUOqlzUx3911HkmWOgBoIpSok1Sc
s0Vkgpy9pq0xyZXOtRpCgFp23Nfp4IHjN8bEPgg8F7iAv2Zfv/zBUbrjiHMFiS3BGofKv3LfBS7E
MKWU8jXVLwze6TzdMQAAAAAAAA==
--Apple-Mail=_02FA5452-C324-4094-BFF5-75F38BD3676F--
