From: Jongman Heo <jongman.heo@samsung.com>
Subject: Re: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 01 Feb 2013 09:14:42 +0000 (GMT)
Message-ID: <17285958.791361359710080706.JavaMail.weblogic@epml01>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Cc: Jeff King <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>,
	git <git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 10:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1CiC-0005bB-Jl
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 10:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756058Ab3BAJOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 04:14:46 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21225 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837Ab3BAJOo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 04:14:44 -0500
Received: from epcpsbge8.samsung.com (epcpsbge8 [203.254.230.18])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHJ00MMHAVTLDX0@mailout2.samsung.com> for
 git@vger.kernel.org; Fri, 01 Feb 2013 18:14:42 +0900 (KST)
Received: from epcpsbge8.samsung.com ( [203.254.230.42])
	by epcpsbge8.samsung.com (EPCPMTA) with SMTP id 60.CA.14510.2878B015; Fri,
 01 Feb 2013 18:14:42 +0900 (KST)
X-AuditID: cbfee612-b7fcf6d0000038ae-f7-510b8782a566
Received: from epextmailer01 ( [203.254.219.151])
	by epcpsbge8.samsung.com (EPCPMTA) with SMTP id 20.CA.14510.2878B015; Fri,
 01 Feb 2013 18:14:42 +0900 (KST)
X-MTR: 20130201091240355@jongman.heo
Msgkey: 20130201091240355@jongman.heo
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130201091240355@jongman.heo
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsVy+t8zLd2mdu5Ag+Wz5C26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJWxtbuPqWAeV8XHD8fYGhh/cHYxcnIICahJ3Px8iBHElhAwkfj+
	eT07hC0mceHeerYuRi6gmmWMEjOWnWeBKWr4MYsJIjGfUaLrSA8bSIJFQEXiy/a/rCA2m4CO
	RMf//WC2sICdxOGWdjBbREBD4mXjZjCbWWAio8SxvfYQVyhKXFu6GGwOr4CgxMmZT6CWqUj8
	nfmdFSKuKrGlaTbUdRISs6ZfYIWweSVmtD+FqpeTmPZ1DTOELS1xftYGRphvFn9/DBXnlzh2
	ewfQAxxgvU/uB8OM2b35CxuELSAx9cxBRogSTYkvDyQhwnwSaxa+ZYGZsuvUcmaY1vtb5jJB
	fKUoMaX7ITuErSXx5cc+DF/xCjhJTJ/3iXkCo/IsJKlZSNpnIWlHVrOAkWUVo2hqQXJBcVJ6
	qoVecWJucWleul5yfu4mRkhaENrBuKzB4hCjAAejEg9vwXeuQCHWxLLiytxDjBIczEoivLa1
	3IFCvCmJlVWpRfnxRaU5qcWHGJOB8TeRWUo0OR+YsvJK4g2NDYwNDS0NzUwtTQ1IE1YS5+Ws
	mB4gJJCeWJKanZpakFoEs4WJg1OqgbH+1ln2vhOtf3+zrVY+U3tv9RPf6w8OsG623RmwVfJD
	V4t0cpv7feYb67iDXSevnbPGLv99/4S2OU0i0Z/zPrlN5qv6yno6f8/cuBs6Ra2nBKpNNZlf
	33WYyfx1rUzpyYKZ29cXPLLs8+nWDU0zq6ucvZ8t6UyPiPVrWVFjzXO34lM/XSl3 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42I5/e/2dN2mdu5Ag6X/JS26rnQzOTB6fN4k
	F8AYlWGTkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZAzRU
	SaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrFG1kYKxnZGqiZ2RsoGdiEGtlaGBgZApUlZCR
	sbW7j6lgHlfFxw/H2BoYf3B2MXJyCAmoSdz8fIgRxJYQMJFo+DGLCcIWk7hwbz1bFyMXUM18
	RomuIz1sIAkWARWJL9v/soLYbAI6Eh3/94PZwgJ2Eodb2sFsEQENiZeNm8FsZoGJjBLH9tpD
	LFOUuLZ0MdgcXgFBiZMzn7BALFOR+DvzOytEXFViS9Nsdoi4hMSs6RdYIWxeiRntT6Hq5SSm
	fV3DDGFLS5yftYER5ujF3x9Dxfkljt3eAfQMB1jvk/vBMGN2b/7CBmELSEw9c5ARokRT4ssD
	SYgwn8SahW9ZYKbsOrWcGab1/pa5TBBfKUpM6X7IDmFrSXz5sQ/DV7wCThLT531insAoNwtJ
	ahaS9llI2pHVLGBkWcUomlqQXFCclJ5qoVecmFtcmpeul5yfu4kRnKCeCe1gXNZgcYhRgINR
	iYe34DtXoBBrYllxZe4hRgkOZiURXtta7kAh3pTEyqrUovz4otKc1OJDjMnA+JvILCWanA9M
	nnkl8YbGBsaGhpbmBqaGRhakCSuJ83JWTA8QEkhPLEnNTk0tSC2C2cLEwSnVwDizSGb13aqE
	AJHOLRLnVK84bFRb9Oy00by3SlVC56Wnf/W8H3uvSlj+QWDWmQMf9xR9mlTG1SVZ 
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215223>

