From: "Fernando Herrera" <fherrera@onirica.com>
Subject: [PATCH]: remove extra-verbosity from git-clone (http)
Date: Thu, 15 Feb 2007 19:10:07 +0200
Message-ID: <58d389c20702150910x24ec218bjdb9cb49ee03fd1df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_82724_15963696.1171559407223"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 18:10:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHk7r-0005Dq-1o
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 18:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbXBORK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 12:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbXBORK1
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 12:10:27 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:10197 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030268AbXBORK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 12:10:26 -0500
Received: by wr-out-0506.google.com with SMTP id i21so728121wra
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 09:10:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:x-google-sender-auth;
        b=ruC5gAnCY9glzG9Nys5MPmNaIGDWYUP43amd5+G1980Rs4p+BDxVPqmylspA5tJfau+ldMo7WUOz+1VzrMmVBgwKglsHub6J79tis1ZlFzQ1hQ5mY/bpUhIRWAt4Cv2CuqsOxoJA7zLEp2nEDnSGPsc7O+cEfbBb+emZaCJBa3g=
Received: by 10.114.124.1 with SMTP id w1mr1214899wac.1171559407290;
        Thu, 15 Feb 2007 09:10:07 -0800 (PST)
Received: by 10.114.73.6 with HTTP; Thu, 15 Feb 2007 09:10:07 -0800 (PST)
X-Google-Sender-Auth: e2fe3172aacf2aac
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39839>

------=_Part_82724_15963696.1171559407223
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

the attached patch removes the extra verbosity when cloning a http
repository. I noticed this after some git upgrade in fedora. Please,
consider applying it, getting tons of "got XXX", "walk XXX" lines by
default is a little bit annoying.

Salu2

PS: Thanks for this so great piece os software!

------=_Part_82724_15963696.1171559407223
Content-Type: text/x-patch; name=git-clone-http-noverbose.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ey7g5sac
Content-Disposition: attachment; filename="git-clone-http-noverbose.patch"

LS0tIGdpdC1jbG9uZS5zaC5vcmlnCTIwMDctMDItMTUgMTk6MDM6NTEuMDAwMDAwMDAwICswMjAw
CisrKyBnaXQtY2xvbmUuc2gJMjAwNy0wMi0xNSAxOTowNDowNi4wMDAwMDAwMDAgKzAyMDAKQEAg
LTU5LDcgKzU5LDcgQEAKIAkJZWxzZQogCQkJdG5hbWU9JG5hbWUKIAkJZmkKLQkJZ2l0LWh0dHAt
ZmV0Y2ggLXYgLWEgLXcgIiR0bmFtZSIgIiRuYW1lIiAiJDEvIiB8fCBleGl0IDEKKwkJZ2l0LWh0
dHAtZmV0Y2ggLWEgLXcgIiR0bmFtZSIgIiRuYW1lIiAiJDEvIiB8fCBleGl0IDEKIAlkb25lIDwi
JGNsb25lX3RtcC9yZWZzIgogCXJtIC1mciAiJGNsb25lX3RtcCIKIAlodHRwX2ZldGNoICIkMS9I
RUFEIiAiJEdJVF9ESVIvUkVNT1RFX0hFQUQiIHx8Cg==
------=_Part_82724_15963696.1171559407223--
