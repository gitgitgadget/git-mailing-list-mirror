From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
 efficiently lookup sha1
Date: Sun, 05 Apr 2009 11:59:07 -0700
Message-ID: <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
 <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:01:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqXaV-00017X-Rs
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbZDES7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 14:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbZDES7Q
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 14:59:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbZDES7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 14:59:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BEC83C94B;
	Sun,  5 Apr 2009 14:59:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 17B5DC946; Sun, 
 5 Apr 2009 14:59:08 -0400 (EDT)
In-Reply-To: <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
 (Sverre Rabbelier's message of "Sun, 5 Apr 2009 12:17:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DAC46072-2213-11DE-BCFB-DD19768B9EAE-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115677>

U3ZlcnJlIFJhYmJlbGllciA8c3JhYmJlbGllckBnbWFpbC5jb20+IHdyaXRlczoNCg0KPiBPbiBT
YXQsIEFwciA0LCAyMDA5IGF0IDIyOjU5LCBDaHJpc3RpYW4gQ291ZGVyIDxjaHJpc2Nvb2xAdHV4
ZmFtaWx5Lm9yZz4gd3JvdGU6DQo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGlmIChsbyA8PSBtaSAmJiBtaSA8IGhpKQ0KPj4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBicmVhazsNCj4+ICsg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllKCJvb3BzIik7
DQo+DQo+IFRoYXQncyBnb2luZyB0byBiZSBhbiBvZmZpY2lhbCBnaXQgZXJyb3IgbWVzc2FnZT8g
V2h5IG5vdCBtYWtlIGl0ICJUaGUNCg0KSXQncyBub3QgImdvaW5nIHRvIGJlIiwgYnV0ICJoYXMg
YmVlbiBzbyBmb3IgdGhlIGxhc3QgdHdvIHllYXJzIHNpbmNlDQo1ZDIzZTEzIi4NCg0KSXQgaXMg
YW4gYXNzZXJ0LCBhbmQgSSB0aGluayBQZWZmJ3MgZGllKCJCVUc6IC4uLiIpIHdvdWxkIGJlIGEg
Z29vZCBpZGVhLg0K
