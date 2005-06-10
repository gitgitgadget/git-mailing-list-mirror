From: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Subject: Re: qgit-0.4
Date: Fri, 10 Jun 2005 23:54:31 +0200
Message-ID: <42AA0C17.1020403@gorzow.mm.pl>
References: <20050610211623.15018.qmail@web26308.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070807010509050106050507"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 23:50:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgrOc-0000mx-5W
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 23:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVFJVyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 17:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVFJVyy
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 17:54:54 -0400
Received: from goliat.kalisz.mm.pl ([217.96.42.226]:21654 "EHLO kalisz.mm.pl")
	by vger.kernel.org with ESMTP id S261256AbVFJVys (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2005 17:54:48 -0400
Received: (qmail 26446 invoked from network); 10 Jun 2005 21:54:42 -0000
Received: from unknown (HELO zen.uplink) (astralstorm@[81.190.161.223])
          (envelope-sender <astralstorm@gorzow.mm.pl>)
          by 0 (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 10 Jun 2005 21:54:42 -0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zen.uplink (Postfix) with ESMTP id A6B6D5EC512;
	Fri, 10 Jun 2005 23:54:31 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050425)
X-Accept-Language: en-us, en
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050610211623.15018.qmail@web26308.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------070807010509050106050507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Marco Costalba wrote:

> In cogito repository I see:
>
>Author: Petr Baudis <pasky@ucw.cz>
>Date:   09/06/2005 11:12:40
>Parent: 5b46e22e1c6de0dd800effb6136ac713698f98cf
>
>    cogito-0.11.3
>
>and in the author column the dates are all stripped away. If you can provide me with some of your
>stuff I can check what happens with your date and fix also the national charachters.
>
>  
>
One small patch attached (exported by git-export)
My name is in ISO-8859-2, however it didn't display UTF-8 correctly too.
gitk displays both correctly if the locale is set right.

git-rev-list --header 363d976c314deae082d4c09d703a77707327cea0
^45adbb1172b45a600fe341f9f44fa02fed1315da

363d976c314deae082d4c09d703a77707327cea0
tree ece5e56301930aa21e6c0e846ef7402e638744ee
parent 45adbb1172b45a600fe341f9f44fa02fed1315da
author James Simmons <jsimmons@www.infradead.org> 1118264225 +0200
committer Radosław Szkodziński <astralstorm@gorzow.mm.pl> 1118264225 +0200

+new-pci-id-for-chipsfb.patch

Patch from 2.6.12-rc6-mm1

Patch adds pci ID for CT 69000 chipset.

Signed-off-by: James Simmons <jsimmons@www.infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

include/linux/pci_ids.h | 1 +
1 files changed, 1 insertion(+)


qgit-0.4

tree ece5e56301930aa21e6c0e846ef7402e638744ee
parent 45adbb1172b45a600fe341f9f44fa02fed1315da
author James Simmons <jsimmons@www.infradead.org> 1118264225 +0200
committer Rados³aw Szkodziñski <astralstorm@gorzow.mm.pl> 1118264225 +0200

+new-pci-id-for-chipsfb.patch

Patch from 2.6.12-rc6-mm1

Patch adds pci ID for CT 69000 chipset.

Signed-off-by: James Simmons <jsimmons@www.infradead.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

include/linux/pci_ids.h | 1 +
1 files changed, 1 insertion(+)


--------------070807010509050106050507
Content-Type: text/plain;
 name="git-patch.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-patch.patch"

SWQ6IDM2M2Q5NzZjMzE0ZGVhZTA4MmQ0YzA5ZDcwM2E3NzcwNzMyN2NlYTAKdHJlZSBlY2U1
ZTU2MzAxOTMwYWEyMWU2YzBlODQ2ZWY3NDAyZTYzODc0NGVlCnBhcmVudCA0NWFkYmIxMTcy
YjQ1YTYwMGZlMzQxZjlmNDRmYTAyZmVkMTMxNWRhCmF1dGhvciBKYW1lcyBTaW1tb25zIDxq
c2ltbW9uc0B3d3cuaW5mcmFkZWFkLm9yZz4gMTExODI2NDIyNSArMDIwMApjb21taXR0ZXIg
UmFkb3OzYXcgU3prb2R6afFza2kgPGFzdHJhbHN0b3JtQGdvcnpvdy5tbS5wbD4gMTExODI2
NDIyNSArMDIwMAoKK25ldy1wY2ktaWQtZm9yLWNoaXBzZmIucGF0Y2gKClBhdGNoIGZyb20g
Mi42LjEyLXJjNi1tbTEKClBhdGNoIGFkZHMgcGNpIElEIGZvciBDVCA2OTAwMCBjaGlwc2V0
LgoKU2lnbmVkLW9mZi1ieTogSmFtZXMgU2ltbW9ucyA8anNpbW1vbnNAd3d3LmluZnJhZGVh
ZC5vcmc+ClNpZ25lZC1vZmYtYnk6IEFuZHJldyBNb3J0b24gPGFrcG1Ab3NkbC5vcmc+Ci0t
LQoKIGluY2x1ZGUvbGludXgvcGNpX2lkcy5oIHwgICAgMSArCiAxIGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCgoKPT09PT09PT0gZGlmZiBhZ2FpbnN0IDQ1YWRiYjExNzJiNDVh
NjAwZmUzNDFmOWY0NGZhMDJmZWQxMzE1ZGEgPT09PT09PT0KZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvcGNpX2lkcy5oIGIvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgKLS0tIGEvaW5j
bHVkZS9saW51eC9wY2lfaWRzLmgKKysrIGIvaW5jbHVkZS9saW51eC9wY2lfaWRzLmgKQEAg
LTU3NSw2ICs1NzUsNyBAQAogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0NUXzY1NTUwCQkweDAw
ZTAKICNkZWZpbmUgUENJX0RFVklDRV9JRF9DVF82NTU1NAkJMHgwMGU0CiAjZGVmaW5lIFBD
SV9ERVZJQ0VfSURfQ1RfNjU1NTUJCTB4MDBlNQorI2RlZmluZSBQQ0lfREVWSUNFX0lEX0NU
XzY5MDAwCQkweDAwYzAKIAogI2RlZmluZSBQQ0lfVkVORE9SX0lEX01JUk8JCTB4MTAzMQog
I2RlZmluZSBQQ0lfREVWSUNFX0lEX01JUk9fMzYwNTAJMHg1NjAxCj09PT09PT09IGVuZCA9
PT09PT09PQoK
--------------070807010509050106050507--
