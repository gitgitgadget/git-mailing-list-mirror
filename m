From: Jongman Heo <jongman.heo@samsung.com>
Subject: Re: Re: Re: Re: Segmentation fault with latest git (070c57df)
Date: Fri, 01 Feb 2013 10:59:39 +0000 (GMT)
Message-ID: <27376267.797831359716377823.JavaMail.weblogic@epml01>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 12:00:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1EM6-0007tq-TI
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 12:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161249Ab3BAK7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 05:59:48 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:17027 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161223Ab3BAK7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 05:59:44 -0500
Received: from epcpsbge5.samsung.com (epcpsbge5 [203.254.230.15])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHJ008WOFUJ7NR0@mailout4.samsung.com> for
 git@vger.kernel.org; Fri, 01 Feb 2013 19:59:39 +0900 (KST)
Received: from epcpsbge5.samsung.com ( [203.254.230.41])
	by epcpsbge5.samsung.com (EPCPMTA) with SMTP id 1D.82.09096.B10AB015; Fri,
 01 Feb 2013 19:59:39 +0900 (KST)
X-AuditID: cbfee60f-b7f296d000002388-26-510ba01ba2e1
Received: from epextmailer02 ( [203.254.219.152])
	by epcpsbge5.samsung.com (EPCPMTA) with SMTP id FC.82.09096.B10AB015; Fri,
 01 Feb 2013 19:59:39 +0900 (KST)
X-MTR: 20130201105808712@jongman.heo
Msgkey: 20130201105808712@jongman.heo
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130201105808712@jongman.heo
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsVy+t8zTV3pBdyBBrPvKFp0XelmcmD0+LxJ
	LoAxissmJTUnsyy1SN8ugSvj1qaTTAVTeCv23X7J0sD4hKeLkZNDSEBN4ubnQ4wgtoSAicSF
	vxfZIGwxiQv31gPZXEA1yxglJrz9wwJTdOLAFFaI5vmMEncmlILYLAIqEqumbQBrZhPQkej4
	vx+sRljATeLYtOVMILaIgLzErWkLwYYyC8xilHjYvIcFYpCixLWli8GaeQUEJU7OfAK1TEXi
	9//HQHEOoLiqxM+V/hBhCYlZ0y+wQti8EjPan0KVy0lM+7qGGcKWljg/awMjzDOLvz+GivNL
	HLu9gwlkJEjvk/vBMGN2b/4C9buAxNQzB6FaNSWOTJ/HBGHzSaxZ+JYFZsyuU8uZYXrvb5kL
	VsMM9MmU7ofsELaWxJcf+zB8xSvgJLHszFK2CYzKs5CkZiFpn4WkHVnNAkaWVYyiqQXJBcVJ
	6ammesWJucWleel6yfm5mxghaYF/B+OiBotDjAIcjEo8vCd+cgUKsSaWFVfmHmKU4GBWEuG1
	reUOFOJNSaysSi3Kjy8qzUktPsSYDIzAicxSosn5wJSVVxJvaGxgbGhoaWhmamlqQJqwkjgv
	e8X0ACGB9MSS1OzU1ILUIpgtTBycUg2MW14JiL5OfnGrgLvQ9Xg7G0tp4hbWHh65bJvjlgIc
	VgWHHx1w/VBtviX+lrtn1k7psO2tx9Ld33lrr2PTyGvy5Vsk03LN+I7u1kjb2e1ymTt1Dn9j
	K2NVCZGRmBO8vP6vv+dlBatnf453qFo1hz+d+ObSkpfsRh8C3PYZLosriu/8f2vl 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42I5/e/2DF3pBdyBBh9vyVh0XelmcmD0+LxJ
	LoAxKsMmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2io
	kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKdrIwFjPyNREz8jYQM/EINbK0MDAyBSoKiEj
	49amk0wFU3gr9t1+ydLA+ISni5GTQ0hATeLm50OMILaEgInEiQNTWCFsMYkL99azQdTMZ5S4
	M6EUxGYRUJFYNW0DWJxNQEei4/9+sHphATeJY9OWM4HYIgLyEremLQSq4eJgFpjFKPGweQ8L
	xCBFiWtLF4M18woISpyc+YQFYpmKxO//j4HiHEBxVYmfK/0hwhISs6ZfgLqHV2JG+1OocjmJ
	aV/XMEPY0hLnZ21ghLl58ffHUHF+iWO3dzCBjATpfXI/GGbM7s1f2CBsAYmpZw5CtWpKHJk+
	jwnC5pNYs/AtC8yYXaeWM8P03t8yF6yGGeiTKd0P2SFsLYkvP/Zh+IpXwEli2ZmlbBMY5WYh
	Sc1C0j4LSTuymgWMLKsYRVMLkguKk9JTTfWKE3OLS/PS9ZLzczcxghPUM/4djIsaLA4xCnAw
	KvHwnvjJFSjEmlhWXJl7iFGCg1lJhNe2ljtQiDclsbIqtSg/vqg0J7X4EGMyMAInMkuJJucD
	k2deSbyhsYGxoaGluYGpoZEFacJK4rzsFdMDhATSE0tSs1NTC1KLYLYwcXBKNTBqvpgUv7vy
	E6f4vL/hy/infj7B92rz96UOHjY7L0psYeWZPfdVg9pjw9BDvLc6uZujs86/Dt7R 
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215234>

