From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
Subject: git pull does no longer work due to a Cr-Lf issue
Date: Fri, 31 Jan 2014 16:01:38 +0100
Message-ID: <52EBBAD2.3020501@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org" <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>,
	"git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
X-From: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org Fri Jan 31 16:01:45 2014
Return-path: <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Envelope-to: gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from mailapps1.ssl.berkeley.edu ([128.32.13.237])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>)
	id 1W9FbE-0003XZ-Do
	for gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Fri, 31 Jan 2014 16:01:44 +0100
Received: from mailapps1.ssl.berkeley.edu (localhost [127.0.0.1])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id 8F1D92FEB95;
	Fri, 31 Jan 2014 07:01:42 -0800 (PST)
X-Original-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Delivered-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Received: from mail2.ssl.berkeley.edu (mail2.ssl.berkeley.edu [128.32.13.252])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id DE31A2FE81C
	for <boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org>;
	Fri, 31 Jan 2014 07:01:41 -0800 (PST)
Received: from mailwall2.ssl.berkeley.edu (mailwall2.ssl.berkeley.edu
	[128.32.147.8])
	by mail2.ssl.berkeley.edu (8.13.8/8.13.8) with ESMTP id s0VF1fej009433
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Fri, 31 Jan 2014 07:01:41 -0800
X-ASG-Debug-ID: 1391180500-04b3971632d95d40001-LQ66t1
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22]) by
	mailwall2.ssl.berkeley.edu with ESMTP id ky2KWm7PpxEQGQwa for
	<boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Fri, 31 Jan 2014 07:01:40 -0800 (PST)
X-Barracuda-Envelope-From: toralf.foerster-Mmb7MZpHnFY@public.gmane.org
X-Barracuda-Apparent-Source-IP: 212.227.17.22
Received: from [192.168.178.21] ([78.54.160.177]) by mail.gmx.com (mrgmx003)
	with ESMTPSA (Nemesis) id 0MQQzk-1VhmZD3CxA-00TlhT for
	<boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Fri, 31 Jan 2014 16:01:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Enigmail-Version: 1.6
X-ASG-Orig-Subj: git pull does no longer work due to a Cr-Lf issue
X-Provags-ID: V03:K0:4MIy45AgBeJGx4cjolFpi2/VWLlUw3iuS4keScLyRLa8Ktss5as
	Ujhwj2q3b5iahUye9fTV7fVJFWJ5/XcxjOHoQYt9c2v5NW/jSKcM8DwIjRG6aN58d8uZlu7
	UUvyjySWupgPELO8AvRA0lgRVoX8Dim6f42OjNfBIz8KyUMJhotQvXa92IH17B+aqxsWJnh
	+SYpLClva+hxTys8HkndQ==
X-Barracuda-Connect: mout.gmx.net[212.227.17.22]
X-Barracuda-Start-Time: 1391180500
X-Barracuda-URL: http://mailwall2.ssl.berkeley.edu:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ssl.berkeley.edu
X-Barracuda-BRTS-Status: 1
X-BeenThere: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: BOINC development <boinc_dev.ssl.berkeley.edu>
List-Unsubscribe: <http://lists.ssl.berkeley.edu/mailman/options/boinc_dev>,
	<mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ssl.berkeley.edu/pipermail/boinc_dev/>
List-Post: <mailto:boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
List-Help: <mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ssl.berkeley.edu/mailman/listinfo/boinc_dev>,
	<mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=subscribe>
