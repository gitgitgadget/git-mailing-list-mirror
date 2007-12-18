From: "Hannes Eder" <hannes.eder@gmail.com>
Subject: [PATCH] allow a single form feed in pre commit hook
Date: Tue, 18 Dec 2007 10:47:27 +0100
Message-ID: <5d2716640712180147x36aa3178ja8658e30842c4e52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12894_10769016.1197971247964"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 10:47:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Z3K-0005EH-HS
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbXLRJrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 04:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbXLRJrb
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:47:31 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:9179 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbXLRJra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:47:30 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3962623wah.23
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 01:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=uFuUeOf7Hp+X+qroOK00crXimHeGeW677TKAbw11pZ8=;
        b=Mg00YW0p2oto0KmOA/ts8VefzzqV3wtpV8nEHTfWU7cGLV1B2m8JobDW0V6yhPfMOhM6Ra2ZX6RjkkR5eMzq/tkzu8w4SdABlUxCF5RTUH42Ofl2YtYuFXUlajTLChuKhJr8syy/Vgth/IIZm5RWmB84MX7/XQUwdub57I2d9jU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=gAWihZ0NJ6VrgcBPz+Gx+U6VLCgU7D0DA3+mQF7CNSN59DgTvwNjq3bBvUIY4pIlSYhzQfZKx/rLQDv8ghRptL3LE+PoTVgQa4DHzuDNUagWIN9fsPUbpo/AhcdMZVjQETZX5aolE+F4LCAAL5lt/JqB4xRATHECjLt7iUCGU9s=
Received: by 10.115.54.1 with SMTP id g1mr4802192wak.133.1197971247972;
        Tue, 18 Dec 2007 01:47:27 -0800 (PST)
Received: by 10.114.156.7 with HTTP; Tue, 18 Dec 2007 01:47:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68720>

------=_Part_12894_10769016.1197971247964
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It's not uncommon to have a lines with a single form feed in it, e.g.
the default GPL COPYING and also in .c files and others. Attached
patch allows this in the pre-commit hook.

-Hannes

------=_Part_12894_10769016.1197971247964
Content-Type: text/x-diff;
 name=pre-commit-hook-allow-form-feed-200712181.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fac910w10
Content-Disposition: attachment;
 filename=pre-commit-hook-allow-form-feed-200712181.patch

RnJvbSA0NTRlZGU4M2Y3YTQ1NzQxZDgyNWYwYjZjYmRiMGJlMmFjMjM1ZmRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5uZXMgRWRlciA8SGFubmVzQEhhbm5lc0VkZXIubmV0PgpE
YXRlOiBUdWUsIDE4IERlYyAyMDA3IDEwOjIxOjExICswMTAwClN1YmplY3Q6IFtQQVRDSF0gYWxs
b3cgYSBsaW5lcyB3aXRoIGp1c3Qgb25lIGZvcm0gZmVlZCBpbiBwcmUtY29tbWl0IGhvb2sKCgpk
aWZmIC0tZ2l0IGEvdGVtcGxhdGVzL2hvb2tzLS1wcmUtY29tbWl0IGIvdGVtcGxhdGVzL2hvb2tz
LS1wcmUtY29tbWl0CmluZGV4IDcwOTJiYWUuLmE3NTlmOTIgMTAwNjQ0Ci0tLSBhL3RlbXBsYXRl
cy9ob29rcy0tcHJlLWNvbW1pdAorKysgYi90ZW1wbGF0ZXMvaG9va3MtLXByZS1jb21taXQKQEAg
LTU1LDcgKzU1LDcgQEAgcGVybCAtZSAnCiAJaWYgKHMvXlwrLy8pIHsKIAkgICAgJGxpbmVubysr
OwogCSAgICBjaG9tcDsKLQkgICAgaWYgKC9ccyQvKSB7CisJICAgIGlmICghL15cZiQvICYmIC9c
cyQvKSB7CiAJCWJhZF9saW5lKCJ0cmFpbGluZyB3aGl0ZXNwYWNlIiwgJF8pOwogCSAgICB9CiAJ
ICAgIGlmICgvXlxzKiBcdC8pIHsK
------=_Part_12894_10769016.1197971247964--