DQpKdW5pbyBDIEhhbWFubzxnaXRzdGVyQHBvYm94LmNvbT4gd3JvdGUgOg0KPiDH48G+uLggd3Jp
dGVzOg0KPj4gQnV0IHVzdWFsbHkgd2hlbiBJIGJ1aWxkIHVwc3RyZWFtIExpbnV4IGtlcm5lbCwg
SSBkb24ndCBkbyAibWFrZQ0KPj4gY2xlYW4iIGFmdGVyIGdpdCBwdWxsLi4gIEkgZGlkbid0IGV4
cGVjdCB0aGF0IEkgbmVlZGVkICJtYWtlDQo+PiBjbGVhbiIgZm9yIGdpdCBidWlsZC4NCj4NCj4g
V2UgZG9uJ3QgZXhwZWN0IGFueWJvZHkgbmVlZCAibWFrZSBjbGVhbiIsIGVpdGhlci4gIFRoZXJl
IGlzDQo+IHNvbWV0aGluZyB3cm9uZyBpbiB0aGUgZGVwZW5kZW5jeS4NCg0KDQpIaSBhbGwsDQoN
CkkgY2FuIHJlcHJvZHVjZSB0aGUgaXNzdWUgaW4gbXkgbWFjaGluZSAoUmVkSGF0IEVudGVycHJp
c2UgNSwgeDg2IFBBRSkgYXMgZm9sbG93cy4gDQpCdXQgaW4gbXkgZGlmZmVyZW50IG1hY2hpbmUg
KEZlZG9yYSAxNiB4ODYpIEkgY2FuJ3QgcmVwcm9kdWNlLg0KDQogICQgZ2l0IHJlc2V0IC0taGFy
ZCB2MS44LjEgICAgICAgIyBiYWNrIHRvIHYxLjguMQ0KICAkIG1ha2UgY2xlYW4gDQogICQgbWFr
ZSBhbGwgaW5zdGFsbCAgICAgICAgICAgICAgICMgdGhpcyBnaXQgd29ya3MgZmluZQ0KDQogICQg
Z2l0IHB1bGwgICAgICAgICAgICAgICAgICAgICAgICAgICMgdG9wIGNvbW1pdCA5YTZjODRlNiwg
Ik1lcmdlIGdpdDovL296bGFicy5vcmcvfnBhdWx1cy9naXRrIg0KICAkIG1ha2UgYWxsIGluc3Rh
bGwNCg0KICAkIGdpdCBmZXRjaCAgICAgICAgICAgICAgICAgICAgICAgICAjIHRoaXMgZ2l0IHNl
Z2ZhdWx0cw0KICBTZWdtZW50YXRpb24gZmF1bHQNCg0KDQpTbyBpZiB0aGVyZSBpcyBhbnkgcGF0
Y2ggdG8gdGVzdCwganVzdCBsZXQgbWUga25vdyAgKGJ1dCB3aWxsIG5vdCBhdmFpbGFibGUgZHVy
aW5nIHdlZWtlbmQpLg0KDQoNClJlZ2FyZHMsDQpKb25nbWFuIEhlbw==
