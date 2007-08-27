From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: git-import.sh using git-fast-import
Date: Mon, 27 Aug 2007 23:13:00 +0700
Message-ID: <fcaeb9bf0708270913o37b2dbdfw2f5f7d89d9ab1d21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_22361_25293944.1188231180298"
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 18:16:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPhER-00080s-Jf
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 18:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760774AbXH0QNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 12:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760634AbXH0QNE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 12:13:04 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:18852 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761024AbXH0QNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 12:13:01 -0400
Received: by an-out-0708.google.com with SMTP id d31so213091and
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 09:13:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        b=OiytSslps7zQx1rLijzb67OskaP0oeZj6m+ipHPFHFsCPa3alT0HDFDAzoDm7Yo4LeW5nzaL+ccutWat5yK5SF/AshxkTXJfnBrgE0gCyeIgF0gUKAf2mzhnxk68wiADNmekhfwGp5xxHasqO0NpWUXARsvgn/sq02O2R4uTwgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=GffAMO3pdkk4BmJ1koKso3gqJbbXYQxzDUVMvVI1iiQB9J8D9BUpkI9U5BijlGHVazFrQ4qYJ06QRHyTws1Q0gXhzNabXfvmi0jQs+Q3PBAV4kbcWvtJ9SREB7tJo1e7QtBMjbXJ3/5PGNvpdknjY1xgqP47jS/pgiv2xr9VrJw=
Received: by 10.100.142.12 with SMTP id p12mr1812275and.1188231180392;
        Mon, 27 Aug 2007 09:13:00 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Mon, 27 Aug 2007 09:13:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56855>

------=_Part_22361_25293944.1188231180298
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It is not really good. It does not run as fast as git-add &&
git-commit. But it can swallow big directories that git-add &&
git-commit can't. So I think I would share. It's also simpler than
those in contrib/fast-import, making it a good start for
git-fast-import's new users.

To run it, move inside the directory you want to import then type
./git-import.sh master 'your import message'
-- 
Duy

------=_Part_22361_25293944.1188231180298
Content-Type: application/x-sh; name=git-import.sh
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f5v62xyt
Content-Disposition: attachment; filename="git-import.sh"

IyEvYmluL3NoCgppZiBbIC16ICIkMSIgLW8gLXogIiQyIiBdOyB0aGVuCgllY2hvICJVc2FnZTog
Z2l0LWltcG9ydCBicmFuY2ggaW1wb3J0LW1lc3NhZ2UiCglleGl0IDEKZmkKClVTRVJOQU1FPSIk
KGdpdCBjb25maWcgdXNlci5uYW1lKSIKRU1BSUw9IiQoZ2l0IGNvbmZpZyB1c2VyLmVtYWlsKSIK
CmlmIFsgLXogIiRVU0VSTkFNRSIgLW8gLXogIiRFTUFJTCIgXTsgdGhlbgoJZWNobyAiWW91IG5l
ZWQgdG8gc2V0IHVzZXIgbmFtZSBhbmQgZW1haWwiCglleGl0IDEKZmkKCmdpdCBpbml0CgooCglj
YXQgPDxFT0YKY29tbWl0IHJlZnMvaGVhZHMvJDEKY29tbWl0dGVyICRVU0VSTkFNRSA8JEVNQUlM
PiBub3cKZGF0YSA8PE1TR0VPRgokMgpNU0dFT0YKCkVPRgoJZmluZCAqIC10eXBlIGZ8d2hpbGUg
cmVhZCBpO2RvCgkJZWNobyAiTSAxMDA2NDQgaW5saW5lICRpIgoJCWVjaG8gZGF0YSAkKHN0YXQg
LWMgJyVzJyAiJGkiKQoJCWNhdCAiJGkiCgkJZWNobwoJZG9uZQoJZWNobwopIHwgZ2l0IGZhc3Qt
aW1wb3J0IC0tZGF0ZS1mb3JtYXQ9bm93Cg==
------=_Part_22361_25293944.1188231180298--
