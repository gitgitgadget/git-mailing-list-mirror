From: tsuna <tsunanet@gmail.com>
Subject: [PATCH] Auto-correct git pull -ff to git pull --ff.
Date: Fri, 19 Mar 2010 18:59:25 -0700
Message-ID: <4d9f5be51003191859p38c7cfa9o11eafd5016b6ced@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636b144ab678d9d048231d189
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 02:59:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsnyh-0004NR-Hk
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 02:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0CTB7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 21:59:46 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63672 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0CTB7p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 21:59:45 -0400
Received: by pva4 with SMTP id 4so1858691pva.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 18:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=YJ82ONd40+z0Ufv6BHmyuR5RqfBlEN3QlissmYTZVzA=;
        b=hOPueUNbCVmYsUzlqRZHVYdkqbra5ifxBreTRjXeQW0Kh5RmQjfnOGzCC94vXknEQS
         2QLHOxHVvjTJKWjrGJL80FLoWzxukEPdRuTDqNWeWsazn/1gfclOUT6p5KcsNp0fpoUx
         E2uQFQdJou99vUo6xHfUuuaKbE/KXOLmJ9PYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=p/mf5Ffpk2tVzJJ8+/3ypjrtm+5XWTJoTA2+Tf9/FxfmsczOFwto0ESBsSKJT9g+kO
         JUreqEMCHcS3BGoQfy+72g/qBPKtmCEkn48lDg/G7mrSj1pZ6xzuROPJ8uUz6hC/tePX
         RyJwo1Uo3wZMhX8JGF9tXWCkpmR05RFdWvOdU=
Received: by 10.114.70.18 with SMTP id s18mr4261177waa.18.1269050385075; Fri, 
	19 Mar 2010 18:59:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142669>

--001636b144ab678d9d048231d189
Content-Type: text/plain; charset=ISO-8859-1

Hi there,
I attached a trivial patch that auto-corrects a frequent typo does not
trigger any error with git pull.
I find it useful so I hope others will too.

-- 
Benoit "tsuna" Sigoure

--001636b144ab678d9d048231d189
Content-Type: application/octet-stream; 
	name="0001-Auto-correct-git-pull-ff-to-git-pull-ff.patch"
Content-Disposition: attachment; 
	filename="0001-Auto-correct-git-pull-ff-to-git-pull-ff.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6zrr1yj0

RnJvbSBlNGQ0MzY0MGQ4MGZjYTkzZmRhNDVkMTNlMDJmM2ZlZGYwOWY2MzlhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5vaXQgU2lnb3VyZSA8dHN1bmFuZXRAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDE3IE1hciAyMDEwIDE3OjExOjQ0IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gQXV0
by1jb3JyZWN0IGdpdCBwdWxsIC1mZiB0byBnaXQgcHVsbCAtLWZmLgoKVGhpcyBmcmVxdWVudCB0
eXBvIGRvZXMgbm90IHRyaWdnZXIgYW55IGVycm9yIGJlY2F1c2UgZ2l0IHB1bGwgZG9lc24ndApy
ZWNvZ25pemUgLWZmIGFuZCBwYXNzZXMgaXQgdGhyb3VnaCB0byBnaXQgZmV0Y2gsIHdoaWNoIHBh
cnNlcyBpdCBhcyBhCnNob3J0IG9wdGlvbiwgYXMgaWYgdGhlIG9wdGlvbiAtZiB3YXMgc2ltcGx5
IHNwZWNpZmllZCB0d2ljZS4KLS0tCiBnaXQtcHVsbC5zaCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hh
bmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1w
dWxsLnNoIGIvZ2l0LXB1bGwuc2gKaW5kZXggZDQ1YjUwYy4uYmU4NTAzMiAxMDA3NTUKLS0tIGEv
Z2l0LXB1bGwuc2gKKysrIGIvZ2l0LXB1bGwuc2gKQEAgLTY2LDcgKzY2LDcgQEAgZG8KIAkJc3F1
YXNoPS0tc3F1YXNoIDs7CiAJLS1uby1zcXwtLW5vLXNxdXwtLW5vLXNxdWF8LS1uby1zcXVhc3wt
LW5vLXNxdWFzaCkKIAkJc3F1YXNoPS0tbm8tc3F1YXNoIDs7Ci0JLS1mZikKKwktZmZ8LS1mZikK
IAkJbm9fZmY9LS1mZiA7OwogCS0tbm8tZmYpCiAJCW5vX2ZmPS0tbm8tZmYgOzsKLS0gCjEuNy4w
LjIuMjc5LmdmMWJhMWMKCg==
--001636b144ab678d9d048231d189--
