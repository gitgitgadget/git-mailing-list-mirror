From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gitk: Use git wrapper to run git-ls-remote.
Date: Fri, 31 Mar 2006 01:20:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0603310115480.2585@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060330123151.25779.73775.stgit@metalzone.distorted.org.uk>
 <7v8xqr3iwt.fsf@assigned-by-dhcp.cox.net> <slrne2o8lr.l0.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-297248582-1143760805=:2585"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 01:20:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP6R4-000618-61
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 01:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWC3XUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 18:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWC3XUK
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 18:20:10 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:27072 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751135AbWC3XUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 18:20:09 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id A75651031;
	Fri, 31 Mar 2006 01:20:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9ADC4A61;
	Fri, 31 Mar 2006 01:20:05 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 7B0261031;
	Fri, 31 Mar 2006 01:20:05 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne2o8lr.l0.mdw@metalzone.distorted.org.uk>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18209>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-297248582-1143760805=:2585
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

On Thu, 30 Mar 2006, Mark Wooding wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> 
> > Does anybody know what is going on?
> 
> I'll try staring at the Tcl source code some time.  I'm rather too busy
> tonight, though.
> 
> There's also some very strange geometry management oddness going on in
> gitk.  I'll try to sort that out too.

That has been discussed. My feeling is that this is a bug of Tk with 
regard to rootless X servers. I never came around to do a proper patch, 
but I have explicit -height and -width arguments to all frames and 
panedwindows.

If you want to start working on it, I attached my current patch, which is 
good enough for me, but note that it changes the geometry subtly everytime 
gitk is called...

Hth,
Dscho


---1148973799-297248582-1143760805=:2585
Content-Type: TEXT/plain; charset=US-ASCII; name=git.txt
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.63.0603310120050.2585@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Description: 
Content-Disposition: attachment; filename=git.txt

W1BBVENIXSBnaXRrOiBtYWtlIGdlb21ldHJ5IGxlc3Mgd2VpcmQgb24gY3ln
d2luIGFuZCBtYWNvc3gNCg0KU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgU2No
aW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+DQoNCi0tLQ0K
DQogZ2l0ayB8ICAgIDkgKysrKystLS0tDQogMSBmaWxlcyBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9naXRrIGIvZ2l0aw0KaW5kZXggMDNjZDQ3NS4uNzMzOTA2OSAxMDA3NTUN
Ci0tLSBhL2dpdGsNCisrKyBiL2dpdGsNCkBAIC0zNzMsMTMgKzM3MywxMyBA
QCBwcm9jIG1ha2V3aW5kb3cge3JhcmdzfSB7DQogCXNldCBnZW9tZXRyeShj
dGV4dGgpIFtleHByIHsoJHRleHRoIC0gOCkgLw0KIAkJCQkgICAgW2ZvbnQg
bWV0cmljcyAkdGV4dGZvbnQgLWxpbmVzcGFjZV19XQ0KICAgICB9DQotICAg
IGZyYW1lIC5jdG9wLnRvcA0KKyAgICBmcmFtZSAuY3RvcC50b3AgLWhlaWdo
dCAkZ2VvbWV0cnkoY2FudmgpDQogICAgIGZyYW1lIC5jdG9wLnRvcC5iYXIN
CiAgICAgcGFjayAuY3RvcC50b3AuYmFyIC1zaWRlIGJvdHRvbSAtZmlsbCB4
DQogICAgIHNldCBjc2Nyb2xsIC5jdG9wLnRvcC5jc2INCiAgICAgc2Nyb2xs
YmFyICRjc2Nyb2xsIC1jb21tYW5kIHthbGxjYW52cyB5dmlld30gLWhpZ2hs
aWdodHRoaWNrbmVzcyAwDQogICAgIHBhY2sgJGNzY3JvbGwgLXNpZGUgcmln
aHQgLWZpbGwgeQ0KLSAgICBwYW5lZHdpbmRvdyAuY3RvcC50b3AuY2xpc3Qg
LW9yaWVudCBob3Jpem9udGFsIC1zYXNocGFkIDAgLWhhbmRsZXNpemUgNA0K
KyAgICBwYW5lZHdpbmRvdyAuY3RvcC50b3AuY2xpc3QgLW9yaWVudCBob3Jp
em9udGFsIC1zYXNocGFkIDAgLWhhbmRsZXNpemUgNCAtaGVpZ2h0ICRnZW9t
ZXRyeShjYW52aCkNCiAgICAgcGFjayAuY3RvcC50b3AuY2xpc3QgLXNpZGUg
dG9wIC1maWxsIGJvdGggLWV4cGFuZCAxDQogICAgIC5jdG9wIGFkZCAuY3Rv
cC50b3ANCiAgICAgc2V0IGNhbnYgLmN0b3AudG9wLmNsaXN0LmNhbnYNCkBA
IC00NDksOSArNDQ5LDEwIEBAIHByb2MgbWFrZXdpbmRvdyB7cmFyZ3N9IHsN
CiAgICAgIyBmb3IgbWFraW5nIHN1cmUgdHlwZT09RXhhY3Qgd2hlbmV2ZXIg
bG9jPT1QaWNrYXhlDQogICAgIHRyYWNlIGFkZCB2YXJpYWJsZSBmaW5kbG9j
IHdyaXRlIGZpbmRsb2NjaGFuZ2UNCiANCi0gICAgcGFuZWR3aW5kb3cgLmN0
b3AuY2RldCAtb3JpZW50IGhvcml6b250YWwNCisgICAgcGFuZWR3aW5kb3cg
LmN0b3AuY2RldCAtb3JpZW50IGhvcml6b250YWwgXA0KKwktaGVpZ2h0IFtl
eHByICRnZW9tZXRyeShjdGV4dGgpKiRsaW5lc3BjKzRdDQogICAgIC5jdG9w
IGFkZCAuY3RvcC5jZGV0DQotICAgIGZyYW1lIC5jdG9wLmNkZXQubGVmdA0K
KyAgICBmcmFtZSAuY3RvcC5jZGV0LmxlZnQgLXdpZHRoIFtleHByICRnZW9t
ZXRyeShjdGV4dHcpKltmb250IG1lYXN1cmUgJHRleHRmb250ICIwIl0rOF0N
CiAgICAgc2V0IGN0ZXh0IC5jdG9wLmNkZXQubGVmdC5jdGV4dA0KICAgICB0
ZXh0ICRjdGV4dCAtYmcgd2hpdGUgLXN0YXRlIGRpc2FibGVkIC1mb250ICR0
ZXh0Zm9udCBcDQogCS13aWR0aCAkZ2VvbWV0cnkoY3RleHR3KSAtaGVpZ2h0
ICRnZW9tZXRyeShjdGV4dGgpIFwNCg==

---1148973799-297248582-1143760805=:2585--
