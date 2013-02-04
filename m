From: Jongman Heo <jongman.heo@samsung.com>
Subject: Re: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 04 Feb 2013 06:58:27 +0000 (GMT)
Message-ID: <12070540.431901359961105650.JavaMail.weblogic@epml10>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 07:59:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2G1X-0004Hq-J7
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 07:59:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab3BDG6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 01:58:30 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:16192 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3BDG63 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 01:58:29 -0500
Received: from epcpsbge7.samsung.com (epcpsbge7 [203.254.230.17])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHO00KO5OIJOIQ0@mailout3.samsung.com> for
 git@vger.kernel.org; Mon, 04 Feb 2013 15:58:28 +0900 (KST)
Received: from epcpsbge7.samsung.com ( [203.254.230.42])
	by epcpsbge7.samsung.com (EPCPMTA) with SMTP id 44.C1.10066.31C5F015; Mon,
 04 Feb 2013 15:58:28 +0900 (KST)
X-AuditID: cbfee611-b7f1c6d000002752-a2-510f5c13b366
Received: from epextmailer01 ( [203.254.219.151])
	by epcpsbge7.samsung.com (EPCPMTA) with SMTP id 14.C1.10066.31C5F015; Mon,
 04 Feb 2013 15:58:27 +0900 (KST)
X-MTR: 20130204065608887@jongman.heo
Msgkey: 20130204065608887@jongman.heo
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130204065608887@jongman.heo
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsVy+t8zLV2RGP5Ag7eHmS26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJWx+uwe5oJFrBVzJ0xhb2DsYe1i5OQQElCTuPn5EGMXIweHhICJ
	xI6rjCBhCQExiQv31rN1MXIBlSxjlLh/+CwzRMJE4tWNdmaIxHxGic7ma+wgzSwCKhInNiSB
	1LAJ6Eh0/N8PNl9YwE7icEs7mC0ioCXx7vdtRpBeZoGdjBJX5txkhDhCUeLa0sVsIDavgKDE
	yZlPWCCWqUjMuLiXESKuKvH2cQ87RFxCYtb0C6wQNq/EjPanUPVyEtO+roE6VFri/KwNcN8s
	/v4YKs4vcez2DiaIh3klntwPhhmze/MXNghbQGLqmYNQrZoSRzb8g7L5JNYsfMsCM2bXqeXM
	ML33t8xlArGZgV6Z0v2QHcLWkvjyYx+Gt3gFnCTmTm9gm8CoPAtJahaS9llI2pHVLGBkWcUo
	mlqQXFCclJ5qrlecmFtcmpeul5yfu4kRkhYEdzAubbA4xCjAwajEw8vwiy9QiDWxrLgy9xCj
	BAezkgjvVSOgEG9KYmVValF+fFFpTmrxIcZkYAROZJYSTc4Hpqy8knhDYwNjQ0NLQzNTS1MD
	0oSVxHk5K6YHCAmkJ5akZqemFqQWwWxh4uCUamAMmbdRX/+lRPDqXeu3lXGYl29RFS24/fIL
	z87ljPKdE/lvPZ574Xh23CbXa2t1rvrd5lqk1dAzNcVIpD5gn9+BrZ/Cl5fG9ObWW25YWPhl
	PkNeX/YcW4/TPAkFf/9d5//xZ9Jyb5l7tsxOvz99702fZq4zef2zudnJG0L9z/o0 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42I5/e/2dF3hGP5AgzcHrS26rnQzOTB6fN4k
	F8AYlWGTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZAzRU
	SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrFG1kYKxnZGqiZ2RsoGdiEGtlaGBgZApUlZCR
	sfrsHuaCRawVcydMYW9g7GHtYuTkEBJQk7j5+RAjiC0hYCLx6kY7M4QtJnHh3nq2LkYuoJr5
	jBKdzdfYuxg5OFgEVCRObEgCqWET0JHo+L8fbI6wgJ3E4ZZ2MFtEQEvi3e/bjCC9zAI7GSWu
	zLnJCLFMUeLa0sVsIDavgKDEyZlPWCCWqUjMuLiXESKuKvH2cQ87RFxCYtb0C6wQNq/EjPan
	UPVyEtO+roE6VFri/KwNjDBHL/7+GCrOL3Hs9g4mkJtBep/cD4YZs3vzFzYIW0Bi6pmDUK2a
	Ekc2/IOy+STWLHzLAjNm16nlzDC997fMZQKxmYFemdL9kB3C1pL48mMfhrd4BZwk5k5vYJvA
	KDcLSWoWkvZZSNqR1SxgZFnFKJpakFxQnJSeaq5XnJhbXJqXrpecn7uJEZyingnuYFzaYHGI
	UYCDUYmHl+EXX6AQa2JZcWXuIUYJDmYlEd6rRkAh3pTEyqrUovz4otKc1OJDjMnACJzILCWa
	nA9Mn3kl8YbGBsaGhpbmBqaGRhakCSuJ83JWTA8QEkhPLEnNTk0tSC2C2cLEwSnVwDjv1tRv
	b+aluk/4abii7v6OPfXr+oUEGV+3sXN/67om7SpiVBuff27D5At9B4orUmaU/Mrd 
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215359>

DQpKb25hdGhhbiBOaWVkZXIgd3JvdGU6DQo+IEpvbmdtYW4gSGVvIHdyb3RlOg0KPiANCj4+IFVu
Zm9ydHVuYXRlbHksIHRoZSBwYXRjaCBkaWRuJ3QgaGVscCB0byBtZS4NCj4NCj5UaGFua3MgZm9y
IHRlc3RpbmcuICBEaWQgeW91IGFwcGx5IHRoZSBwYXRjaCB0byB0aGUgb2xkZXIgdmVyc2lvbiBv
Zg0KPmdpdCB0aGF0IGdlbmVyYXRlcyBidWlsdGluLy5kZXBlbmQvZmV0Y2guby5kIG9yIHRoZSBu
ZXdlciB2ZXJzaW9uIHRoYXQNCj5jb25zdW1lcyBpdD8NCj4NCj5DdXJpb3VzLA0KPkpvbmF0aGFu
DQoNCkhpLCBKb25hdGhhbiwNCg0KSSBhcHBsaWVkIHRoZSBwYXRjaCB0byBuZXdlciB2ZXJzaW9u
LiANCg0KVGhpcyB0aW1lLCBJIHRyaWVkIHRvIGFwcGx5IHRoZSBwYXRjaCB0byBvbGRlciB2ZXJz
aW9uIG9mIE1ha2VmaWxlLCBhbmQgbm93IHRoZSBpc3N1ZSBpcyBmaXhlZH4uIA0KVGhhbmtzfiEN
Cg0KQmVzdCByZWdhcmRzLA0KSm9uZ21hbiBIZW8NCg==
