From: Tad Hardesty <tad.hardesty@suddenlink.net>
Subject: Re: 'git status -z' missing separators on OSX
Date: Wed, 17 Jun 2015 09:07:36 -0500
Message-ID: <20150617140738.UMQU25489.txasav-vm07.suddenlink.net@[10.1.40.186]>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Tad Hardesty <tad@platymuus.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 16:28:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5EK6-0005jx-RX
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 16:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755468AbbFQO2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 10:28:10 -0400
Received: from txasav-vm07.suddenlink.net ([208.180.40.76]:52032 "EHLO
	txasav-vm07.suddenlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753509AbbFQO2I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2015 10:28:08 -0400
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2015 10:28:08 EDT
Received: from [10.1.40.186] (really [71.41.150.122])
          by txasav-vm07.suddenlink.net
          (InterMail vM.8.04.03.20 201-2389-100-164-20150330) with ESMTP
          id <20150617140738.UMQU25489.txasav-vm07.suddenlink.net@[10.1.40.186]>;
          Wed, 17 Jun 2015 09:07:38 -0500
X-Cloudmark-Analysis: v=2.1 cv=NYNo1gz4 c=1 sm=0 tr=0 a=IkcTkHD0fZMA:10 a=8LaAqv5HAAAA:8 a=XAFQembCKUMA:10 a=anyJmfQTAAAA:8 a=n9LriQeKPi3LrvAZ6aUA:9 a=QEXdDO2ut3YA:10 a=UYlvzS5tCXYA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271846>

RXZlcnl0aGluZyBsb29rcyBub3JtYWwgdXNpbmcgdGhlIGNvbW1hbmRzIHlvdSBkZXNjcmliZWQs
IGFuZCBpdCBkb2VzIGFwcGVhciB0byBvbmx5IGFmZmVjdCBzdGF0dXM6Cgp+L3Rlc3QgKG1hc3Rl
cikkIHR5cGUgZ2l0CmdpdCBpcyBoYXNoZWQgKC91c3IvbG9jYWwvYmluL2dpdCkKfi90ZXN0ICht
YXN0ZXIpJCBnaXQgY29uZmlnIC0tbGlzdApjb3JlLnJlcG9zaXRvcnlmb3JtYXR2ZXJzaW9uPTAK
Y29yZS5maWxlbW9kZT10cnVlCmNvcmUuYmFyZT1mYWxzZQpjb3JlLmxvZ2FsbHJlZnVwZGF0ZXM9
dHJ1ZQpjb3JlLmlnbm9yZWNhc2U9dHJ1ZQpjb3JlLnByZWNvbXBvc2V1bmljb2RlPXRydWUKfi90
ZXN0IChtYXN0ZXIpJCBHSVRfVFJBQ0U9MSBnaXQgc3RhdHVzIC16CjA4OjU5OjExLjgwNjE5NyBn
aXQuYzozNDjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYWNlOiBidWlsdC1pbjogZ2l0
ICdzdGF0dXMnICcteicKfi90ZXN0IChtYXN0ZXIpJCBnaXQgbG9nIC0tb25lbGluZSAtMSAteiB8
IGhleGR1bXAgLUMKMDAwMDAwMDDCoCAzNSAzMSAzNSAzOSAzMCA2NSAzMCAyMMKgIDQ5IDZlIDY5
IDc0IDY5IDYxIDZjIDIwwqAgfDUxNTkwZTAgSW5pdGlhbCB8CjAwMDAwMDEwwqAgNjMgNmYgNmQg
NmQgNjkgNzQgMmUgMDDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHxjb21taXQuLnwKMDAwMDAwMTgKfi90ZXN0IChtYXN0ZXIpJCB0b3VjaCBjIGQK
fi90ZXN0IChtYXN0ZXIpJCBnaXQgc3RhdHVzIC16IHwgaGV4ZHVtcCAtQwowMDAwMDAwMMKgIDNm
IDNmIDIwIDYzIDNmIDNmIDIwIDY0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8Pz8gYz8/IGR8CjAwMDAwMDA4CgpUaGlzIGlzIGFnYWluIHdpdGgg
Mi40LjMgZnJvbSBnaXQtc2NtLmNvbS4K
