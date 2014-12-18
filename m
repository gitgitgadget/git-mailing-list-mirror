From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: git-http-backend auth via Kerberos
Date: Thu, 18 Dec 2014 22:19:19 +0000
Message-ID: <540A8740-B240-40FF-BB50-0D90DEA04031@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 23:28:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1jZ2-000339-0G
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 23:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbaLRW2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 17:28:52 -0500
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:40203 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbaLRW2v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 17:28:51 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Dec 2014 17:28:51 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1992; q=dns/txt; s=iport;
  t=1418941731; x=1420151331;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=38wm1wz4N9arcyZjB0g+gg1TUEATBnNaeewv+yxBeLo=;
  b=fBIJD1CAGfd9FKGcHgVZZdIH8dapuJvLf/Z+upd5MYoIrHd4AHDqWNVN
   PeodC85sXO+itQcnKt8vtEBvh20dCwlqozXYlLxe4v6ZF+e1v7jlFaWsq
   nmtmXivxE9kAYgf3FHUMC764chdaarOKgyruSwCuqAAhH6Hmi5EfpNICl
   I=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ap4GAPRRk1StJV2Q/2dsb2JhbABbgwZSWASDAsMdhXIegQoWAQEBAQF9hBMjEVcBIgIUEgIEMBUSBBOILA2pJo9EljQBAQEBAQEEAQEBAQEBAQEBAQEXgSGODComFIJQLoETBY4Kgz6BfYM1kUIig2xvgUV+AQEB
X-IronPort-AV: E=Sophos;i="5.07,603,1413244800"; 
   d="scan'208";a="381174544"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-5.cisco.com with ESMTP; 18 Dec 2014 22:19:20 +0000
Received: from xhc-aln-x06.cisco.com (xhc-aln-x06.cisco.com [173.36.12.80])
	by rcdn-core-8.cisco.com (8.14.5/8.14.5) with ESMTP id sBIMJKrl030099
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 18 Dec 2014 22:19:20 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.194]) by
 xhc-aln-x06.cisco.com ([173.36.12.80]) with mapi id 14.03.0195.001; Thu, 18
 Dec 2014 16:19:20 -0600
Thread-Topic: git-http-backend auth via Kerberos
Thread-Index: AQHQGxCrd+//UJfMPkWu780RpZEfpA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.243.139]
Content-ID: <5ECB402401F52D41A84C561B34F08498@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261541>

SSBhbSB0cnlpbmcgdG8gZ2V0IGh0dHA6Ly9naXQtc2NtLmNvbS9kb2NzL2dpdC1odHRwLWJhY2tl
bmQgdG8gYXV0aCB2aWEgS2VyYmVyb3MuDQoNCkkgaGF2ZSBzdWNjZXNzIHdoZW4gYSBLZXJiZXJv
cyB0aWNrZXQgaXMgcHJlc2VudC4NCg0KSSBhbSB0cnlpbmcgdG8gZ2V0IGdpdCB0byBhdXRoZW50
aWNhdGUgd2l0aCBLZXJiZXJvcyB3aGVuIGEgdGlja2V0IGlzIG5vdCBwcmVzZW50Lg0KDQpIZXJl
IGlzIHdoYXQgc3VjY2VlZHMgd2l0aCBhIHRpY2tldDoNCg0KPExvY2F0aW9uIC9naXQ+DQogIFNT
TE9wdGlvbnMgK1N0ZGVudlZhcnMNCiAgT3B0aW9ucyArRXhlY0NHSSArRm9sbG93U3ltTGlua3Mg
K1N5bUxpbmtzSWZPd25lck1hdGNoDQoNCiAgICAjIEJ5IGRlZmF1bHQsIGFsbG93IGFjY2VzcyB0
byBhbnlvbmUuDQogICAgT3JkZXIgYWxsb3csZGVueQ0KICAgIEFsbG93IGZyb20gQWxsDQoNCiAg
ICAjIEVuYWJsZSBLZXJiZXJvcyBhdXRoZW50aWNhdGlvbiB1c2luZyBtb2RfYXV0aF9rZXJiLg0K
ICAgIEF1dGhUeXBlIEtlcmJlcm9zDQogICAgQXV0aE5hbWUg4oCcdXMuZXhhbXBsZS5jb20iDQog
ICAgS3JiQXV0aFJlYWxtIHVzLmV4YW1wbGUuY29tDQogICAgS3JiNUtleVRhYiAvdXNyL2xvY2Fs
L2V0Yy9hcGFjaGUyMi9yZXBvLXRlc3Qua2V5dGFiDQogICAgS3JiTWV0aG9kTmVnb3RpYXRlIG9u
DQogICAgS3JiU2F2ZUNyZWRlbnRpYWxzIG9uDQogICAgS3JiVmVyaWZ5S0RDIG9uDQogICAgS3Ji
U2VydmljZU5hbWUgQW55DQogICAgUmVxdWlyZSB2YWxpZC11c2VyDQo8L0xvY2F0aW9uPg0KDQpU
aGlzIGlzIHdoYXQgaGFwcGVucyB3aXRob3V0IGEgdmFsaWQgdGlja2V0Og0KDQokIGdpdCBjbG9u
ZSBodHRwczovL3VzLmV4YW1wbGUuY29tL2dpdC9jbGFtYXYtYnl0ZWNvZGUtY29tcGlsZXINCkNs
b25pbmcgaW50byAnY2xhbWF2LWJ5dGVjb2RlLWNvbXBpbGVyJy4uLg0KVXNlcm5hbWUgZm9yICdo
dHRwczovL3VzLmV4YW1wbGUuY29tJzogZGFuDQpQYXNzd29yZCBmb3IgJ2h0dHBzOi8vZGFuQHVz
LmV4YW1wbGUuY29tJzogDQpmYXRhbDogQXV0aGVudGljYXRpb24gZmFpbGVkIGZvciAnaHR0cHM6
Ly91cy5leGFtcGxlLmNvbS9naXQvY2xhbWF2LWJ5dGVjb2RlLWNvbXBpbGVyLycNCg0KT2Ygbm90
ZSwgSSBzZWUgdGhpcyBpbiB0aGUgQXBhY2hlIGxvZ3M6DQoNClRodSBEZWMgMTggMTY6NDM6MzUg
MjAxNF0gW2RlYnVnXSBzcmMvbW9kX2F1dGhfa2VyYi5jKDE3NDkpOiBbY2xpZW50IDEwLjcuNjku
MTBdIGtlcmJfYXV0aGVudGljYXRlX3VzZXIgZW50ZXJlZCB3aXRoIHVzZXIgKE5VTEwpIGFuZCBh
dXRoX3R5cGUgS2VyYmVyb3MNCg0KSWRlYXM/ICBTdWdnZXN0aW9ucz8gIEhpbnRzPyAgVGhhbmtz
Lg0KDQrigJQgDQpEYW4gTGFuZ2lsbGUNCkluZnJhc3RydWN0dXJlICYgT3BlcmF0aW9ucw0KVGFs
b3MgR3JvdXANClNvdXJjZWZpcmUsIEluYy4NCg0K