DQo+PiBbLi4uXQ0KPj4gIEZpbmlzaGVkIHByZXJlcXVpc2l0ZXMgb2YgdGFyZ2V0IGZpbGUgYGJ1
aWx0aW4vZmV0Y2gubycuDQo+PiAgUHJlcmVxdWlzaXRlIGBidWlsdGluL2ZldGNoLmMnIGlzIG9s
ZGVyIHRoYW4gdGFyZ2V0IGBidWlsdGluL2ZldGNoLm8nLg0KPj4gIFByZXJlcXVpc2l0ZSBgR0lU
LUNGTEFHUycgaXMgb2xkZXIgdGhhbiB0YXJnZXQgYGJ1aWx0aW4vZmV0Y2gubycuDQo+PiBObyBu
ZWVkIHRvIHJlbWFrZSB0YXJnZXQgYGJ1aWx0aW4vZmV0Y2gubycuDQo+DQo+QnV0IGl0IGRvZXNu
J3Qgc3RpbXVsYXRlIGFueSBwcmVyZXF1aXNpdGVzIGluIG1ha2UsIHdoaWNoIGlzIHdlaXJkLg0K
PldoYXQncyBpbiBidWlsdGluLy5kZXBlbmQvZmV0Y2guby5kPw0KPg0KPi1QZWZmDQoNCkhpLCAN
Cg0KcGxlYXNlIHNlZSBiZWxvd34uDQoNCiQgY2F0IGJ1aWx0aW4vLmRlcGVuZC9mZXRjaC5vLmQg
ICAgICAgICAgICANCmZldGNoLm86IGJ1aWx0aW4vZmV0Y2guYyBjYWNoZS5oIGdpdC1jb21wYXQt
dXRpbC5oIGNvbXBhdC9ic3dhcC5oIFwNCiAgc3RyYnVmLmggaGFzaC5oIGFkdmljZS5oIGdldHRl
eHQuaCBjb252ZXJ0LmggcmVmcy5oIGNvbW1pdC5oIG9iamVjdC5oIFwNCiAgdHJlZS5oIGRlY29y
YXRlLmggYnVpbHRpbi5oIGNhY2hlLmggY29tbWl0Lmggbm90ZXMuaCBzdHJpbmctbGlzdC5oIFwN
CiAgc3RyaW5nLWxpc3QuaCByZW1vdGUuaCB0cmFuc3BvcnQuaCByZW1vdGUuaCBydW4tY29tbWFu
ZC5oIFwNCiAgcGFyc2Utb3B0aW9ucy5oIHNpZ2NoYWluLmggc3VibW9kdWxlLmggY29ubmVjdGVk
LmggYXJndi1hcnJheS5oDQoNCmNhY2hlLmg6DQoNCmdpdC1jb21wYXQtdXRpbC5oOg0KDQpjb21w
YXQvYnN3YXAuaDoNCg0Kc3RyYnVmLmg6DQoNCmhhc2guaDoNCg0KYWR2aWNlLmg6DQoNCmdldHRl
eHQuaDoNCg0KY29udmVydC5oOg0KDQpyZWZzLmg6DQoNCmNvbW1pdC5oOg0KDQpvYmplY3QuaDoN
Cg0KdHJlZS5oOg0KDQpkZWNvcmF0ZS5oOg0KDQpidWlsdGluLmg6DQoNCmNhY2hlLmg6DQoNCmNv
bW1pdC5oOg0KDQpub3Rlcy5oOg0KDQpzdHJpbmctbGlzdC5oOg0KDQpzdHJpbmctbGlzdC5oOg0K
DQpyZW1vdGUuaDoNCg0KdHJhbnNwb3J0Lmg6DQoNCnJlbW90ZS5oOg0KDQpydW4tY29tbWFuZC5o
Og0KDQpwYXJzZS1vcHRpb25zLmg6DQoNCnNpZ2NoYWluLmg6DQoNCnN1Ym1vZHVsZS5oOg0KDQpj
b25uZWN0ZWQuaDoNCg0KYXJndi1hcnJheS5oOg==
