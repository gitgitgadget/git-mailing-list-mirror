From: Alex Riesen <raa.lkml@gmail.com>
Subject: Use testlib to skip t3300-funny-names
Date: Thu, 5 Jan 2006 12:53:15 +0100
Message-ID: <81b0412b0601050353o6b96ed4fp2a6d24dd514cc9c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11317_433242.1136461995195"
X-From: git-owner@vger.kernel.org Thu Jan 05 12:54:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuThI-0001nx-Mn
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 12:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWAELyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 06:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbWAELyV
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 06:54:21 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:18638 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1752019AbWAELyU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 06:54:20 -0500
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.200])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k05BsGQb013347
	for <git@vger.kernel.org>; Thu, 5 Jan 2006 03:54:19 -0800
Received: by nproxy.gmail.com with SMTP id x37so103773nfc
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 03:53:15 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=feNbML+WZXrqFidDV09xC9WpTUqAVRvFD0RPRfeb5/Mj9GCSyUC8DvHCRZ3KwrQuPqNUa+nq/mvZMNnI3MWscubE7uEhX27GdCXjOBNmO9VmIrXcp2teJLJfgNJLKGRga9YKO1PhwZqRkdwbbS6cQpt5+bueDjWwCb7H2pV6OTw=
Received: by 10.48.3.13 with SMTP id 13mr683290nfc;
        Thu, 05 Jan 2006 03:53:15 -0800 (PST)
Received: by 10.48.248.4 with HTTP; Thu, 5 Jan 2006 03:53:15 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14193>

------=_Part_11317_433242.1136461995195
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The test cannot be run on cygwin anyway.
Corrected the error message to reflect the problem source.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_11317_433242.1136461995195
Content-Type: text/plain; name="0007-Use-testlib-to-skip-the-test-it-cannot-be-run-on-cygwin.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0007-Use-testlib-to-skip-the-test-it-cannot-be-run-on-cygwin.txt"

U3ViamVjdDogW1BBVENIXSBVc2UgdGVzdGxpYiB0byBza2lwIHRoZSB0ZXN0IChpdCBjYW5ub3Qg
YmUgcnVuIG9uIGN5Z3dpbikKCkNvcnJlY3QgdGhlIGVycm9yIG1lc3NhZ2UgdG8gcmVmbGVjdCB0
aGUgcHJvYmxlbSBzb3VyY2UKClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBn
bWFpbC5jb20+CgoKLS0tCgogdC90MzMwMC1mdW5ueS1uYW1lcy5zaCB8ICAgMTAgKysrKysrKy0t
LQogMSBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgo3MjFj
YTQ5NWJiYmZmMWQzODdhYTQ4YWU0MDFiN2ExNGZiNDg2YWMwCmRpZmYgLS1naXQgYS90L3QzMzAw
LWZ1bm55LW5hbWVzLnNoIGIvdC90MzMwMC1mdW5ueS1uYW1lcy5zaAppbmRleCA2YTg1ZDY3Li41
ZDcwNTk0IDEwMDc1NQotLS0gYS90L3QzMzAwLWZ1bm55LW5hbWVzLnNoCisrKyBiL3QvdDMzMDAt
ZnVubnktbmFtZXMuc2gKQEAgLTksMTEgKzksMTUgQEAgVGhpcyB0ZXN0IHRyaWVzIHBhdGhuYW1l
cyB3aXRoIGZ1bm55IGNoYQogdHJlZSwgaW5kZXgsIGFuZCB0cmVlIG9iamVjdHMuCiAnCiAKLSMg
c2luY2UgRkFUL05URlMgZG9lcyBub3QgYWxsb3cgdGFicyBpbiBmaWxlbmFtZXMsIHNraXAgdGhp
cyB0ZXN0Ci10ZXN0ICIkKHVuYW1lIC1vIDI+L2Rldi9udWxsKSIgPSBDeWd3aW4gJiYgZXhpdCAw
Ci0KIC4gLi90ZXN0LWxpYi5zaAogCisjIFNpbmNlIEZBVC9OVEZTIGRvZXMgbm90IGFsbG93IHRh
YnMgaW4gZmlsZW5hbWVzLCBza2lwIHRoaXMgdGVzdC4KKyMgV2luZG93cyBhbHNvIGhhdmUgdW5l
eHBsYWluYWJsZSBwcm9ibGVtcyB3aXRoIG5hbWVzIGNvbnRhaW5pbmcgb25seSBzcGFjZXMuCitp
ZiBbICIkKHVuYW1lIC1vIDI+L2Rldi9udWxsKSIgPSBDeWd3aW4gXTsgdGhlbgorICAgIHNheSAn
RkFUIGFuZCBOVEZTIG9uIFdpbmRvd3MgZG8gbm90IGFsbG93IHRhYnMgaW4gZmlsZW5hbWVzLCB0
ZXN0IHNraXBwZWQnCisgICAgdGVzdF9kb25lCitmaQorCiBwMD0nbm8tZnVubnknCiBwMT0ndGFi
cwksIiAoZHEpIGFuZCBzcGFjZXMnCiBwMj0nanVzdCBzcGFjZScKLS0gCjEuMC5HSVQK
------=_Part_11317_433242.1136461995195--
