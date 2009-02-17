From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/8] config: Use parseopt.
Date: Tue, 17 Feb 2009 12:35:07 +0200
Message-ID: <94a0d4530902170235g4e481e07t39a6157894dff9aa@mail.gmail.com>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
	 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
	 <1234832094-15541-3-git-send-email-felipe.contreras@gmail.com>
	 <7vab8laa7p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd2999c67b8b804631adb95
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZNJi-0002Dq-Fm
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbZBQKfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbZBQKfN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:35:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:54577 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZBQKfL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:35:11 -0500
Received: by fg-out-1718.google.com with SMTP id 16so371729fgg.17
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 02:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=cVBeH9FGO3rubopMLAaXwUweDKdV4ymV5xFajzpch9Y=;
        b=WqYwSjFg6B+9B8e5BYQkU7zVdFtc+7q8kvS9RVi3liZZkGpE7JMeahIy8MdZtvyqWL
         UBnpAd2QmUCQiPQtTRxt41j5deJSl5ps8lXMx7Ai2Q9vldC2xBQytO6Abq2wI7AXeelJ
         bxpYRofbR1SqMF4JL3avcsnabWhojub031w0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZssXfjlP4UPXQ1XgIa8FBAwt3oXUFFMTvP06vPhI+lvrsB9Fd0L2GHcm5WMDIQHXnT
         i9ubAOwVKdJfdMxOv4LaOKAW8itQwTWlmgXei/7AZjbJ4MR/Lm2rO4Qy51TLQVXfx9WY
         clzrXpfpIYa/DP+WXhKdfXnKXx/QPrfVAH7uc=
Received: by 10.86.71.1 with SMTP id t1mr146190fga.27.1234866908149; Tue, 17 
	Feb 2009 02:35:08 -0800 (PST)
In-Reply-To: <7vab8laa7p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110352>

--000e0cd2999c67b8b804631adb95
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Feb 17, 2009 at 7:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I've queued the entire series on top of fc/config-editor topic and even
> merged the result in 'pu' once, but I had to reintegrate 'pu' without the
> series.
>
> Before this commit, t/t1300-repo-config.sh passes, but this one breaks
> the test.

Ah, I didn't know there was a test for that.

I've fixed most the issues but unfortunately parseopt barfs when -1 is
used as an argument. That should be fixed somehow, otherwise this
patch will never pass the test.

I'm attaching a patch that makes the test pass (for review), but
shouldn't be merged.

-- 
Felipe Contreras

--000e0cd2999c67b8b804631adb95
Content-Type: application/octet-stream; 
	name="0001-config-Fixes-parseopt-for-t1300-repo-config.patch"
Content-Disposition: attachment; 
	filename="0001-config-Fixes-parseopt-for-t1300-repo-config.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frafuu3o0

