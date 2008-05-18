From: Twiinz <twiinz@gmail.com>
Subject: Two minor tweaks on git-gui where textboxes weren't vertically centered with their labels and buttons
Date: Sun, 18 May 2008 12:18:30 +0700
Message-ID: <412a1d9a0805172218v7c0a920es8a48129014051a35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_19451_13980337.1211087910983"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 18 07:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxbJD-0006jg-I6
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 07:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbYERFSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 01:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbYERFSd
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 01:18:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:43524 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbYERFSc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 01:18:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so847672wfd.4
        for <git@vger.kernel.org>; Sat, 17 May 2008 22:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:x-google-sender-auth;
        bh=EEtpBlEBY+9Uw6BSiHEB8igCjrhTYmrU91OjLOlrGKM=;
        b=K7RwdQvFHvo33GCu7yIAfborGcnM+czwN1XkkTD06t7/bal9mfyy2qitVQO0c3kgdH32Rc9ei7agFGS/A6IeFpnF1X+JBKoRXCw+EnWMGUWC5CuMj6rIACgGrF8R2gREBQpwrLQxDilnnM3EHIKiXB3xsmJ3Adol1wM9DXGSwtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:x-google-sender-auth;
        b=Njm60pstDNxgPoUDDlAc2Stebl52vDq8F10r+QE6kwGU5FywbjJFWUU2nmSxcwQ4sQUPC+0I9y94GKWoW4pdCoyTEfCLZTRE5EI+JYm2KspgmkU9lJUdQj9VQXZljdgzKbUkpGlE3mnsn3c98AHdOqDkIGFF0Xi2ED7l9X06tS0=
Received: by 10.142.179.12 with SMTP id b12mr2257972wff.88.1211087911431;
        Sat, 17 May 2008 22:18:31 -0700 (PDT)
Received: by 10.142.12.10 with HTTP; Sat, 17 May 2008 22:18:30 -0700 (PDT)
X-Google-Sender-Auth: 7ab994fcf5fd41c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82377>

------=_Part_19451_13980337.1211087910983
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In git-gui after clicking either on 'Create New Repository' or 'Open
Existing Repository' the form elements aren't centered like they are
pretty much everywhere else in the app. At least when ran on a mac,
haven't checked on other platforms.

Using grid instead of pack seems to fix this.

Hope that helps, cheers,
/twiinz

------=_Part_19451_13980337.1211087910983
Content-Type: application/octet-stream; name=choose_repository.tcl.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fgd69ft60
Content-Disposition: attachment; filename=choose_repository.tcl.patch

LS0tIGNob29zZV9yZXBvc2l0b3J5Lm9sZC50Y2wJMjAwOC0wNS0xOCAxMTo1NDoyMy4wMDAwMDAw
MDAgKzA3MDAKKysrIGNob29zZV9yZXBvc2l0b3J5LnRjbAkyMDA4LTA1LTE4IDExOjU2OjQxLjAw
MDAwMDAwMCArMDcwMApAQCAtMzg4LDkgKzM4OCw3IEBAIG1ldGhvZCBfZG9fbmV3IHt9IHsKIAkJ
LWNvbW1hbmQgW2NiIF9uZXdfbG9jYWxfcGF0aF0KIAlzZXQgd19sb2NhbHBhdGggJHdfYm9keS53
aGVyZS50CiAKLQlwYWNrICR3X2JvZHkud2hlcmUuYiAtc2lkZSByaWdodAotCXBhY2sgJHdfYm9k
eS53aGVyZS5sIC1zaWRlIGxlZnQKLQlwYWNrICR3X2JvZHkud2hlcmUudCAtZmlsbCB4CisJZ3Jp
ZCAkd19ib2R5LndoZXJlLmwgJHdfYm9keS53aGVyZS50ICR3X2JvZHkud2hlcmUuYiAtc3RpY2t5
IGV3CiAJcGFjayAkd19ib2R5LndoZXJlIC1maWxsIHgKIAogCXRyYWNlIGFkZCB2YXJpYWJsZSBA
bG9jYWxfcGF0aCB3cml0ZSBbY2IgX3dyaXRlX2xvY2FsX3BhdGhdCkBAIC05ODcsOSArOTg1LDcg
QEAgbWV0aG9kIF9kb19vcGVuIHt9IHsKIAkJLXRleHQgW21jICJCcm93c2UiXSBcCiAJCS1jb21t
YW5kIFtjYiBfb3Blbl9sb2NhbF9wYXRoXQogCi0JcGFjayAkd19ib2R5LndoZXJlLmIgLXNpZGUg
cmlnaHQKLQlwYWNrICR3X2JvZHkud2hlcmUubCAtc2lkZSBsZWZ0Ci0JcGFjayAkd19ib2R5Lndo
ZXJlLnQgLWZpbGwgeAorCWdyaWQgJHdfYm9keS53aGVyZS5sICR3X2JvZHkud2hlcmUudCAkd19i
b2R5LndoZXJlLmIgLXN0aWNreSBldwogCXBhY2sgJHdfYm9keS53aGVyZSAtZmlsbCB4CiAKIAl0
cmFjZSBhZGQgdmFyaWFibGUgQGxvY2FsX3BhdGggd3JpdGUgW2NiIF93cml0ZV9sb2NhbF9wYXRo
XQo=
------=_Part_19451_13980337.1211087910983--
