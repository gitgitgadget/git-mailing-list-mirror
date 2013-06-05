From: ojab <ojab@ojab.ru>
Subject: Re: [PATCH] Fix `git svn rebase` if top-level HEAD directory exist
Date: Wed, 05 Jun 2013 09:32:50 +0400
Message-ID: <51AECD82.4070908@ojab.ru>
References: <51AD9828.7080508@ojab.ru> <20130604074956.GA13555@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070009020907050707010707"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 05 07:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk6Sg-0004oX-UV
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 07:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab3FEFkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 01:40:39 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36383 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab3FEFki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 01:40:38 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so1496725lbh.35
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 22:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-gm-message-state;
        bh=kdR7m+p7BYaqIorLmMFuDWxFpQfuqbAgvGK3iVI+gCs=;
        b=ZDXAoJmR4qfU38fRnyFwhJcBNbtV56ub2YmcdqTLv6R1c9wVACsC3O7aP7NT694FmG
         nGy1eR+9snPxPfKkGLWzeyY1p4Em/wKcoU89gwUMtJ30tIWOTdEigBcNXsB2iLn9Zpkd
         9AIHA6J4NqIr2MEebRA3HpOxqk4GRva2bleziWHj6gxjFTnVIjP/dozPOODeX0bpucJq
         bhk44waWC+eeARw93z/czpTae8ErBu1lIfbh0be3cO+FEi8uFMQyRtk9Webq9rApPbiN
         09qTdjCPGbiVlCEeKE5Rgab5ysyq9xD7vKuSevTEAn37bUlAlWUC4xUe4KkxKELeeeOE
         Hl8g==
X-Received: by 10.112.149.71 with SMTP id ty7mr14340581lbb.16.1370410375216;
        Tue, 04 Jun 2013 22:32:55 -0700 (PDT)
Received: from ojab.ru (cl-154.led-01.ru.sixxs.net. [2a02:578:5002:99::2])
        by mx.google.com with ESMTPSA id x3sm27372969lag.6.2013.06.04.22.32.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 22:32:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:23.0) Gecko/20100101 Thunderbird/23.0a1
In-Reply-To: <20130604074956.GA13555@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmb49EKRQiBefMsYEULEJxIfEUkEfOgsjuAtcENBAduiPqUq2udJ+Eog/yggsKSoKgxgN29
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226431>

This is a multi-part message in MIME format.
--------------070009020907050707010707
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.06.2013 11:49, Jeff King wrote:

> This rationale should probably go in the commit message.

Done

>
> We prefer patches to be inline in the email; these lines can be
> dropped, as they are picked up from your email headers.

AFAIK Thunderbird brakes spaces, so better safe, than sorry :)

> Do you mind providing a real name? The point of Signed-off-by is for
> licensing and attribution.

Done (but i doubt that such a patch can be copyrighted).

> Looks obviously correct to me. I did a quick grep, and there is one
> other spot that probably should get the same treatment:

Yep, already found it.

//wbr ojab


--------------070009020907050707010707
Content-Type: text/plain; charset=UTF-8;
 name="0001-Fix-git-svn-rebase-dcommit-if-top-level-HEAD-directo.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Fix-git-svn-rebase-dcommit-if-top-level-HEAD-directo.pa";
 filename*1="tch"

RnJvbSAwMjUxYjdmMjAzMmUyMDUwZDJiNmQyY2JjMDk2MDQ3MWM5OTZiMDU4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBvamFiIDxvamFiQG9qYWIucnU+CkRhdGU6IFR1ZSwg
NCBKdW4gMjAxMyAxMToyODoxNiArMDQwMApTdWJqZWN0OiBbUEFUQ0hdIEZpeCBgZ2l0IHN2
bmAgYHJlYmFzZWAgJiBgZGNvbW1pdGAgaWYgdG9wLWxldmVsIEhFQUQKIGRpcmVjdG9yeSBl
eGlzdAoKJCBnaXQgc3ZuIHJlYmFzZQpmYXRhbDogYW1iaWd1b3VzIGFyZ3VtZW50ICdIRUFE
JzogYm90aCByZXZpc2lvbiBhbmQgZmlsZW5hbWUKVXNlICctLScgdG8gc2VwYXJhdGUgcGF0
aHMgZnJvbSByZXZpc2lvbnMsIGxpa2UgdGhpczoKJ2dpdCA8Y29tbWFuZD4gWzxyZXZpc2lv
bj4uLi5dIC0tIFs8ZmlsZT4uLi5dJwpyZXYtbGlzdCAtLWZpcnN0LXBhcmVudCAtLXByZXR0
eT1tZWRpdW0gSEVBRDogY29tbWFuZCByZXR1cm5lZCBlcnJvcjogMTI4CgpTaWduZWQtb2Zm
LWJ5OiBTbGF2YSBLYXJkYWtvdiA8b2phYkBvamFiLnJ1PgoKLS0tCiBnaXQtc3ZuLnBlcmwg
fCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZ2l0LXN2bi5wZXJsIGIvZ2l0LXN2bi5wZXJsCmluZGV4IGQw
NzBkZTAuLjM2MDgzYzEgMTAwNzU1Ci0tLSBhL2dpdC1zdm4ucGVybAorKysgYi9naXQtc3Zu
LnBlcmwKQEAgLTgzMSw3ICs4MzEsNyBAQCBzdWIgZGNvbW1pdF9yZWJhc2Ugewogc3ViIGNt
ZF9kY29tbWl0IHsKIAlteSAkaGVhZCA9IHNoaWZ0OwogCWNvbW1hbmRfbm9pc3kocXcvdXBk
YXRlLWluZGV4IC0tcmVmcmVzaC8pOwotCWdpdF9jbWRfdHJ5IHsgY29tbWFuZF9vbmVsaW5l
KHF3L2RpZmYtaW5kZXggLS1xdWlldCBIRUFELykgfQorCWdpdF9jbWRfdHJ5IHsgY29tbWFu
ZF9vbmVsaW5lKHF3L2RpZmYtaW5kZXggLS1xdWlldCBIRUFEIC0tLykgfQogCQknQ2Fubm90
IGRjb21taXQgd2l0aCBhIGRpcnR5IGluZGV4LiAgQ29tbWl0IHlvdXIgY2hhbmdlcyBmaXJz
dCwgJwogCQkuICJvciBzdGFzaCB0aGVtIHdpdGggYGdpdCBzdGFzaCcuXG4iOwogCSRoZWFk
IHx8PSAnSEVBRCc7CkBAIC0xOTMyLDcgKzE5MzIsNyBAQCBzdWIgY210X3NoYTJyZXZfYmF0
Y2ggewogc3ViIHdvcmtpbmdfaGVhZF9pbmZvIHsKIAlteSAoJGhlYWQsICRyZWZzKSA9IEBf
OwogCW15IEBhcmdzID0gcXcvcmV2LWxpc3QgLS1maXJzdC1wYXJlbnQgLS1wcmV0dHk9bWVk
aXVtLzsKLQlteSAoJGZoLCAkY3R4KSA9IGNvbW1hbmRfb3V0cHV0X3BpcGUoQGFyZ3MsICRo
ZWFkKTsKKwlteSAoJGZoLCAkY3R4KSA9IGNvbW1hbmRfb3V0cHV0X3BpcGUoQGFyZ3MsICRo
ZWFkLCAiLS0iKTsKIAlteSAkaGFzaDsKIAlteSAlbWF4OwogCXdoaWxlICg8JGZoPikgewot
LSAKMS44LjIKCg==
--------------070009020907050707010707--