RnJvbSAyMmU0ZDFhNDcyMDI3ZDJiN2Y2NTBhOTlmNDg3ZmVmNzhlZjNiOGFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdt
YWlsLmNvbT4KRGF0ZTogVHVlLCAxNyBGZWIgMjAwOSAxMjozMDoyNiArMDIwMApTdWJqZWN0OiBb
Tk9NRVJHRS9QQVRDSF0gY29uZmlnOiBGaXhlcyBwYXJzZW9wdCBmb3IgdDEzMDAtcmVwby1jb25m
aWcuCgpUaGlzIGlzIHBhdGNoIGlzbid0IG1lYW50IGZvciBtZXJnaW5nLCBqdXN0IGZvciByZXZp
ZXcuCgpJZGVhbGx5IHBhcnNlb3B0IHNob3VsZG4ndCBmYWlsIHdpdGggLTEgYXMgYW4gYXJndW1l
bnQuCgpTaWduZWQtb2ZmLWJ5OiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdt
YWlsLmNvbT4KLS0tCiBidWlsdGluLWNvbmZpZy5jICAgICAgIHwgICAxOCArKysrKysrKysrKysr
KystLS0KIHQvdDEzMDAtcmVwby1jb25maWcuc2ggfCAgICA4ICsrKystLS0tCiAyIGZpbGVzIGNo
YW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVp
bHRpbi1jb25maWcuYyBiL2J1aWx0aW4tY29uZmlnLmMKaW5kZXggMDg0MjIyYS4uMTlmMjc0YSAx
MDA2NDQKLS0tIGEvYnVpbHRpbi1jb25maWcuYworKysgYi9idWlsdGluLWNvbmZpZy5jCkBAIC0z
OCw2ICszOCw4IEBAIHN0YXRpYyBpbnQgZW5kX251bGw7CiAjZGVmaW5lIEFDVElPTl9SRU1PVkVf
U0VDVElPTiAoMTw8OCkKICNkZWZpbmUgQUNUSU9OX0xJU1QgKDE8PDkpCiAjZGVmaW5lIEFDVElP
Tl9FRElUICgxPDwxMCkKKyNkZWZpbmUgQUNUSU9OX1NFVCAoMTw8MTEpCisjZGVmaW5lIEFDVElP
Tl9TRVRfQUxMICgxPDwxMikKIAogc3RhdGljIHN0cnVjdCBvcHRpb24gYnVpbHRpbl9jb25maWdf
b3B0aW9uc1tdID0gewogCU9QVF9HUk9VUCgiQ29uZmlnIGZpbGUgbG9jYXRpb24iKSwKQEAgLTQ2
LDcgKzQ4LDcgQEAgc3RhdGljIHN0cnVjdCBvcHRpb24gYnVpbHRpbl9jb25maWdfb3B0aW9uc1td
ID0gewogCU9QVF9TVFJJTkcoJ2YnLCAiZmlsZSIsICZnaXZlbl9jb25maWdfZmlsZSwgIkZJTEUi
LCAidXNlIGdpdmVuIGNvbmZpZyBmaWxlIiksCiAJT1BUX0dST1VQKCJBY3Rpb24iKSwKIAlPUFRf
QklUKDAsICJnZXQiLCAmYWN0aW9ucywgImdldCB2YWx1ZTogbmFtZSBbdmFsdWUtcmVnZXhdIiwg
QUNUSU9OX0dFVCksCi0JT1BUX0JJVCgwLCAiZ2V0LWFsbCIsICZhY3Rpb25zLCAiZ2V0IGFsbCB2
YWx1ZXM6IGtleSBbdmFsdWUtcmVnZXhdIiwgQUNUSU9OX0dFVCksCisJT1BUX0JJVCgwLCAiZ2V0
LWFsbCIsICZhY3Rpb25zLCAiZ2V0IGFsbCB2YWx1ZXM6IGtleSBbdmFsdWUtcmVnZXhdIiwgQUNU
SU9OX0dFVF9BTEwpLAogCU9QVF9CSVQoMCwgImdldC1yZWdleHAiLCAmYWN0aW9ucywgImdldCB2
YWx1ZXMgZm9yIHJlZ2V4cDogbmFtZS1yZWdleCBbdmFsdWUtcmVnZXhdIiwgQUNUSU9OX0dFVF9S
RUdFWFApLAogCU9QVF9CSVQoMCwgInJlcGxhY2UtYWxsIiwgJmFjdGlvbnMsICJyZXBsYWNlIGFs
bCBtYXRjaGluZyB2YXJpYWJsZXM6IG5hbWUgW3ZhbHVlIFt2YWx1ZV9yZWdleF0iLCBBQ1RJT05f
UkVQTEFDRV9BTEwpLAogCU9QVF9CSVQoMCwgImFkZCIsICZhY3Rpb25zLCAiYWRkcyBhIG5ldyB2
YXJpYWJsZTogbmFtZSB2YWx1ZSIsIEFDVElPTl9BREQpLApAQCAtMzQzLDggKzM0NSw4IEBAIGlu
dCBjbWRfY29uZmlnKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqdW51
c2VkX3ByZWZpeCkKIAlpZiAoYWN0aW9ucyA9PSAwKQogCQlzd2l0Y2ggKGFyZ2MpIHsKIAkJY2Fz
ZSAxOiBhY3Rpb25zIHw9IEFDVElPTl9HRVQ7IGJyZWFrOwotCQljYXNlIDI6IGFjdGlvbnMgfD0g
QUNUSU9OX0FERDsgYnJlYWs7Ci0JCWNhc2UgMzogYWN0aW9ucyB8PSBBQ1RJT05fUkVQTEFDRV9B
TEw7IGJyZWFrOworCQljYXNlIDI6IGFjdGlvbnMgfD0gQUNUSU9OX1NFVDsgYnJlYWs7CisJCWNh
c2UgMzogYWN0aW9ucyB8PSBBQ1RJT05fU0VUX0FMTDsgYnJlYWs7CiAJCWRlZmF1bHQ6CiAJCQl1
c2FnZV93aXRoX29wdGlvbnMoYnVpbHRpbl9jb25maWdfdXNhZ2UsIGJ1aWx0aW5fY29uZmlnX29w
dGlvbnMpOwogCQl9CkBAIC0zNjIsNiArMzY0LDE2IEBAIGludCBjbWRfY29uZmlnKGludCBhcmdj
LCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqdW51c2VkX3ByZWZpeCkKIAkJZ2l0X2Nv
bmZpZyhnaXRfZGVmYXVsdF9jb25maWcsIE5VTEwpOwogCQlsYXVuY2hfZWRpdG9yKGNvbmZpZ19m
aWxlbmFtZSwgTlVMTCwgTlVMTCk7CiAJfQorCWVsc2UgaWYgKGFjdGlvbnMgJiBBQ1RJT05fU0VU
KSB7CisJCWNoZWNrX2FyZ2MoYXJnYywgMiwgMik7CisJCXZhbHVlID0gbm9ybWFsaXplX3ZhbHVl
KGFyZ3ZbMF0sIGFyZ3ZbMV0pOworCQlyZXR1cm4gZ2l0X2NvbmZpZ19zZXQoYXJndlswXSwgdmFs
dWUpOworCX0KKwllbHNlIGlmIChhY3Rpb25zICYgQUNUSU9OX1NFVF9BTEwpIHsKKwkJY2hlY2tf
YXJnYyhhcmdjLCAyLCAzKTsKKwkJdmFsdWUgPSBub3JtYWxpemVfdmFsdWUoYXJndlswXSwgYXJn
dlsxXSk7CisJCXJldHVybiBnaXRfY29uZmlnX3NldF9tdWx0aXZhcihhcmd2WzBdLCB2YWx1ZSwg
YXJndlsyXSwgMCk7CisJfQogCWVsc2UgaWYgKGFjdGlvbnMgJiBBQ1RJT05fQUREKSB7CiAJCWNo
ZWNrX2FyZ2MoYXJnYywgMiwgMik7CiAJCXZhbHVlID0gbm9ybWFsaXplX3ZhbHVlKGFyZ3ZbMF0s
IGFyZ3ZbMV0pOwpkaWZmIC0tZ2l0IGEvdC90MTMwMC1yZXBvLWNvbmZpZy5zaCBiL3QvdDEzMDAt
cmVwby1jb25maWcuc2gKaW5kZXggMTFiODJmNC4uYmU3MTA0ZCAxMDA3NTUKLS0tIGEvdC90MTMw
MC1yZXBvLWNvbmZpZy5zaAorKysgYi90L3QxMzAwLXJlcG8tY29uZmlnLnNoCkBAIC01MjgsNyAr
NTI4LDcgQEAgRU9GCiB0ZXN0X2V4cGVjdF9zdWNjZXNzIGJvb2wgJwogCiAJZ2l0IGNvbmZpZyBi
b29sLnRydWUxIDAxICYmCi0JZ2l0IGNvbmZpZyBib29sLnRydWUyIC0xICYmCisJZ2l0IGNvbmZp
ZyBib29sLnRydWUyIC0tIC0xICYmCiAJZ2l0IGNvbmZpZyBib29sLnRydWUzIFllUyAmJgogCWdp
dCBjb25maWcgYm9vbC50cnVlNCB0cnVlICYmCiAJZ2l0IGNvbmZpZyBib29sLmZhbHNlMSAwMDAg
JiYKQEAgLTU2OSw3ICs1NjksNyBAQCBFT0YKIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJ3NldCAtLWJv
b2wnICcKIAogCWdpdCBjb25maWcgLS1ib29sIGJvb2wudHJ1ZTEgMDEgJiYKLQlnaXQgY29uZmln
IC0tYm9vbCBib29sLnRydWUyIC0xICYmCisJZ2l0IGNvbmZpZyAtLWJvb2wgYm9vbC50cnVlMiAt
LSAtMSAmJgogCWdpdCBjb25maWcgLS1ib29sIGJvb2wudHJ1ZTMgWWVTICYmCiAJZ2l0IGNvbmZp
ZyAtLWJvb2wgYm9vbC50cnVlNCB0cnVlICYmCiAJZ2l0IGNvbmZpZyAtLWJvb2wgYm9vbC5mYWxz
ZTEgMDAwICYmCkBAIC01OTAsNyArNTkwLDcgQEAgRU9GCiB0ZXN0X2V4cGVjdF9zdWNjZXNzICdz
ZXQgLS1pbnQnICcKIAogCWdpdCBjb25maWcgLS1pbnQgaW50LnZhbDEgMDEgJiYKLQlnaXQgY29u
ZmlnIC0taW50IGludC52YWwyIC0xICYmCisJZ2l0IGNvbmZpZyAtLWludCBpbnQudmFsMiAtLSAt
MSAmJgogCWdpdCBjb25maWcgLS1pbnQgaW50LnZhbDMgNW0gJiYKIAljbXAgZXhwZWN0IC5naXQv
Y29uZmlnJwogCkBAIC02NDgsNyArNjQ4LDcgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyAnc2V0IC0t
Ym9vbC1vci1pbnQnICcKIAlnaXQgY29uZmlnIC0tYm9vbC1vci1pbnQgYm9vbC5mYWxzZTIgbm8g
JiYKIAlnaXQgY29uZmlnIC0tYm9vbC1vci1pbnQgaW50LmludDEgMCAmJgogCWdpdCBjb25maWcg
LS1ib29sLW9yLWludCBpbnQuaW50MiAxICYmCi0JZ2l0IGNvbmZpZyAtLWJvb2wtb3ItaW50IGlu
dC5pbnQzIC0xICYmCisJZ2l0IGNvbmZpZyAtLWJvb2wtb3ItaW50IGludC5pbnQzIC0tIC0xICYm
CiAJdGVzdF9jbXAgZXhwZWN0IC5naXQvY29uZmlnCiAnCiAKLS0gCjEuNi4xLjMKCg==
--000e0cd2999c67b8b804631adb95--
