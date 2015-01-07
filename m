From: Michael Paquier <michael.paquier@gmail.com>
Subject: Tab completion missing for --includes and branch description in git config
Date: Wed, 7 Jan 2015 09:58:27 +0900
Message-ID: <CAB7nPqRnDTEXWEDUHX7xJG_+QvoXdt2aA6RLRn4Hiq-rOZMEmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c0f4bee0c72c050c056b6f
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 07 01:59:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8exF-0008F2-S5
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 01:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbbAGA63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 19:58:29 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:55032 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbbAGA62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 19:58:28 -0500
Received: by mail-qa0-f49.google.com with SMTP id dc16so824972qab.8
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 16:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=8nUpPZIOZ9CA3AbXZTAa0J8LzDVXooTBnAXIqlehwh4=;
        b=BNOyvonLj1n9iTSsT+v88PtYfHaYdpqPifiJ57ATRbv31/AYlPwo/8OrpDLvyfIBON
         JpbJt7KDP30EdeAKNbMBTjS005bfx3Om6iHwU08zlb/GYlNnd5isEIYKggaCpVDnq21d
         mE5KhKfftwFDBINGq5XfwrRJ4d1V8HAo9HHrBPGE4ZzWMadkvQaxju0+knIllaseBf85
         d/lw6UfhtF62j1GQIK7esU70i9RaDhtgzHL9TymrTOEWLT1JnGT510o7kvfR0jWYRvMU
         s+bCNAFLSm6jwUgE0wBKWGhhRQVhW0PP1B/X8Rl+rplbfPHfjN5daKw2mkLK4LytR+D3
         gXmQ==
X-Received: by 10.140.83.100 with SMTP id i91mr258273qgd.97.1420592307807;
 Tue, 06 Jan 2015 16:58:27 -0800 (PST)
Received: by 10.140.86.234 with HTTP; Tue, 6 Jan 2015 16:58:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262119>

--001a11c0f4bee0c72c050c056b6f
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

While toying with the tab completion script for bash, I found a couple
of things missing that cannot be completed:
- git config --includes
- git config branch.$BRANCH_NAME.description
Attached are trivial patches based on master to fix those things.
Regards,
-- 
Michael

--001a11c0f4bee0c72c050c056b6f
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Identify-includes-for-git-config-in-tab-completion.patch"
Content-Disposition: attachment; 
	filename="0001-Identify-includes-for-git-config-in-tab-completion.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i4lzycph0

RnJvbSBjYzQ2Mzk3NWU0YTIxZGM1MjNmYTkyMGRiODEzZWFkYTg4MWEwY2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWNoYWVsIFBhcXVpZXIgPG1pY2hhZWxAb3RhY29vLmNvbT4K
RGF0ZTogV2VkLCA3IEphbiAyMDE1IDA5OjQzOjI5ICswOTAwClN1YmplY3Q6IFtQQVRDSCAxLzJd
IElkZW50aWZ5IC0taW5jbHVkZXMgZm9yIGdpdCBjb25maWcgaW4gdGFiIGNvbXBsZXRpb24KClNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgUGFxdWllciA8bWljaGFlbEBvdGFjb28uY29tPgotLS0KIGNv
bnRyaWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoIHwgMiArLQogMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvY29udHJpYi9j
b21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2ggYi9jb250cmliL2NvbXBsZXRpb24vZ2l0LWNv
bXBsZXRpb24uYmFzaAppbmRleCAyMzk4OGVjLi5kNmIwNzU0IDEwMDY0NAotLS0gYS9jb250cmli
L2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaAorKysgYi9jb250cmliL2NvbXBsZXRpb24v
Z2l0LWNvbXBsZXRpb24uYmFzaApAQCAtMTg5MSw3ICsxODkxLDcgQEAgX2dpdF9jb25maWcgKCkK
IAktLSopCiAJCV9fZ2l0Y29tcCAiCiAJCQktLXN5c3RlbSAtLWdsb2JhbCAtLWxvY2FsIC0tZmls
ZT0KLQkJCS0tbGlzdCAtLXJlcGxhY2UtYWxsCisJCQktLWluY2x1ZGVzIC0tbGlzdCAtLXJlcGxh
Y2UtYWxsCiAJCQktLWdldCAtLWdldC1hbGwgLS1nZXQtcmVnZXhwCiAJCQktLWFkZCAtLXVuc2V0
IC0tdW5zZXQtYWxsCiAJCQktLXJlbW92ZS1zZWN0aW9uIC0tcmVuYW1lLXNlY3Rpb24KLS0gCjIu
Mi4xCgo=
--001a11c0f4bee0c72c050c056b6f
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0002-Identify-description-for-git-config-in-tab-completio.patch"
Content-Disposition: attachment; 
	filename="0002-Identify-description-for-git-config-in-tab-completio.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i4lzycpz1

RnJvbSBjMjMyM2QwOTNiM2EzYTlkYWYwY2Y3ZTE3ZGRkZmY2YmMwMjhiZDBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWNoYWVsIFBhcXVpZXIgPG1pY2hhZWxAb3RhY29vLmNvbT4K
RGF0ZTogV2VkLCA3IEphbiAyMDE1IDA5OjQ4OjEwICswOTAwClN1YmplY3Q6IFtQQVRDSCAyLzJd
IElkZW50aWZ5IGRlc2NyaXB0aW9uIGZvciBnaXQgY29uZmlnIGluIHRhYiBjb21wbGV0aW9uCgpT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFBhcXVpZXIgPG1pY2hhZWxAb3RhY29vLmNvbT4KLS0tCiBj
b250cmliL2NvbXBsZXRpb24vZ2l0LWNvbXBsZXRpb24uYmFzaCB8IDQgKysrLQogMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2NvbnRy
aWIvY29tcGxldGlvbi9naXQtY29tcGxldGlvbi5iYXNoIGIvY29udHJpYi9jb21wbGV0aW9uL2dp
dC1jb21wbGV0aW9uLmJhc2gKaW5kZXggZDZiMDc1NC4uNDEyZjc0YiAxMDA2NDQKLS0tIGEvY29u
dHJpYi9jb21wbGV0aW9uL2dpdC1jb21wbGV0aW9uLmJhc2gKKysrIGIvY29udHJpYi9jb21wbGV0
aW9uL2dpdC1jb21wbGV0aW9uLmJhc2gKQEAgLTE5MDAsNyArMTkwMCw5IEBAIF9naXRfY29uZmln
ICgpCiAJCTs7CiAJYnJhbmNoLiouKikKIAkJbG9jYWwgcGZ4PSIke2N1ciUuKn0uIiBjdXJfPSIk
e2N1ciMjKi59IgotCQlfX2dpdGNvbXAgInJlbW90ZSBwdXNocmVtb3RlIG1lcmdlIG1lcmdlb3B0
aW9ucyByZWJhc2UiICIkcGZ4IiAiJGN1cl8iCisJCV9fZ2l0Y29tcCAiCisJCQlkZXNjcmlwdGlv
biByZW1vdGUgcHVzaHJlbW90ZSBtZXJnZSBtZXJnZW9wdGlvbnMgcmViYXNlCisJCQkiICIkcGZ4
IiAiJGN1cl8iCiAJCXJldHVybgogCQk7OwogCWJyYW5jaC4qKQotLSAKMi4yLjEKCg==
--001a11c0f4bee0c72c050c056b6f--
