Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08E21FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 13:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbdFPNt7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 09:49:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:59324 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdFPNt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 09:49:58 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MLunc-1dTarK3Dzw-007iwm; Fri, 16
 Jun 2017 15:49:50 +0200
Date:   Fri, 16 Jun 2017 15:49:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i
 fixes
In-Reply-To: <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706161527140.4200@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net> <20170614102427.5220-1-phillip.wood@talktalk.net> <xmqqshj0yhq1.fsf@gitster.mtv.corp.google.com> <xmqqk24cygvm.fsf@gitster.mtv.corp.google.com> <xmqqfuf0ygmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-503763727-1497620990=:4200"
X-Provags-ID: V03:K0:/roOeq7fDaEXCg/GipUD6z1kGS21X2ccNBfgCDwZA2KOFk3FiSn
 kfq/pfGXgssfRYiuBqZiPoQRq9SCn7ufkW+jWlI3GOr/xVnYemuxe9nIkEjARORx8HvJlBj
 wxIIDzXNyBjDcacvii5TySI9u/oWQaxgfn7I8oFwoiOOPQqWdTKCjQg7/82FjxyaIL/YWXf
 qsAl5rqdvoVtAIkMUl+8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+DuUZbcyMk8=:i8tAp0JNt6xlYJLwZk931u
 U1q6vZbKg8er3vc0/WqJu1qzsQTcZwknsrgb4kOsCYVm3ImftSgj81q67fxtdWEtKOjW4aX7e
 mYyhprdgMjvfZkm4nLkSMUKgOuHhVyOPW8Om3IErXtaYJDZsJPFE5O9TYdrmqlGa1CRa4avhN
 klOkNCRSMhSVT/Aj8ukeX6ImEnBLpCmE1NuctKt3UOxzr34mnM5LHyL6PeQOpRc+tYAiUqQbg
 UqAHLwHv4m8RPLnQuMgiv99C8wR/564fW18MNPTJAqOFT1qEwMRj/Pw42ye5yRC55FsWGODK7
 DkMQUoH0+6xWlfvSzb7v5RZNcfj98vTpZWri6yDWipRXHAHlDn0oqdZ3x2+UL8Thssh+8QHKV
 NS3nDREaeE+8P8gDMyms4xdccge/GaFg9Os+6/bknJ7CMkVrm1IovbaSVXTlU/u1Yr8QVsoFW
 tfDGeRyX9KjFDLg4I1kl+31DcOUK4F4oO8xJHU/6RfW8wx2qg+w8SblqNW9ISKXkGmb8DU1XF
 HjpvXdUfejgcDVg0zJMCadXKVuKuXRvys3FakfIYY0WsEBrxfW1MeIRw1Y8UP3Hwy29RCjPCt
 r8uJINcH7pDsHaF58W2PmXI35Nc1iMg1WH6HXmLSMNWFN7v2I0aF7PIBjQEciEZFgFntMv+Zq
 SPMwWu4ki9zOzdGrOyBH7CXoW+cJIDYbj5Tx13X/bX+WHvukj++qqU1BDiP0z5MM+K6UUlyI2
 xlzKXmXCTbqp3TSJzF5MN27yW0UjOQCnDLMcM6VaQNs4vkMrrETS6qDaaeQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-503763727-1497620990=:4200
Content-Type: text/plain; charset=US-ASCII

Hi Junio,

On Thu, 15 Jun 2017, Junio C Hamano wrote:

> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index 325ec75353..801bce25da 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -45,7 +45,7 @@ create_expected_success_am() {
>  }
>  
>  create_expected_success_interactive() {
> -	cr=$'\r' &&
> +	cr=$(echo . | tr '.' '\015') &&
>  	cat >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
>  	HEAD is now at $(git rev-parse --short feature-branch) third commit

This is still incorrect, as the \r\n (which $(echo . | tr \.\ '\015')
would emit) is interpreted correctly as a line break on Windows, meaning
that cr is now *empty*. Not what we want.

What I did is to replace the `cat` by `q_to_cr` (we have that lovely
function, might just as well use it), replace `${cr}` by `Q` and skip the
cr variable altogether.

Additionally, there is another huge problem: the "Applied autostash." is
printed to stdout, not stderr, in line with how things were done in the
shell version of rebase -i.

While this was just a minor bug previously, now we exercise that bug, by
redirecting stderr to stdout and redirecting stdout to the file `actual`.
Nothing says that stderr should be printed to that file before stdout, but
that is exactly what the test case tries to verify.

There is only one slight problem: in my Git for Windows SDK, stdout is
printed first.

The quick fix would be to redirect stderr and stdout independently.

However, I think it is time for that bug to be fixed: autostash messages
should really go to stderr, just like the rest of them rebase messages.

I attached the patch, together with the two fixups to Phillip's patches,
and a fixup for the autostash-messages-to-stderr patch that I think should
be squashed in but I really ran out of time testing this.

Phillip, would you mind picking those changes up as you deem appropriate?

Ciao,
Dscho
--8323329-503763727-1497620990=:4200
Content-Type: text/x-diff; name=0001-sequencer-print-autostash-messages-to-stderr.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.1.1706161549490.4200@virtualbox>
Content-Description: 
Content-Disposition: attachment; filename=0001-sequencer-print-autostash-messages-to-stderr.patch

RnJvbSBjNWE4MzE5ZjAzNzhkOTNiZTVhZWEwNWI4MzNiYjVlMjNjOWYwYjNk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSm9oYW5uZXMgU2No
aW5kZWxpbiA8am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+DQpEYXRlOiBG
cmksIDE2IEp1biAyMDE3IDE1OjM0OjUwICswMjAwDQpTdWJqZWN0OiBbUEFU
Q0ggMS80XSBzZXF1ZW5jZXI6IHByaW50IGF1dG9zdGFzaCBtZXNzYWdlcyB0
byBzdGRlcnINCg0KVGhlIHJlYmFzZSBtZXNzYWdlcyBhcmUgcHJpbnRlZCB0
byBzdGRlcnIgdHJhZGl0aW9uYWxseS4gSXQgd2FzIGEgYnVnDQppbnRyb2R1
Y2VkIGluIDU4Nzk0Nzc1MGJkIChyZWJhc2U6IGltcGxlbWVudCAtLVtuby1d
YXV0b3N0YXNoIGFuZA0KcmViYXNlLmF1dG9zdGFzaCwgMjAxMy0wNS0xMikg
YW5kIHRoYXQgYnVnIGhhcyBiZWVuIGZhaXRoZnVsbHkgY29waWVkDQp3aGVu
IHJlaW1wbGVtZW50aW5nIHBhcnRzIG9mIHRoZSBpbnRlcmFjdGl2ZSByZWJh
c2UgaW4gdGhlIHNlcXVlbmNlci4NCg0KSXQgaXMgdGltZSB0byBmaXggdGhh
dDogbGV0J3MgcHJpbnQgdGhlIGF1dG9zdGFzaCBtZXNzYWdlcyB0byBzdGRl
cnINCmluc3RlYWQgb2Ygc3Rkb3V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKb2hh
bm5lcyBTY2hpbmRlbGluIDxqb2hhbm5lcy5zY2hpbmRlbGluQGdteC5kZT4N
Ci0tLQ0KIHNlcXVlbmNlci5jIHwgMTEgKysrKysrLS0tLS0NCiAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvc2VxdWVuY2VyLmMgYi9zZXF1ZW5jZXIuYw0KaW5kZXgg
YTU5NDA4YTIzYTIuLjg3MTNjYzhkMWQ1IDEwMDY0NA0KLS0tIGEvc2VxdWVu
Y2VyLmMNCisrKyBiL3NlcXVlbmNlci5jDQpAQCAtMTkyMyw3ICsxOTIzLDcg
QEAgc3RhdGljIGludCBhcHBseV9hdXRvc3Rhc2goc3RydWN0IHJlcGxheV9v
cHRzICpvcHRzKQ0KIAlhcmd2X2FycmF5X3B1c2goJmNoaWxkLmFyZ3MsICJh
cHBseSIpOw0KIAlhcmd2X2FycmF5X3B1c2goJmNoaWxkLmFyZ3MsIHN0YXNo
X3NoYTEuYnVmKTsNCiAJaWYgKCFydW5fY29tbWFuZCgmY2hpbGQpKQ0KLQkJ
cHJpbnRmKF8oIkFwcGxpZWQgYXV0b3N0YXNoLlxuIikpOw0KKwkJZnByaW50
ZihzdGRlcnIsIF8oIkFwcGxpZWQgYXV0b3N0YXNoLlxuIikpOw0KIAllbHNl
IHsNCiAJCXN0cnVjdCBjaGlsZF9wcm9jZXNzIHN0b3JlID0gQ0hJTERfUFJP
Q0VTU19JTklUOw0KIA0KQEAgLTE5MzcsMTAgKzE5MzcsMTEgQEAgc3RhdGlj
IGludCBhcHBseV9hdXRvc3Rhc2goc3RydWN0IHJlcGxheV9vcHRzICpvcHRz
KQ0KIAkJaWYgKHJ1bl9jb21tYW5kKCZzdG9yZSkpDQogCQkJcmV0ID0gZXJy
b3IoXygiY2Fubm90IHN0b3JlICVzIiksIHN0YXNoX3NoYTEuYnVmKTsNCiAJ
CWVsc2UNCi0JCQlwcmludGYoXygiQXBwbHlpbmcgYXV0b3N0YXNoIHJlc3Vs
dGVkIGluIGNvbmZsaWN0cy5cbiINCi0JCQkJIllvdXIgY2hhbmdlcyBhcmUg
c2FmZSBpbiB0aGUgc3Rhc2guXG4iDQotCQkJCSJZb3UgY2FuIHJ1biBcImdp
dCBzdGFzaCBwb3BcIiBvciINCi0JCQkJIiBcImdpdCBzdGFzaCBkcm9wXCIg
YXQgYW55IHRpbWUuXG4iKSk7DQorCQkJZnByaW50ZihzdGRlcnIsDQorCQkJ
CV8oIkFwcGx5aW5nIGF1dG9zdGFzaCByZXN1bHRlZCBpbiBjb25mbGljdHMu
XG4iDQorCQkJCSAgIllvdXIgY2hhbmdlcyBhcmUgc2FmZSBpbiB0aGUgc3Rh
c2guXG4iDQorCQkJCSAgIllvdSBjYW4gcnVuIFwiZ2l0IHN0YXNoIHBvcFwi
IG9yIg0KKwkJCQkgICIgXCJnaXQgc3Rhc2ggZHJvcFwiIGF0IGFueSB0aW1l
LlxuIikpOw0KIAl9DQogDQogCXN0cmJ1Zl9yZWxlYXNlKCZzdGFzaF9zaGEx
KTsNCi0tIA0KMi4xMi4yLndpbmRvd3MuMQ0KDQo=

--8323329-503763727-1497620990=:4200
Content-Type: text/x-diff; name=0002-fixup-rebase-add-regression-tests-for-console-output.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.1.1706161549491.4200@virtualbox>
Content-Description: 
Content-Disposition: attachment; filename=0002-fixup-rebase-add-regression-tests-for-console-output.patch

RnJvbSAzNDI1ZjdjOWJmYjYyYzNkMmQ0YWRhZmY0MWE2NjRkZDRhZTJlZmE5
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSm9oYW5uZXMgU2No
aW5kZWxpbiA8am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+DQpEYXRlOiBG
cmksIDE2IEp1biAyMDE3IDE1OjM5OjIwICswMjAwDQpTdWJqZWN0OiBbUEFU
Q0ggMi80XSBmaXh1cCEgcmViYXNlOiBhZGQgcmVncmVzc2lvbiB0ZXN0cyBm
b3IgY29uc29sZSBvdXRwdXQNCg0KU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMg
U2NoaW5kZWxpbiA8am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+DQotLS0N
CiB0L3QzNDIwLXJlYmFzZS1hdXRvc3Rhc2guc2ggfCA3ICsrKy0tLS0NCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvdC90MzQyMC1yZWJhc2UtYXV0b3N0YXNoLnNo
IGIvdC90MzQyMC1yZWJhc2UtYXV0b3N0YXNoLnNoDQppbmRleCA4MDFiY2Uy
NWRhNC4uNjQ5MDRiZWYwNjkgMTAwNzU1DQotLS0gYS90L3QzNDIwLXJlYmFz
ZS1hdXRvc3Rhc2guc2gNCisrKyBiL3QvdDM0MjAtcmViYXNlLWF1dG9zdGFz
aC5zaA0KQEAgLTQ1LDEyICs0NSwxMSBAQCBjcmVhdGVfZXhwZWN0ZWRfc3Vj
Y2Vzc19hbSgpIHsNCiB9DQogDQogY3JlYXRlX2V4cGVjdGVkX3N1Y2Nlc3Nf
aW50ZXJhY3RpdmUoKSB7DQotCWNyPSQoZWNobyAuIHwgdHIgJy4nICdcMDE1
JykgJiYNCi0JY2F0ID5leHBlY3RlZCA8PC1FT0YNCisJcV90b19jciA+ZXhw
ZWN0ZWQgPDwtRU9GDQogCSQoZ3JlcCAiXkNyZWF0ZWQgYXV0b3N0YXNoOiBb
MC05YS1mXVswLTlhLWZdKlwkIiBhY3R1YWwpDQogCUhFQUQgaXMgbm93IGF0
ICQoZ2l0IHJldi1wYXJzZSAtLXNob3J0IGZlYXR1cmUtYnJhbmNoKSB0aGly
ZCBjb21taXQNCi0JUmViYXNpbmcgKDEvMikke2NyfVJlYmFzaW5nICgyLzIp
JHtjcn1TdWNjZXNzZnVsbHkgcmViYXNlZCBhbmQgdXBkYXRlZCByZWZzL2hl
YWRzL3JlYmFzZWQtZmVhdHVyZS1icmFuY2guDQotCUFwcGxpZWQgYXV0b3N0
YXNoLg0KKwlSZWJhc2luZyAoMS8yKVFSZWJhc2luZyAoMi8yKVFBcHBsaWVk
IGF1dG9zdGFzaC4NCisJU3VjY2Vzc2Z1bGx5IHJlYmFzZWQgYW5kIHVwZGF0
ZWQgcmVmcy9oZWFkcy9yZWJhc2VkLWZlYXR1cmUtYnJhbmNoLg0KIAlFT0YN
CiB9DQogDQotLSANCjIuMTIuMi53aW5kb3dzLjENCg0K

--8323329-503763727-1497620990=:4200
Content-Type: text/x-diff; name=0003-fixup-rebase-add-more-regression-tests-for-console-o.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.1.1706161549492.4200@virtualbox>
Content-Description: 
Content-Disposition: attachment; filename=0003-fixup-rebase-add-more-regression-tests-for-console-o.patch

RnJvbSBlMTZhZDk4OWM4NWM1NWJkZmNmNDVmZTU2MTkxMWE2OTllOTYyYjQ0
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSm9oYW5uZXMgU2No
aW5kZWxpbiA8am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+DQpEYXRlOiBG
cmksIDE2IEp1biAyMDE3IDE1OjM5OjM1ICswMjAwDQpTdWJqZWN0OiBbUEFU
Q0ggMy80XSBmaXh1cCEgcmViYXNlOiBhZGQgbW9yZSByZWdyZXNzaW9uIHRl
c3RzIGZvciBjb25zb2xlDQogb3V0cHV0DQoNClNpZ25lZC1vZmYtYnk6IEpv
aGFubmVzIFNjaGluZGVsaW4gPGpvaGFubmVzLnNjaGluZGVsaW5AZ214LmRl
Pg0KLS0tDQogdC90MzQyMC1yZWJhc2UtYXV0b3N0YXNoLnNoIHwgNyArKyst
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3QvdDM0MjAtcmViYXNlLWF1dG9z
dGFzaC5zaCBiL3QvdDM0MjAtcmViYXNlLWF1dG9zdGFzaC5zaA0KaW5kZXgg
NjQ5MDRiZWYwNjkuLjJjMDFhZTZhZDJhIDEwMDc1NQ0KLS0tIGEvdC90MzQy
MC1yZWJhc2UtYXV0b3N0YXNoLnNoDQorKysgYi90L3QzNDIwLXJlYmFzZS1h
dXRvc3Rhc2guc2gNCkBAIC0xMDIsMTQgKzEwMiwxMyBAQCBjcmVhdGVfZXhw
ZWN0ZWRfZmFpbHVyZV9hbSgpIHsNCiB9DQogDQogY3JlYXRlX2V4cGVjdGVk
X2ZhaWx1cmVfaW50ZXJhY3RpdmUoKSB7DQotCWNyPSQoZWNobyAuIHwgdHIg
Jy4nICdcMDE1JykgJiYNCi0JY2F0ID5leHBlY3RlZCA8PC1FT0YNCisJcV90
b19jciA+ZXhwZWN0ZWQgPDwtRU9GDQogCSQoZ3JlcCAiXkNyZWF0ZWQgYXV0
b3N0YXNoOiBbMC05YS1mXVswLTlhLWZdKlwkIiBhY3R1YWwpDQogCUhFQUQg
aXMgbm93IGF0ICQoZ2l0IHJldi1wYXJzZSAtLXNob3J0IGZlYXR1cmUtYnJh
bmNoKSB0aGlyZCBjb21taXQNCi0JUmViYXNpbmcgKDEvMikke2NyfVJlYmFz
aW5nICgyLzIpJHtjcn1TdWNjZXNzZnVsbHkgcmViYXNlZCBhbmQgdXBkYXRl
ZCByZWZzL2hlYWRzL3JlYmFzZWQtZmVhdHVyZS1icmFuY2guDQotCUFwcGx5
aW5nIGF1dG9zdGFzaCByZXN1bHRlZCBpbiBjb25mbGljdHMuDQorCVJlYmFz
aW5nICgxLzIpUVJlYmFzaW5nICgyLzIpUUFwcGx5aW5nIGF1dG9zdGFzaCBy
ZXN1bHRlZCBpbiBjb25mbGljdHMuDQogCVlvdXIgY2hhbmdlcyBhcmUgc2Fm
ZSBpbiB0aGUgc3Rhc2guDQogCVlvdSBjYW4gcnVuICJnaXQgc3Rhc2ggcG9w
IiBvciAiZ2l0IHN0YXNoIGRyb3AiIGF0IGFueSB0aW1lLg0KKwlTdWNjZXNz
ZnVsbHkgcmViYXNlZCBhbmQgdXBkYXRlZCByZWZzL2hlYWRzL3JlYmFzZWQt
ZmVhdHVyZS1icmFuY2guDQogCUVPRg0KIH0NCiANCi0tIA0KMi4xMi4yLndp
bmRvd3MuMQ0KDQo=

--8323329-503763727-1497620990=:4200
Content-Type: text/x-diff; name=0004-fixup-sequencer-print-autostash-messages-to-stderr.patch
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.1.1706161549493.4200@virtualbox>
Content-Description: 
Content-Disposition: attachment; filename=0004-fixup-sequencer-print-autostash-messages-to-stderr.patch

RnJvbSAxMjhjNGE2NmFiMzQxM2IyMTM1MjY0ZjE3MDI0ZTFmNWU5MjUwZjAz
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogSm9oYW5uZXMgU2No
aW5kZWxpbiA8am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+DQpEYXRlOiBG
cmksIDE2IEp1biAyMDE3IDE1OjQwOjQ2ICswMjAwDQpTdWJqZWN0OiBbUEFU
Q0ggNC80XSBmaXh1cCEgc2VxdWVuY2VyOiBwcmludCBhdXRvc3Rhc2ggbWVz
c2FnZXMgdG8gc3RkZXJyDQoNClRoaXMgaXMgdGhlIGNvbXBhbmlvbiB0byB0
aGUgcHJvcG9zZWQgcGF0Y2gsIGJ1dCBJIGhhZCBubyB0aW1lIHRvIHZlcmlm
eQ0KdGhhdCB0aGUgdGVzdCBzdWl0ZSBzdGlsbCBwYXNzZXMgKGl0IG1heSBh
Y3R1YWxseSB0ZXN0IGZvciB0aGUgYnVnZ3kNCmJlaGF2aW9yLi4uKQ0KDQpT
aWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBTY2hpbmRlbGluIDxqb2hhbm5lcy5z
Y2hpbmRlbGluQGdteC5kZT4NCi0tLQ0KIGdpdC1yZWJhc2Uuc2ggfCA0ICsr
LS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZ2l0LXJlYmFzZS5zaCBiL2dpdC1y
ZWJhc2Uuc2gNCmluZGV4IGRiMWRlZWQ4NDY0Li4yY2Y3M2I4OGU4ZSAxMDA3
NTUNCi0tLSBhL2dpdC1yZWJhc2Uuc2gNCisrKyBiL2dpdC1yZWJhc2Uuc2gN
CkBAIC0xNjYsMTQgKzE2NiwxNCBAQCBhcHBseV9hdXRvc3Rhc2ggKCkgew0K
IAkJc3Rhc2hfc2hhMT0kKGNhdCAiJHN0YXRlX2Rpci9hdXRvc3Rhc2giKQ0K
IAkJaWYgZ2l0IHN0YXNoIGFwcGx5ICRzdGFzaF9zaGExIDI+JjEgPi9kZXYv
bnVsbA0KIAkJdGhlbg0KLQkJCWVjaG8gIiQoZ2V0dGV4dCAnQXBwbGllZCBh
dXRvc3Rhc2guJykiDQorCQkJZWNobyAiJChnZXR0ZXh0ICdBcHBsaWVkIGF1
dG9zdGFzaC4nKSIgPiYyDQogCQllbHNlDQogCQkJZ2l0IHN0YXNoIHN0b3Jl
IC1tICJhdXRvc3Rhc2giIC1xICRzdGFzaF9zaGExIHx8DQogCQkJZGllICIk
KGV2YWxfZ2V0dGV4dCAiQ2Fubm90IHN0b3JlIFwkc3Rhc2hfc2hhMSIpIg0K
IAkJCWdldHRleHQgJ0FwcGx5aW5nIGF1dG9zdGFzaCByZXN1bHRlZCBpbiBj
b25mbGljdHMuDQogWW91ciBjaGFuZ2VzIGFyZSBzYWZlIGluIHRoZSBzdGFz
aC4NCiBZb3UgY2FuIHJ1biAiZ2l0IHN0YXNoIHBvcCIgb3IgImdpdCBzdGFz
aCBkcm9wIiBhdCBhbnkgdGltZS4NCi0nDQorJyA+JjINCiAJCWZpDQogCWZp
DQogfQ0KLS0gDQoyLjEyLjIud2luZG93cy4xDQoNCg==

--8323329-503763727-1497620990=:4200--
