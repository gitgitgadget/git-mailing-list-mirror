From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: What's in git.git
Date: Fri, 10 Feb 2006 09:03:23 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05AD555E@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C62E63.E76642D0"
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 11 02:01:47 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7bgH-0007zn-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 18:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWBJRDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 12:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWBJRDb
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 12:03:31 -0500
Received: from fmr21.intel.com ([143.183.121.13]:16011 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751303AbWBJRDa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 12:03:30 -0500
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr001.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k1AH3PEH020694;
	Fri, 10 Feb 2006 17:03:25 GMT
Received: from scsmsxvs040.sc.intel.com (scsmsxvs040.sc.intel.com [10.3.90.8])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k1AAEjGs023454;
	Fri, 10 Feb 2006 10:14:51 GMT
Received: from scsmsx332.amr.corp.intel.com ([10.3.90.6])
 by scsmsxvs040.sc.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006021009032416257
 ; Fri, 10 Feb 2006 09:03:24 -0800
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by scsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 10 Feb 2006 09:03:25 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: What's in git.git
Thread-Index: AcYuUzHGIxVhR/duQ1687YPxya2IFwADpx+g
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 10 Feb 2006 17:03:25.0082 (UTC) FILETIME=[E7B72FA0:01C62E63]
X-Scanned-By: MIMEDefang 2.52 on 10.3.253.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15910>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C62E63.E76642D0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Yup.  Sorry I did not make that clear.  You deserve the credit.
Thanks (and that wasn't a grumble, just a point of information)

> I am beginning to feel this workflow might benefit from some
> tool support, but I haven't had enough experience to talk about
> exactly what they are yet.
I feel that I have settled into a rut.  My topic workflow works
fairly well, so I'm not really working on cleaning any remaining
rough edges.  It will be good to have some other eyes (especially
some eyes that have been keeping a close eye on all the new features
that have been added to the rest of git) looking at this.

> For example, listing topics that have ever been merged into a
> particular branch, listing topics that have not been fully
> merged into a particular branch, etc. are things I find myself
> doing frequently.  I vaguely recall seeing your post that has
> these things.

At the end of the using-topic-branches file there is an example
"status" script.  My real script has had some updates (see attached)
that reports on extra bits (like whether Linus as made new packfiles
that I should pull down). And ignoring some special (to me) branch
names when reporting.  But it has lots of hard-coded paths for my
workflow. Branches "linus", "release" and "test" are very special.
I have no "master" or "origin" branches at all.  But the net output
seems to be what you want ... for each topic branch it reports
whether that branch has already been merged to the test/release/linus
branches, and whether I have commits in my release branch that are
not in test.

-Tony

------_=_NextPart_001_01C62E63.E76642D0
Content-Type: application/octet-stream;
	name="tl-status"
Content-Transfer-Encoding: base64
Content-Description: tl-status
Content-Disposition: attachment;
	filename="tl-status"

IyEvYmluL2Jhc2gKCiMgcmVwb3J0IG9uIHN0YXR1cyBvZiBteSBpYTY0IEdJVCB0cmVlCgpnYj0k
KHRwdXQgc2V0YWIgMikKcmI9JCh0cHV0IHNldGFiIDEpCnJlc3RvcmU9JCh0cHV0IHNldGFiIDkp
CgojIEdldCBzdGF0dXMgb2YgdHJlZXMgQCBrZXJuZWwub3JnCmV2YWwgJChzb2Nrc2lmeSBzc2gg
bWFzdGVyLmtlcm5lbC5vcmcgJ1wKZWNobyByZWxlYXNlPSQoY2F0IHNjbS9saW51eC0yLjYuZ2l0
L3JlZnMvaGVhZHMvcmVsZWFzZSkgOyBcCmVjaG8gdGVzdD0kKGNhdCBzY20vbGludXgtMi42Lmdp
dC9yZWZzL2hlYWRzL3Rlc3QpIDsgXAplY2hvIGxpbnVzPSQoY2F0IHRvcnZhbGRzL2xpbnV4LTIu
Ni5naXQvcmVmcy9oZWFkcy9tYXN0ZXIpIDsgXAplY2hvIHBhY2tmaWxlcz1cIiQobHMgdG9ydmFs
ZHMvbGludXgtMi42LmdpdC9vYmplY3RzL3BhY2spXCIgJykKCmNkIC9ob21lL2FlZ2wvR0lUL3dv
cmsKCmVjaG8gJGdiID09PT09PT0gbGludXMgPT09PT09ICRyZXN0b3JlCmxvY2FsPWBjYXQgLmdp
dC9yZWZzL2hlYWRzL2xpbnVzYAppZiBbICIkbGludXMiID0gIiRsb2NhbCIgXQp0aGVuCgllY2hv
IC1lICJcdFVwIHRvIGRhdGUiCmVsc2UKCWVjaG8gLWUgIlx0TmVlZCB0byBwdWxsIGZyb20ga2Vy
bmVsLm9yZyIKZmkKCmV2YWwgJChlY2hvIG15cGFja2ZpbGVzPVwiJChscyAuZ2l0L29iamVjdHMv
cGFjaylcIikKaWYgWyAiJHBhY2tmaWxlcyIgIT0gIiRteXBhY2tmaWxlcyIgXQp0aGVuCgllY2hv
ICRyYiBOZXcgcGFja2ZpbGVzIGluIExpbnVzIHRyZWUgJHJlc3RvcmUKCWVjaG8gSGUgaGFzICI8
JHBhY2tmaWxlcz4iCgllY2hvIEkgaGF2ZSAiPCRteXBhY2tmaWxlcz4iCmZpCgpmb3IgYnJhbmNo
IGluIHJlbGVhc2UgdGVzdApkbwoJZWNobyAkZ2IgPT09PT09PSAkYnJhbmNoID09PT09PSAkcmVz
dG9yZQoJbG9jYWw9YGNhdCAuZ2l0L3JlZnMvaGVhZHMvJGJyYW5jaGAKCWlmIFsgIiR7IWJyYW5j
aH0iID0gIiRsb2NhbCIgXQoJdGhlbgoJCWVjaG8gLWUgIlx0VXAgdG8gZGF0ZSIKCWVsc2UKCQll
Y2hvIC1lICJcdE5lZWQgdG8gcHVzaCB0byBrZXJuZWwub3JnIgoJZmkKCWlmIFsgYGdpdC1yZXYt
bGlzdCBsaW51cyBeJGJyYW5jaCB8IHdjIC1sYCAtZ3QgMCBdCgl0aGVuCgkJZWNobyAtZSAiXHRO
ZWVkcyBtZXJnZSBmcm9tIGxpbnVzIgoJZmkKZG9uZQoKaWYgWyBgZ2l0LXJldi1saXN0IHJlbGVh
c2UgLS1uby1tZXJnZXMgXnRlc3QgfCB3YyAtY2AgLWd0IDAgXQp0aGVuCgllY2hvICRyYiBXYXJu
aW5nOiBjb21taXRzIGluIHJlbGVhc2UgdGhhdCBhcmUgbm90IGluIHRlc3QgJHJlc3RvcmUKCWdp
dC13aGF0Y2hhbmdlZCByZWxlYXNlIF50ZXN0IHwgZ2l0LXNob3J0bG9nCmZpCgpmb3IgYnJhbmNo
IGluIGBscyAtcnQgLmdpdC9yZWZzL2hlYWRzIHwgYXdrICd7cHJpbnQgJE5GfSdgCmRvCgljYXNl
ICIkYnJhbmNoIiBpbgoJbGludXMgfCByZWxlYXNlIHwgdGVzdCB8IGJhc2UtKiB8IGJhZC0qIHwg
RVhQLSogKQoJCWNvbnRpbnVlCgkJOzsKCWVzYWMKCglhZ2U9JChnaXQtY2F0LWZpbGUgY29tbWl0
ICRicmFuY2ggfCBncmVwICdeYXV0aG9yJyB8IGF3ayAne3ByaW50ICQoTkYtMSl9JykKCWVjaG8g
LW4gJGdiID09PT09PT0gJGJyYW5jaCAiKGBzaG93dGltZSAkYWdlYCkiID09PT09PSAkcmVzdG9y
ZSAiICIKCXN0YXR1cz0KCWZvciByZWYgaW4gdGVzdCByZWxlYXNlIGxpbnVzCglkbwoJCWlmIFsg
YGdpdC1yZXYtbGlzdCAkYnJhbmNoIF4kcmVmIHwgd2MgLWNgIC1ndCAwIF0KCQl0aGVuCgkJCXN0
YXR1cz0kc3RhdHVzJHtyZWY6MDoxfQoJCWZpCglkb25lCgljYXNlICRzdGF0dXMgaW4KCXRybCkK
CQllY2hvICRyYiBOZWVkIHRvIHB1bGwgaW50byB0ZXN0ICRyZXN0b3JlCgkJOzsKCXJsKQoJCWVj
aG8gIkluIHRlc3QiCgkJOzsKCWwpCgkJZWNobyAiV2FpdGluZyBmb3IgbGludXMiCgkJOzsKCSIi
KQoJCWVjaG8gJHJiIEFsbCBkb25lICRyZXN0b3JlCgkJOzsKCSopCgkJZWNobyAkcmIgIjwkc3Rh
dHVzPiIgJHJlc3RvcmUKCQk7OwoJZXNhYwoJZ2l0LXdoYXRjaGFuZ2VkICRicmFuY2ggXmxpbnVz
IHwgZ2l0LXNob3J0bG9nCmRvbmUK

------_=_NextPart_001_01C62E63.E76642D0--
