From: "Eric Mertens" <emertens@gmail.com>
Subject: Correction for post-receive-email
Date: Fri, 5 Oct 2007 00:14:14 -0700
Message-ID: <449c8cfc0710050014j9bbf057ka108ee27dea49a89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1254_6412380.1191568454374"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:14:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdhOD-0003QM-AM
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 09:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXJEHOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 03:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbXJEHOP
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 03:14:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:14053 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbXJEHOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 03:14:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so519861wah
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=jwWeJlFrZtrAcUfngplHQIh1ERQREI4ZMB17iX9FvRE=;
        b=fVOsCY+GetehALV6tp7z5qK2ppS4Da/pH73GRyCpOo5X/2OxqNMT07AiB2tTd9j5rvWehKtDdK7ZIrggWXJ9g7UKfmV1zMnnTa/x3EGa4iceV8ZMSyV+c7EliKfnbnUgOFhAcm+kzY2xVzRQbcR9CiagC3WwRUIqkDN/UNx8yQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=OAqIrYmONLkdYu77idA3/c519OFVLYaiAqFuYLOmTRQpxvNiliwuPwoVlJpuhSiYPKYSEz6ltbUGwap6oSn5vpN81y5a6mPfK93B28ATsYB3tPWCRUiYMUR8JPioLTWa42jJmGb13ddJhwMRftw+E4GVaP1wl4D9kR+CWANshDA=
Received: by 10.114.169.2 with SMTP id r2mr10949435wae.1191568454383;
        Fri, 05 Oct 2007 00:14:14 -0700 (PDT)
Received: by 10.114.36.13 with HTTP; Fri, 5 Oct 2007 00:14:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60041>

------=_Part_1254_6412380.1191568454374
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

(My apologies if my incorrectly addressed subscribe message went to the list)

I noticed that my mutt wasn't correctly detecting the signature block
on the end of the automated emails I was receiving from the script in
contrib. I've made this trivial change in my local copy of the script,
but I figured that if I was going to be modifying the source code I
should share my changes.

-- 
Eric Mertens

------=_Part_1254_6412380.1191568454374
Content-Type: text/x-patch;
 name="0001-Correct-signature-block-delimiter-in-post-receive-em.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Correct-signature-block-delimiter-in-post-receive-em.patch"
X-Attachment-Id: f_f7ed121u

RnJvbSAxMTlmODRmYTZmNmJiMzNjNmZjNTI0YWI0Mjc3ZDM4YmViYzEwNDY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIE1lcnRlbnMgPGVtZXJ0ZW5zQGdtYWlsLmNvbT4KRGF0
ZTogRnJpLCA1IE9jdCAyMDA3IDAwOjA2OjUyIC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gQ29ycmVj
dCBzaWduYXR1cmUgYmxvY2sgZGVsaW1pdGVyIGluIHBvc3QtcmVjZWl2ZS1lbWFpbCBieSBhZGRp
bmcgYSB0cmFpbGluZyBzcGFjZQoKVGhpcyBjaGFuZ2UgYWxsb3dzIG1haWwgY2xpZW50cyBsaWtl
IE11dHQgdG8gZWFzaWx5IGRldGVjdCB0aGUgc2lnbmF0dXJlCmFuZCBpcyBjb25zaXN0ZW50IHdp
dGggdGhlIHNpZ25hdHVyZSBibG9jayBhcnRpY2xlIG9uIFdpa2lwZWRpYS4KLS0tCiBjb250cmli
L2hvb2tzL3Bvc3QtcmVjZWl2ZS1lbWFpbCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2NvbnRyaWIvaG9va3Mv
cG9zdC1yZWNlaXZlLWVtYWlsIGIvY29udHJpYi9ob29rcy9wb3N0LXJlY2VpdmUtZW1haWwKaW5k
ZXggY2JiZDAyZi4uODI4NjUxYSAxMDA2NDQKLS0tIGEvY29udHJpYi9ob29rcy9wb3N0LXJlY2Vp
dmUtZW1haWwKKysrIGIvY29udHJpYi9ob29rcy9wb3N0LXJlY2VpdmUtZW1haWwKQEAgLTE5OCw3
ICsxOTgsNyBAQCBnZW5lcmF0ZV9lbWFpbF9mb290ZXIoKQogCiAKIAlob29rcy9wb3N0LXJlY2Vp
dmUKLQktLQorCS0tIAogCSRwcm9qZWN0ZGVzYwogCUVPRgogfQotLSAKMS41LjMuNAoK
------=_Part_1254_6412380.1191568454374--
