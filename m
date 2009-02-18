From: Eric Hanchrow <eric.hanchrow@gmail.com>
Subject: Bug: git-svn dies with "Index mismatch"
Date: Tue, 17 Feb 2009 18:15:40 -0800
Message-ID: <36366a980902171815n37c3f17dw9836d62d4ff70a23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e911f7036539046327ffb3
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 03:17:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZbzr-0003t0-QK
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 03:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbZBRCPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 21:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbZBRCPm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 21:15:42 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:8538 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597AbZBRCPl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 21:15:41 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2298974rvb.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 18:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=6fmBGjLm96PNSkYXeUPVbx1fXU116+5KRFENj/Hht6k=;
        b=Jfd6quv5OoF06k0qHvBxukzLgbCKMgI6xxaecFe3IhzXbMDCuEYLPbZnGz+WyYHB5d
         kuQ7EyD8X2qYF7Af3iGqrYcmRcOUZm0yqK1mVz4mah56RyX/EzLjCnC2w8pTmDYWs3rO
         ngEdvBSL49NX/x4/MfwMOdKxvRPQ7mnacFTWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=SbYHu+ZHaUDuyyQKf049qaZzPWC1Bow4/ZgmuZcNpSBShaWKjpvtbqHSPPIw+s4Hts
         +RqfBHnKB3UK6OV/89uK0BPN/tl8a3kRF7NZv3W26Tx6Y2nbIedks6BZDXJa8AJTr4It
         ZjOavZC5RmgfloKOKjCYa3aFnHCUx5Z39Zd9Y=
Received: by 10.143.6.1 with SMTP id j1mr854738wfi.226.1234923340129; Tue, 17 
	Feb 2009 18:15:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110495>

--001636e911f7036539046327ffb3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is git version 1.6.2.rc0.10.gf6b9

The attached file clearly reproduces the problem.

--001636e911f7036539046327ffb3
Content-Type: application/x-sh; name="bug.sh"
Content-Disposition: attachment; filename="bug.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_frbdcy250

IyEvYmluL3NoCgpzZXQgLWUKCnRyYXAgImVjaG8gJ0Jyb3VnaHQgdG8geW91IGJ5JyA7IGdpdCAt
LXZlcnNpb24iIEVYSVQKCnM9L3RtcC9zdm4tcmVwb3MKZz0vdG1wL2ltcG9ydGVkLmdpdAp3PS90
bXAvc3ZuLXdjCgpybSAtcmYgJHMgJGcgJHcKCiMgQ3JlYXRlIGEgcmVwb3NpdG9yeSB3aXRoIGEg
bGl0dGxlIGJpdCBvZiBoaXN0b3J5Lgpzdm5hZG1pbiBjcmVhdGUgJHMKc3ZuIGNvIGZpbGU6Ly8k
cyAkdwpjZCAkdwpta2RpciB0cnVuayBicmFuY2hlcyB0YWdzCnN2biBhZGQgKgpzdm4gY2kgLW0g
IkluaXRpYWwgZGlyZWN0b3J5IGxheW91dCIKCigKICAgIGNkIHRydW5rCiAgICB0b3VjaCBmYWJ1
bG91cwogICAgc3ZuIGFkZCBmYWJ1bG91cwogICAgc3ZuIGNpIC1tICJJdCdzIG5pY2UgdG8gaGF2
ZSBmaWxlcyBpbiBvbmUncyB0cnVuay4iCikKCiMgTWFrZSBzb21lIHN0cnVjdHVyZSBpbiB0aGUg
c3ZuIHJlcG8gdGhhdCB3aWxsIGNvbmZ1c2UgZ2l0LXN2bi4Kc3ZuIG1rZGlyIGJyYW5jaGVzL2Zy
ZWQKc3ZuIGNpIC1tICJBIGJyYW5jaCEiCgpzdm4gcm0gYnJhbmNoZXMvZnJlZApzdm4gY2kgLW0g
Ik9vcHMsIEkgZGlkbid0IG1lYW4gdG8gY3JlYXRlIGFuIGVtcHR5IGRpcmVjdG9yeSEiCgpzdm4g
Y3AgLXIyIHRydW5rIGJyYW5jaGVzL2ZyZWQKc3ZuIGNpIC1tICJPSywgbm93IF90aGF0J3NfIGhv
dyB3ZSBtYWtlIGJyYW5jaGVzIGhlcmUgaW4gVGV4YXMuIgoKIyBOb3cgY29udmVydCB0aGUgc3Zu
IHJlcG8gdG8gZ2l0IC4uLiBhbmQgd2F0Y2ggdGhlIGNhcm5hZ2UuCmdpdCBzdm4gY2xvbmUgLVQg
dHJ1bmsgLWIgYnJhbmNoZXMgZmlsZTovLyRzICRnCg==
--001636e911f7036539046327ffb3--