Errors-To: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
Sender: "boinc_dev" <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241298>

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQpIYXNoOiBTSEEyNTYKCkljaywKCnRv
ZGF5IEkgcnVuIGFnYWluIGludG8gYSBwcm9ibGVtIHdpdGggdGhlIGdpdCB0cmVlIG9mIHRoZSBC
T0lOQyBwcm9qZWN0OgpodHRwOi8vYm9pbmMuYmVya2VsZXkuZWR1L2dpdC9ib2luYy12Mi5naXQK
CkEgZ2l0IHB1bGwgd29uJ3Qgd29yayBhbnkgbG9uZ2VyIGR1ZSB0bzoKCiQgZ2l0IHB1bGwKVXBk
YXRpbmcgMDg5NDU5ZC4uMDFmMGVhZAplcnJvcjogWW91ciBsb2NhbCBjaGFuZ2VzIHRvIHRoZSBm
b2xsb3dpbmcgZmlsZXMgd291bGQgYmUgb3ZlcndyaXR0ZW4KYnkgbWVyZ2U6CiAgICAgICAgbGli
L2JvaW5jX3dpbi5oClBsZWFzZSwgY29tbWl0IHlvdXIgY2hhbmdlcyBvciBzdGFzaCB0aGVtIGJl
Zm9yZSB5b3UgY2FuIG1lcmdlLgpBYm9ydGluZwoKCkEgImdpdCBkaWZmIiBnYXZlIDoKCgpkaWZm
IC0tZ2l0IGEvbGliL2JvaW5jX3dpbi5oIGIvbGliL2JvaW5jX3dpbi5oCmluZGV4IDA2NzYzNzIu
LjRjNjJlZDUgMTAwNjQ0Ci0gLS0tIGEvbGliL2JvaW5jX3dpbi5oCisrKyBiL2xpYi9ib2luY193
aW4uaApAQCAtMTM3LDcgKzEzNyw3IEBAIHR5cGVkZWYgc2l6ZV90IHNvY2tsZW5fdDsKICNpbmNs
dWRlIDxzdGRpbnQuaD4KICNpbmNsdWRlIDxpbWFnZWhscC5oPgogI2Vsc2UKLSAtI2luY2x1ZGUg
PHNlY3VyaXR5Lmg+CisjaW5jbHVkZSA8c2VjdXJpdHkuaD4KICNpbmNsdWRlIDxkYmdoZWxwLmg+
CiAjZW5kaWYKICNpbmNsdWRlIDx0bGhlbHAzMi5oPgoKCndoaWNoIHBvaW50ZWQgbWUgdG8gYSBe
TSBpbiBsaW5lIDEzNyBvZiB0aGF0IGZpbGUuIEkgcmVtb3ZlZCB0aGF0IF5NLApidXQgYSBwdWxs
IHN0aWxsIHdvbsOkdCB3b3JrLiBUaGVuIEkgcmVtb3ZlZCB0aGUgZmlsZSBhbmQgY2hlY2tlZCBp
dApvdXQgYWdhaW4gLSBubyBjaGFuY2UsIGdpdCBwdWxsIGFsd2F5cyBmYWlscyB3aXRoIHRoZSBz
YW1lIG1hc3NhZ2UuCkZpbmFsbHkgSSB0cmllZCA6CgoKJCBnaXQgc3Rhc2gKd2FybmluZzogQ1JM
RiB3aWxsIGJlIHJlcGxhY2VkIGJ5IExGIGluIGxpYi9ib2luY193aW4uaC4KVGhlIGZpbGUgd2ls
bCBoYXZlIGl0cyBvcmlnaW5hbCBsaW5lIGVuZGluZ3MgaW4geW91ciB3b3JraW5nIGRpcmVjdG9y
eS4Kd2FybmluZzogQ1JMRiB3aWxsIGJlIHJlcGxhY2VkIGJ5IExGIGluIGxpYi9ib2luY193aW4u
aC4KVGhlIGZpbGUgd2lsbCBoYXZlIGl0cyBvcmlnaW5hbCBsaW5lIGVuZGluZ3MgaW4geW91ciB3
b3JraW5nIGRpcmVjdG9yeS4KU2F2ZWQgd29ya2luZyBkaXJlY3RvcnkgYW5kIGluZGV4IHN0YXRl
IFdJUCBvbiBtYXN0ZXI6IDA4OTQ1OWQgbG9jYWxlOgpVcGRhdGUgY29tcGlsZWQgbG9jYWxpemF0
aW9uIGZpbGVzCkhFQUQgaXMgbm93IGF0IDA4OTQ1OWQgbG9jYWxlOiBVcGRhdGUgY29tcGlsZWQg
bG9jYWxpemF0aW9uIGZpbGVzCgoKYnV0IGFnYWluIEkgcnVuIGludG8gOgoKCiQgZ2l0IHB1bGwK
VXBkYXRpbmcgMDg5NDU5ZC4uMDFmMGVhZAplcnJvcjogWW91ciBsb2NhbCBjaGFuZ2VzIHRvIHRo
ZSBmb2xsb3dpbmcgZmlsZXMgd291bGQgYmUgb3ZlcndyaXR0ZW4KYnkgbWVyZ2U6CiAgICAgICAg
bGliL2JvaW5jX3dpbi5oClBsZWFzZSwgY29tbWl0IHlvdXIgY2hhbmdlcyBvciBzdGFzaCB0aGVt
IGJlZm9yZSB5b3UgY2FuIG1lcmdlLgpBYm9ydGluZwoKCgovbWUgd29uZGVycyBob3cgdG8gc29s
dmUgdGhpcyB3L28gY2xvbmluZyB0aGUgY29tcGxldGUgcmVwbyBhZ2Fpbi4KCi0gLS0gCk1mRy9T
aW5jZXJlbHkKVG9yYWxmIEbDtnJzdGVyCnBncCBmaW5nZXIgcHJpbnQ6MUEzNyA2Rjk5IDRBOUQg
MDI2RiAxM0UyIDREQ0YgQzRFQSBDRERFIDAwNzYgRTk0RQotLS0tLUJFR0lOIFBHUCBTSUdOQVRV
UkUtLS0tLQpWZXJzaW9uOiBHbnVQRyB2Mi4wLjIyIChHTlUvTGludXgpCkNvbW1lbnQ6IFVzaW5n
IEdudVBHIHdpdGggVGh1bmRlcmJpcmQgLSBodHRwOi8vd3d3LmVuaWdtYWlsLm5ldC8KCmlGNEVB
UkVJQUFZRkFsTHJ1dElBQ2drUXhPck4zZ0IyNlU1Wkh3RC9lR0VyNGhSK0Y1VFZQN20wL0pPNktt
K2oKVk42YWszMFdNUEs4RmU5cFdIWUJBSVdENEVESXNwSFVrTmZxNzZWYWtjNnVOYUxWbmU4TUZp
aWtuaUg3V2poTAo9eHdHUwotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYm9pbmNfZGV2IG1haWxpbmcgbGlz
dApib2luY19kZXZAc3NsLmJlcmtlbGV5LmVkdQpodHRwOi8vbGlzdHMuc3NsLmJlcmtlbGV5LmVk
dS9tYWlsbWFuL2xpc3RpbmZvL2JvaW5jX2RldgpUbyB1bnN1YnNjcmliZSwgdmlzaXQgdGhlIGFi
b3ZlIFVSTCBhbmQKKG5lYXIgYm90dG9tIG9mIHBhZ2UpIGVudGVyIHlvdXIgZW1haWwgYWRkcmVz
cy4=
