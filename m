From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Merging limitations after directory renames -- interesting test repo
Date: Fri, 18 Feb 2011 17:20:24 -0800
Message-ID: <AANLkTi=b1Ez9-jQbxCR1KwqVwn=hw4iKRwmRBkK3bULf@mail.gmail.com>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net> <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
 <AANLkTimuU4A7sUqo-dpW3ch4H_WJg+G2ynNmagx=C9t8@mail.gmail.com>
 <7vsjvkn8vh.fsf@alter.siamese.dyndns.org> <AANLkTimK0K=khbPk22Fpo99i02y1gdsSgMqWcRgXWe4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30549e638d9339049c987072
Cc: Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 02:21:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqbVg-0006CV-Vw
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 02:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab1BSBVR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 20:21:17 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39061 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753362Ab1BSBVP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 20:21:15 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p1J1KjJk014826
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 18 Feb 2011 17:20:46 -0800
Received: by iwn8 with SMTP id 8so24104iwn.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 17:20:44 -0800 (PST)
Received: by 10.42.223.73 with SMTP id ij9mr1658625icb.442.1298078444130; Fri,
 18 Feb 2011 17:20:44 -0800 (PST)
Received: by 10.231.16.129 with HTTP; Fri, 18 Feb 2011 17:20:24 -0800 (PST)
In-Reply-To: <AANLkTimK0K=khbPk22Fpo99i02y1gdsSgMqWcRgXWe4w@mail.gmail.com>
X-Spam-Status: No, hits=-102.961 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167246>

--20cf30549e638d9339049c987072
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Feb 18, 2011 at 5:03 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It also fixes one of the tests that depended on the "find copies"
> behavior for its result to actually ask for copies now that we don't
> give them unless you do.

Gahh. Here's all of them - there were six cases.

                     Linus

--20cf30549e638d9339049c987072
Content-Type: text/x-patch; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gkbu9s441

