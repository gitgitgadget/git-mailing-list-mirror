From: "James Youngman" <jay@gnu.org>
Subject: Clarifying "invalid tag signature file" error message from git filter-branch (and others)
Date: Thu, 11 Dec 2008 10:14:03 +0000
Message-ID: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_95410_10371692.1228990443632"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 11:15:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAiZq-00058I-Sz
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 11:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975AbYLKKOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 05:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbYLKKOH
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 05:14:07 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:56557 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754975AbYLKKOE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 05:14:04 -0500
Received: by wf-out-1314.google.com with SMTP id 27so665462wfd.4
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 02:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:x-google-sender-auth;
        bh=8k+opXG8v/fkC5++KaBQkwpoOFJcdbUuxCaMcSAOO1w=;
        b=x2bveurgDrUwfODmx18ofvgLwa/oee9C7cvnOJyPKyoFg6ssITT0bpsdlH0m5qTkXJ
         kyKKnskniIUvi94HWD8Nl9cKACee1HsfizD+lnBTDuVuecCFYx7S3pxJyVJJNMvV+JMj
         9V7N35z3+Rt8bK/NzMhBUrrDd8BUH/bDn/tak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :x-google-sender-auth;
        b=xUdGg9GSgYaPMLbtBTYYyBLtpdJhaCujWrPfbzbPfIuhh0/MAxU6mHnvdO7Fw85wau
         +ERZ3VKgeNLVckqS/JM/EXbgBGSf6bVCpdDh4j9NnsnqId3Dpi0g5mbm8JtmjfQL3mLs
         GoBi4voeCvM3nmZlZd4Oao3aErPiJIRNvZegc=
Received: by 10.142.174.18 with SMTP id w18mr693230wfe.267.1228990443645;
        Thu, 11 Dec 2008 02:14:03 -0800 (PST)
Received: by 10.143.168.8 with HTTP; Thu, 11 Dec 2008 02:14:03 -0800 (PST)
X-Google-Sender-Auth: b84a6711f1a09ae0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102791>

------=_Part_95410_10371692.1228990443632
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

What do the errors "error: char88: malformed tagger field" and "fatal:
invalid tag signature file" and "Could not create new tag object for
FINDUTILS-4_1-10" signify in the session below?

Are any of those errors correctable (I can re-run the tree rewrite
script as many times as needed, I'm just using it on a test repository
for now).

The script I'm invoking calls git filter-branch; I've attached the script.

$ bash ~/source/GNU/findutils/logrewrite.sh
fatal: Not a git repository
Rewrite 9afb13614381c4bfa22f515c18cbfe6f54798330 (1587/1587)
Ref 'refs/heads/master' was rewritten
FINDUTILS-4_1-10 -> FINDUTILS-4_1-10
(ce25eb352de8dc53a9a7805ba9efc1c9215d28c2 ->
79221244237bc408ced0c37f3c3476d53e665801)
error: char88: malformed tagger field
fatal: invalid tag signature file
Could not create new tag object for FINDUTILS-4_1-10
$

Thanks,
James.

------=_Part_95410_10371692.1228990443632
Content-Type: application/x-sh; name=logrewrite.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fol9ayql0
Content-Disposition: attachment; filename=logrewrite.sh

IyEgL2Jpbi9iYXNoCgpnaXQgZmlsdGVyLWJyYW5jaCAtZCAvZGV2L3NobS90IC0tdHJlZS1maWx0
ZXIgXAonCiAgaWYgdGVzdCAtZiBDaGFuZ2VMb2c7IHRoZW4KICAgIGxpbmU9JChzZWQgLW4gInMs
XlsxMl1bOTBdWzAtOV1bMC05XS1bMC0xXVswLTldLVswLTNdWzAtOV0gICpcKFtBLVphLXpdLipc
KSxcMSwKICAgICAgICAgICAgICAgICAgcywuKiAgXChbQS1aYS16XS4qXCksXDEsCiAgICAgICAg
ICAgICAgICAgIC8uL3sKICAgICAgICAgICAgICAgICAgICAgICAgICBzLyh0aW55IGNoYW5nZSkv
LwogICAgICAgICAgICAgICAgICAgICAgICAgIHMvICokLy8KICAgICAgICAgICAgICAgICAgICAg
ICAgICBwCiAgICAgICAgICAgICAgICAgICAgICAgICAgcQogICAgICAgICAgICAgICAgICB9IiBD
aGFuZ2VMb2cpCiAgICBhdXRob3I9JChlY2hvICIkbGluZSIgfCBzZWQgInMsICpbPChdLiosLCIp
CiAgICBlbWFpbD0kKGVjaG8gIiRsaW5lIiB8IHNlZCAicyxbXiwoXSpbPChdLDwsOyBzL1spPl0u
Ki8+LyIpCiAgICBkb2l0PToKICAgIGNhc2UgJGF1dGhvciBpbgogICAgICAqVmF1Z2hhbiB8ICpW
dWFnaGFuKSBkb2l0PWZhbHNlOzsgIyBmb3IgR2FyeSwgdXNlIHRoZSBsb2dpbiBtYXAuCiAgICBl
c2FjCiAgICBjYXNlICRlbWFpbCBpbgogICAgICBcPGJmcmVpc2VuKikgZG9pdD1mYWxzZTs7ICAg
ICAgICAgIyBUeXBvIGluIEJvYnMgZW1haWwgYWRkcmVzcwogICAgICBcPHNjaHdhYkBib2d1cy5l
eGFtcGxlLmNvbVw+KSBlbWFpbD1zY2h3YWJAc3VzZS5kZTs7ICMgYm9ndXMgYWRkcmVzcy4KICAg
ICAgKnNwYW0ucHJvdGVjdGVkKikKICAgICAgICBjYXNlICRhdXRob3IgaW4KICAgICAgICAgICJC
ZXJuaGFyZCBGaXNjaGVyIikgOzsgIyBkdW5ubyBhIGJldHRlciBhZGRyZXNzCiAgICAgICAgICAi
Q2hhcmxlcyBXaWxzb24iKSBlbWFpbD0iPGxpYnRvb2xAY3dpbHNvbi5mYXN0bWFpbC5mbT4iIDs7
CiAgICAgICAgICAiUGV0ZXIgRWtiZXJnIikgZW1haWw9IjxwZWRhQGx5c2F0b3IubGl1LnNlPiIg
OzsKICAgICAgICBlc2FjCiAgICAgICAgOzsKICAgIGVzYWMKCiAgICBpZiAkZG9pdDsgdGhlbgog
ICAgICB0ZXN0IC1uICIkYXV0aG9yIiAmJiB0ZXN0IC1uICIkZW1haWwiICYmIHsKICAgICAgICAg
ICAgR0lUX0FVVEhPUl9OQU1FPSIkYXV0aG9yIgogICAgICAgICAgICBHSVRfQVVUSE9SX0VNQUlM
PSIkZW1haWwiCiAgICAgICAgICAgIGV4cG9ydCBHSVRfQVVUSE9SX05BTUUgR0lUX0FVVEhPUl9F
TUFJTAogICAgICB9CiAgIGZpCiBlbHNlCiAgIDoKIGZpCicgXAogLS1tc2ctZmlsdGVyIFwKJwog
c2VkICJzLG1laXNzbmVyQGJvZ3VzLmV4YW1wbGUuY29tLG1laXNzbmVyQHN1c2UuZGUsIgonIFwK
IC0tdGFnLW5hbWUtZmlsdGVyIGNhdCBcCiBtYXN0ZXIK
------=_Part_95410_10371692.1228990443632--
