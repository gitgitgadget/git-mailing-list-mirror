From: "Rob Shearman" <robertshearman@gmail.com>
Subject: [PATCH] git-imap-send: Allow the program to be run from subdirectories of a git tree.
Date: Sun, 1 Jun 2008 16:28:44 +0100
Message-ID: <1096648c0806010828yf4f07ebt3f758f41cab5cdfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_31500_27977976.1212334124618"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 17:29:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2pVD-0007zH-9f
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 17:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbYFAP2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 11:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751985AbYFAP2q
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 11:28:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:45922 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927AbYFAP2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 11:28:46 -0400
Received: by fg-out-1718.google.com with SMTP id 19so529691fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=LK0TKQdTNf5CB5Gjp5iOtb4d6R9vichUk5QdcDFsNxQ=;
        b=c8BQjbu2FB9O18Vfw7K+rXM1n61LicwqQoACxkQ874jw6+ywbVQpWgMjStIuaRSbqZ5Nr5PmF1EoHmCs0GHBuNX3TDH7LM6gq9M+tqfGXIk0jV96onI1MguBoxVApFfvweFbnxGXRGHKMj3adYuS/IiPO2UI1HAZQFrDeCjNU4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=gB+pMDaH/y3R36as+UgvtyrcO8iY5ukecMm4QwkyeVWvAa5QI8MHOVBAzmhNqqKT84UToF2gbC5T+FZddqDI3hAjy/7EOq7QwNMtWZAL0XY1Hm7etzDcrxB3K21p2TnexLUjqRAGA3rb+BuOAZ+kmmZgR9mVtHANH/SFmnad0Pc=
Received: by 10.82.151.9 with SMTP id y9mr272434bud.8.1212334124638;
        Sun, 01 Jun 2008 08:28:44 -0700 (PDT)
Received: by 10.82.159.3 with HTTP; Sun, 1 Jun 2008 08:28:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83450>

------=_Part_31500_27977976.1212334124618
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Call setup_git_directory_gently to allow git-imap-send to be used from
subdirectories of a git tree.

Signed-off-by: Robert Shearman <robertshearman@gmail.com>
---
 imap-send.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

------=_Part_31500_27977976.1212334124618
Content-Type: text/x-patch;
 name=8a59e6e80cd62ce64462486b2b9c9b39053d2777.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: 0.1
Content-Disposition: attachment;
 filename=8a59e6e80cd62ce64462486b2b9c9b39053d2777.diff

ZGlmZiAtLWdpdCBhL2ltYXAtc2VuZC5jIGIvaW1hcC1zZW5kLmMNCmluZGV4IDFlYzEzMTAuLjg5
YTE1MzIgMTAwNjQ0DQotLS0gYS9pbWFwLXNlbmQuYw0KKysrIGIvaW1hcC1zZW5kLmMNCkBAIC0x
Mjk2LDYgKzEyOTYsNyBAQCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikNCiAJLyogaW5pdCB0
aGUgcmFuZG9tIG51bWJlciBnZW5lcmF0b3IgKi8NCiAJYXJjNF9pbml0KCk7DQogDQorCXNldHVw
X2dpdF9kaXJlY3RvcnlfZ2VudGx5KCBOVUxMICk7DQogCWdpdF9jb25maWcoZ2l0X2ltYXBfY29u
ZmlnLCBOVUxMKTsNCiANCiAJaWYgKCFpbWFwX2ZvbGRlcikgew0K
------=_Part_31500_27977976.1212334124618--