IHQvdDQwMDMtZGlmZi1yZW5hbWUtMS5zaCAgICAgICB8ICAgIDIgKy0KIHQvdDQwMDQtZGlmZi1y
ZW5hbWUtc3ltbGluay5zaCB8ICAgIDIgKy0KIHQvdDQwMDUtZGlmZi1yZW5hbWUtMi5zaCAgICAg
ICB8ICAgIDIgKy0KIHQvdDQwMDgtZGlmZi1icmVhay1yZXdyaXRlLnNoICB8ICAgIDQgKystLQog
dC90NDAwOS1kaWZmLXJlbmFtZS00LnNoICAgICAgIHwgICAgMiArLQogNSBmaWxlcyBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdC90NDAwMy1k
aWZmLXJlbmFtZS0xLnNoIGIvdC90NDAwMy1kaWZmLXJlbmFtZS0xLnNoCmluZGV4IGM2MTMwYzQu
LmJmYTg4MzUgMTAwNzU1Ci0tLSBhL3QvdDQwMDMtZGlmZi1yZW5hbWUtMS5zaAorKysgYi90L3Q0
MDAzLWRpZmYtcmVuYW1lLTEuc2gKQEAgLTI5LDcgKzI5LDcgQEAgdGVzdF9leHBlY3Rfc3VjY2Vz
cyBcCiAjIGNvcHktYW5kLWVkaXQgb25lLCBhbmQgcmVuYW1lLWFuZC1lZGl0IHRoZSBvdGhlci4g
IFdlIGRvIG5vdCBzYXkKICMgYW55dGhpbmcgYWJvdXQgcmV6cm92LgogCi1HSVRfRElGRl9PUFRT
PS0tdW5pZmllZD0wIGdpdCBkaWZmLWluZGV4IC1NIC1wICR0cmVlID5jdXJyZW50CitHSVRfRElG
Rl9PUFRTPS0tdW5pZmllZD0wIGdpdCBkaWZmLWluZGV4IC1DIC1wICR0cmVlID5jdXJyZW50CiBj
YXQgPmV4cGVjdGVkIDw8XEVPRgogZGlmZiAtLWdpdCBhL0NPUFlJTkcgYi9DT1BZSU5HLjEKIGNv
cHkgZnJvbSBDT1BZSU5HCmRpZmYgLS1naXQgYS90L3Q0MDA0LWRpZmYtcmVuYW1lLXN5bWxpbmsu
c2ggYi90L3Q0MDA0LWRpZmYtcmVuYW1lLXN5bWxpbmsuc2gKaW5kZXggOTJhNjVmNC4uNmU1NjJj
OCAxMDA3NTUKLS0tIGEvdC90NDAwNC1kaWZmLXJlbmFtZS1zeW1saW5rLnNoCisrKyBiL3QvdDQw
MDQtZGlmZi1yZW5hbWUtc3ltbGluay5zaApAQCAtMzUsNyArMzUsNyBAQCB0ZXN0X2V4cGVjdF9z
dWNjZXNzIFNZTUxJTktTIFwKICMgYSBuZXcgY3JlYXRpb24uCiAKIHRlc3RfZXhwZWN0X3N1Y2Nl
c3MgU1lNTElOS1MgJ3NldHVwIGRpZmYgb3V0cHV0JyAiCi0gICAgR0lUX0RJRkZfT1BUUz0tLXVu
aWZpZWQ9MCBnaXQgZGlmZi1pbmRleCAtTSAtcCAkdHJlZSA+Y3VycmVudCAmJgorICAgIEdJVF9E
SUZGX09QVFM9LS11bmlmaWVkPTAgZ2l0IGRpZmYtaW5kZXggLUMgLXAgJHRyZWUgPmN1cnJlbnQg
JiYKICAgICBjYXQgPmV4cGVjdGVkIDw8XEVPRgogZGlmZiAtLWdpdCBhL2JvemJhciBiL2JvemJh
cgogbmV3IGZpbGUgbW9kZSAxMjAwMDAKZGlmZiAtLWdpdCBhL3QvdDQwMDUtZGlmZi1yZW5hbWUt
Mi5zaCBiL3QvdDQwMDUtZGlmZi1yZW5hbWUtMi5zaAppbmRleCAxYmEzNTlkLi43N2Q3ZjQ5IDEw
MDc1NQotLS0gYS90L3Q0MDA1LWRpZmYtcmVuYW1lLTIuc2gKKysrIGIvdC90NDAwNS1kaWZmLXJl
bmFtZS0yLnNoCkBAIC0yOSw3ICsyOSw3IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAogIyBhbmQg
Q09QWUlORy4yIGFyZSBiYXNlZCBvbiBDT1BZSU5HLCBhbmQgZG8gbm90IHNheSBhbnl0aGluZyBh
Ym91dAogIyByZXpyb3YuCiAKLWdpdCBkaWZmLWluZGV4IC1NICR0cmVlID5jdXJyZW50CitnaXQg
ZGlmZi1pbmRleCAtQyAkdHJlZSA+Y3VycmVudAogCiBjYXQgPmV4cGVjdGVkIDw8XEVPRgogOjEw
MDY0NCAxMDA2NDQgNmZmODdjNDY2NDk4MWU0Mzk3NjI1NzkxYzhlYTNiYmI1ZjIyNzlhMyAwNjAz
YjMyMzhhMDc2ZGM2YzgwMjJhZWRjNjY0OGZhNTIzYTE3MTc4IEMxMjM0CUNPUFlJTkcJQ09QWUlO
Ry4xCmRpZmYgLS1naXQgYS90L3Q0MDA4LWRpZmYtYnJlYWstcmV3cml0ZS5zaCBiL3QvdDQwMDgt
ZGlmZi1icmVhay1yZXdyaXRlLnNoCmluZGV4IGQ3OWQ5ZTFlLi43M2I0YTI0IDEwMDc1NQotLS0g
YS90L3Q0MDA4LWRpZmYtYnJlYWstcmV3cml0ZS5zaAorKysgYi90L3Q0MDA4LWRpZmYtYnJlYWst
cmV3cml0ZS5zaApAQCAtMTczLDggKzE3Myw4IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAogICAg
ICdjb21wYXJlX2RpZmZfcmF3IGV4cGVjdGVkIGN1cnJlbnQnCiAKIHRlc3RfZXhwZWN0X3N1Y2Nl
c3MgXAotICAgICdydW4gZGlmZiB3aXRoIC1CIC1NJyBcCi0gICAgJ2dpdCBkaWZmLWluZGV4IC1C
IC1NICIkdHJlZSIgPmN1cnJlbnQnCisgICAgJ3J1biBkaWZmIHdpdGggLUIgLUMnIFwKKyAgICAn
Z2l0IGRpZmYtaW5kZXggLUIgLUMgIiR0cmVlIiA+Y3VycmVudCcKIAogY2F0ID5leHBlY3RlZCA8
PFxFT0YKIDoxMDA2NDQgMTAwNjQ0IGY1ZGVhYzdiZTU5ZTdlZWFiODY1N2ZkOWFlNzA2ZmQ2YTU3
ZGFlZDIgMDhiYjJmYjY3MWRlZmY0YzAzYTRkNGEwYTEzMTVkZmY5OGQ1NzMyYyBDMDk1CWZpbGUw
CWZpbGUxCmRpZmYgLS1naXQgYS90L3Q0MDA5LWRpZmYtcmVuYW1lLTQuc2ggYi90L3Q0MDA5LWRp
ZmYtcmVuYW1lLTQuc2gKaW5kZXggZGUzZjE3NC4uZjIyYzhlMyAxMDA3NTUKLS0tIGEvdC90NDAw
OS1kaWZmLXJlbmFtZS00LnNoCisrKyBiL3QvdDQwMDktZGlmZi1yZW5hbWUtNC5zaApAQCAtMjks
NyArMjksNyBAQCB0ZXN0X2V4cGVjdF9zdWNjZXNzIFwKICMgYW5kIENPUFlJTkcuMiBhcmUgYmFz
ZWQgb24gQ09QWUlORywgYW5kIGRvIG5vdCBzYXkgYW55dGhpbmcgYWJvdXQKICMgcmV6cm92Lgog
Ci1naXQgZGlmZi1pbmRleCAteiAtTSAkdHJlZSA+Y3VycmVudAorZ2l0IGRpZmYtaW5kZXggLXog
LUMgJHRyZWUgPmN1cnJlbnQKIAogY2F0ID5leHBlY3RlZCA8PFxFT0YKIDoxMDA2NDQgMTAwNjQ0
IDZmZjg3YzQ2NjQ5ODFlNDM5NzYyNTc5MWM4ZWEzYmJiNWYyMjc5YTMgMDYwM2IzMjM4YTA3NmRj
NmM4MDIyYWVkYzY2NDhmYTUyM2ExNzE3OCBDMTIzNAo=
--20cf30549e638d9339049c987072--
