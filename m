From: <lynn.lin@emc.com>
Subject: RE: [PATCH] Makefile: don't include git version file on 'make clean'
Date: Sun, 25 Jul 2010 08:37:35 -0400
Message-ID: <7F48A44C0E1FBF48B00D4DA49C85432E54F9A1@CORPUSMX100A.corp.emc.com>
References: <1279943627-11053-1-git-send-email-Lynn.Lin@emc.com><AANLkTilYXdVI_fqG5ZvPEABTXt7fTps3ZbPiiWgVnDxS@mail.gmail.com><4C4BFAA3.3050700@digium.com><7F48A44C0E1FBF48B00D4DA49C85432E54F998@CORPUSMX100A.corp.emc.com><AANLkTilHrEImfhl0YTqj0MgXFTzYmJMJrUTKkflGFwpp@mail.gmail.com><7F48A44C0E1FBF48B00D4DA49C85432E54F99A@CORPUSMX100A.corp.emc.com><AANLkTilhoF670uZ1WbosZP9TNbXect2A3gELRJL0ZZIn@mail.gmail.com><m2d3ubojfr.fsf@igel.home><AANLkTilK_8wVQG6s8pUrscwd7ZnvgGyjOjJP41uXYfEl@mail.gmail.com><7F48A44C0E1FBF48B00D4DA49C85432E54F99D@CORPUSMX100A.corp.emc.com><7F48A44C0E1FBF48B00D4DA49C85432E54F99F@CORPUSMX100A.corp.emc.com><7F48A44C0E1FBF48B00D4DA49C85432E54F9A0@CORPUSMX100A.corp.emc.com> <AANLkTinjmUEHxnGI2kRBwN17689MEwRRX_1uOQx-ZaHY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Cc: <schwab@linux-m68k.org>, <kpfleming@digium.com>,
	<git@vger.kernel.org>
To: <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 14:38:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od0Sv-0002Lb-6P
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 14:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962Ab0GYMh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 08:37:56 -0400
Received: from mexforward.lss.emc.com ([128.222.32.20]:26732 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab0GYMhz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 08:37:55 -0400
Received: from hop04-l1d11-si01.isus.emc.com (HOP04-L1D11-SI01.isus.emc.com [10.254.111.54])
	by mexforward.lss.emc.com (Switch-3.3.2/Switch-3.1.7) with ESMTP id o6PCbetb017457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Jul 2010 08:37:40 -0400
Received: from mailhub.lss.emc.com (sesha.lss.emc.com [10.254.144.16]) by hop04-l1d11-si01.isus.emc.com (RSA Interceptor); Sun, 25 Jul 2010 08:37:37 -0400
Received: from corpussmtp4.corp.emc.com (corpussmtp4.corp.emc.com [10.254.169.197])
	by mailhub.lss.emc.com (Switch-3.4.2/Switch-3.3.2mp) with ESMTP id o6PCbbV6032689;
	Sun, 25 Jul 2010 08:37:37 -0400
Received: from CORPUSMX100A.corp.emc.com ([128.222.76.57]) by corpussmtp4.corp.emc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Sun, 25 Jul 2010 08:37:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <AANLkTinjmUEHxnGI2kRBwN17689MEwRRX_1uOQx-ZaHY@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Makefile: don't include git version file on 'make clean'
Thread-Index: Acsr9bujtKTk87P2TgmOjD32SSrPRgAABk5A
X-OriginalArrivalTime: 25 Jul 2010 12:37:36.0891 (UTC) FILETIME=[2987DCB0:01CB2BF6]
X-EMM-EM: Active
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151738>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiDDhnZhciBBcm5masO2csOwIEJq
YXJtYXNvbiBbbWFpbHRvOmF2YXJhYkBnbWFpbC5jb21dIA0KU2VudDogMjAxMOW5tDfmnIgyNeaX
pSAyMDozNA0KVG86IExpbiwgTHlubg0KQ2M6IHNjaHdhYkBsaW51eC1tNjhrLm9yZzsga3BmbGVt
aW5nQGRpZ2l1bS5jb207IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hd
IE1ha2VmaWxlOiBkb24ndCBpbmNsdWRlIGdpdCB2ZXJzaW9uIGZpbGUgb24gJ21ha2UgY2xlYW4n
DQoNCk9uIFN1biwgSnVsIDI1LCAyMDEwIGF0IDEyOjI5LCAgPGx5bm4ubGluQGVtYy5jb20+IHdy
b3RlOg0KDQo+IE15IHBhdGNoIGlzIHRvIGRvbid0IGNhbGwgR0lULVZFUlNJT04tRklMRSB0YXJn
ZXQgd2hlbiB5b3UgcnVuICdtYWtlIGNsZWFuJw0KDQpZZXMsIGJ1dCBhcyBJIGRlbW9uc3RyYXRl
ZCBpdCBnZXRzIGNhbGxlZCBhbnl3YXkuIFByZXN1bWFibHkgYmVjYXVzZQ0Kb2YgdGhlICQoTUFL
RSkgLUMgLi4uIGNsZWFuIHJ1bGVzLiBCdXQgSSBoYXZlbid0IGxvb2tlZCBpbnRvIGl0Lg0KDQoN
CklmIHdlIGRvbid0IHNwZWNpZnkgc3BlY2lhbCBnb2Fscywgd2hlbiB3ZSBydW4gYW55IHRhcmdl
dCAsaXQgd2lsbCBjYWxsIEdJVC1WRVJTSU9ORi1GSUxFIHRhcmdldCBhcyBpdCBpbmNsdWRlIHRo
aXMgdGFyZ2V0IA0KDQpFeGFtcGxlIGZyb20gR05VIG1ha2UgbWFudWFsOg0KaHR0cDovL3d3dy5n
bnUub3JnL3NvZnR3YXJlL2F1dG9jb25mL21hbnVhbC9tYWtlL0dvYWxzLmh0bWwNCg0KDQpBbiBl
eGFtcGxlIG9mIGFwcHJvcHJpYXRlIHVzZSBpcyB0byBhdm9pZCBpbmNsdWRpbmcgLmQgZmlsZXMg
ZHVyaW5nIGNsZWFuIHJ1bGVzIChzZWUgQXV0b21hdGljIFByZXJlcXVpc2l0ZXMpLCBzbyBtYWtl
IHdvbid0IGNyZWF0ZSB0aGVtIG9ubHkgdG8gaW1tZWRpYXRlbHkgcmVtb3ZlIHRoZW0gYWdhaW46
DQoNCiAgICAgICAgICBzb3VyY2VzID0gZm9vLmMgYmFyLmMNCiAgICAgDQogICAgIGlmbmVxICgk
KE1BS0VDTURHT0FMUyksY2xlYW4pDQogICAgIGluY2x1ZGUgJChzb3VyY2VzOi5jPS5kKQ0KICAg
ICBlbmRpZg0KDQoNCg0KVGhhbmtzDQpMeW5uDQo=
