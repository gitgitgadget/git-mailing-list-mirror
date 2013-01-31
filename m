From: Jongman Heo <jongman.heo@samsung.com>
Subject: Segmentation fault with latest git (070c57df)
Date: Thu, 31 Jan 2013 01:35:21 +0000 (GMT)
Message-ID: <28799936.346521359596121253.JavaMail.weblogic@epmltmp3>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 02:35:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0j45-00051t-SL
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 02:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab3AaBfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 20:35:24 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:54897 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3AaBfX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 20:35:23 -0500
Received: from epcpsbge3.samsung.com (epcpsbge3 [203.254.230.13])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MHG00M20V0JOB90@mailout2.samsung.com> for
 git@vger.kernel.org; Thu, 31 Jan 2013 10:35:21 +0900 (KST)
Received: from epcpsbge3.samsung.com ( [203.254.230.46])
	by epcpsbge3.samsung.com (EPCPMTA) with SMTP id 0E.DF.04166.95AC9015; Thu,
 31 Jan 2013 10:35:21 +0900 (KST)
X-AuditID: cbfee60d-b7f766d000001046-d1-5109ca59c2e2
Received: from epextmailer03 ( [203.254.219.153])
	by epcpsbge3.samsung.com (EPCPMTA) with SMTP id DD.DF.04166.95AC9015; Thu,
 31 Jan 2013 10:35:21 +0900 (KST)
X-MTR: 20130131012838591@jongman.heo
Msgkey: 20130131012838591@jongman.heo
X-EPLocale: ko_KR.euc-kr
X-Priority: 3
X-EPWebmail-Msg-Type: personal
X-EPWebmail-Reply-Demand: 0
X-EPApproval-Locale: 
X-EPHeader: ML
X-EPTrCode: 
X-EPTrName: 
X-MLAttribute: 
X-RootMTR: 20130131012838591@jongman.heo
X-ParentMTR: 
X-ArchiveUser: 
X-CPGSPASS: N
MIME-version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsVy+t8zPd3IU5yBBh++Kll0XelmcmD0+LxJ
	LoAxissmJTUnsyy1SN8ugSvj/sFfTAWbWCueL3/P3sA4h7WLkZNDSEBN4ubnQ4xdjBwcEgIm
	Eg8eKIGEJQTEJC7cW88GUbKMUWLSJBeIuInEomsv2LsYuYDi8xkl9rY+YQFJsAioSpzacwWs
	gU1AR6Lj/36w+cICZhLPrz8As0UEZCTu3XoOtVdR4trSxWD1vAKCEidnQsyREFCRmLtvFStE
	XFXizecbbBBxCYlZ0y+wQti8EjPan0LVy0lM+7qGGcKWljg/awMjzAOLvz+GivNLHLu9gwni
	R16JJ/eDYcbs3vwFaryAxNQzB6FaNSXef9oDtYpPYs3CtywwY3adWs4M03t/y1wmEJsZ6JUp
	3Q/ZIWwtiS8/9mF4i1fARWLuClCQcAH19nJIrHvxk30Co9IsJHWzkMyahWQWspoFjCyrGEVT
	C5ILipPSU431ihNzi0vz0vWS83M3MULSAu8OxrkNFocYBTgYlXh4H0znDBRiTSwrrsw9xCjB
	wawkwnvIBCjEm5JYWZValB9fVJqTWnyIMRkYgxOZpUST84EpK68k3tDYwNjQ0NLQzNTS1IA0
	YSVxXsWK6QFCAumJJanZqakFqUUwW5g4OKUaGKPf3DnDISJdoaYY4f9cy1W2QqH/zo0/1pHx
	KsarpebdS7+1spO3/Se7oNKHv2FWdnW2POqiHK1e2e1HXxq13/+7aHLgrcO+8QuZWoskegI/
	eWvJOvj13dzIGvI6s5uF5Z6FT5fhUpmot1M5TsSocWrZCn3pkF7wcc9+5m1e57w/ 
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsVy+t/tmbqRpzgDDa48lrXoutLN5MDo8XmT
	XABjVIZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBQ
	JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUrSRgbGekamJnpGxgZ6JQayVoYGBkSlQVUJG
	xv2Dv5gKNrFWPF/+nr2BcQ5rFyMnh5CAmsTNz4cYQWwJAROJRddesEPYYhIX7q1n62LkAqqZ
	zyixt/UJC0iCRUBV4tSeK2wgNpuAjkTH//1gg4QFzCSeX38AZosIyEjcu/UcaoGixLWli8Hq
	eQUEJU7OhJgjIaAiMXffKlaIuKrEm8832CDiEhKzpl9ghbB5JWa0P4Wql5OY9nUNM4QtLXF+
	1gZGmEMXf38MFeeXOHZ7B1MXIwdY75P7wTBjdm/+AjVeQGLqmYNQrZoS7z/tgVrFJ7Fm4VsW
	mDG7Ti1nhum9v2UuE4jNDPTKlO6H7BC2lsSXH/swvMUr4CIxd8V+1gmMsrOQpGYhaZ+FpB1Z
	zQJGllWMoqkFyQXFSempxnrFibnFpXnpesn5uZsYwanoGe8OxrkNFocYBTgYlXh4H0znDBRi
	TSwrrsw9xCjBwawkwnvIBCjEm5JYWZValB9fVJqTWnyIMRkYaROZpUST84FpMq8k3tDYwNjQ
	0NLcwNTQyII0YSVxXsWK6QFCAumJJanZqakFqUUwW5g4OKUaGPOMlu2t7j1SVGlScvywf2pU
	RsjRawKRu787bn/O/F9NZ/d6ddYlMYd1P1g5m/JV183qqY8/X5xWnLUqmrn5aHZO 
DLP-Filter: Pass
X-CFilter-Loop: Reflected
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215082>

DQpIaSBhbGwsDQoNCkxvb2tzIGxpa2UgZm9sbG93aW5nIGNvbW1pdCBjYXVzZXMgYSBzZWdtZW50
YXRpb24gZmF1bHQgaW4gbXkgbWFjaGluZSAod2hlbiBydW5uaW5nIGdpdCBwdWxsIG9yIGdpdCBm
ZXRjaCk7DQoNCmNvbW1pdCA4ZGQ1YWZjOTI2YWNiOTgyOWViZjU2ZTliNzg4MjZhNTI0MmNkNjM4
DQpBdXRob3I6IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT4NCkRhdGU6ICAgTW9u
IEphbiA3IDEyOjI0OjU1IDIwMTMgLTA4MDANCg0KICAgIHN0cmluZy1saXN0OiBhbGxvdyBjYXNl
LWluc2Vuc2l0aXZlIHN0cmluZyBsaXN0DQoNCg0KSW4gbXkgY2FzZSwgbGlzdC0+Y21wIChhdCBn
ZXRfZW50cnlfaW5kZXgoKSBmdW5jdGlvbikgaGFzIGFuIGludmFsaWQgYWRkcmVzcywgb2J2aW91
c2x5IG5vdCBhbiBhZGRyZXNzIG9mIHN0cmluZyBjb21wYXJpc2lvbiBmdW5jdGlvbiwgaW5zdGVh
ZCBpdCBwb2ludHMgdG8gMS4NCg0KDQpSZWdhcmRzLA0KSm9uZ21hbiBIZW8u
