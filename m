From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH v2 03/11] gitweb: separate heads and remotes list in summary view
Date: Fri, 14 Nov 2008 23:01:28 +0100
Message-ID: <cb7bb73a0811141401r748b5a4em4e5711935dd16a1@mail.gmail.com>
References: <1226616555-24503-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1226616555-24503-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <200811142104.35019.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 23:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L16ke-0003RS-DL
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 23:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbYKNWBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 17:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbYKNWBb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 17:01:31 -0500
Received: from qb-out-0506.google.com ([72.14.204.227]:16052 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYKNWBa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 17:01:30 -0500
Received: by qb-out-0506.google.com with SMTP id f11so1606810qba.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2008 14:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DHN5Qe9iUE6nQR19h97zvmAVytigtwL4046vt4DVS18=;
        b=DeP/mHTV7ExSOks7O2J5RmQn4jEqaxC8H6zbtsAczvc/vLNmnA/Gv0AJQva0cwwNvy
         YkNcMOEBcoisDqboGR2X8eVlRcaCFDAkErQ2yo/ojZ8r/65s+ukyCardaa9XddLX07a6
         1pcCyKSIfKIkorh1Qeiq2eUJjscC/X5QmGDk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wv5YCFalUZYYDlQ7Pbuun/wwGrhiEz9vGXwF1vR+YNcSDeAi25lXEs9W9nAP/GHYK3
         gBurgDLswKbz2qBZqFlZO/j7PKbunVhkENsiiG4v7GRLdw7wOejdHW6sWlf5rWOxkflb
         zST26f6+TWJ+7a3CvfmbC9HbxrXZbQc4FN9E8=
Received: by 10.210.63.6 with SMTP id l6mr1550575eba.185.1226700088557;
        Fri, 14 Nov 2008 14:01:28 -0800 (PST)
Received: by 10.210.132.16 with HTTP; Fri, 14 Nov 2008 14:01:28 -0800 (PST)
In-Reply-To: <200811142104.35019.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101021>

MjAwOC8xMS8xNCBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT46Cj4gRG5pYSBjendh
cnRlayAxMy4gbGlzdG9wYWRhIDIwMDggMjM6NDksIEdpdXNlcHBlIEJpbG90dGEgbmFwaXNhszoK
Pgo+IFZlcnkgbmljZSBwYXRjaC4gTm93IHRoYXQgSSBoYXZlIHJlYWQgaXQsIEkgZG9uJ3QgdGhp
bmsgaXQgc2hvdWxkIGJlCj4gc3F1YXNoZWQgd2l0aCBwcmV2aW91cyBwYXRjaCAod2VsbCwgYWdh
aW4gdGhhdCBpcyBvbmx5IGEgc3VnZ2VzdGlvbikuCgpTZWUgcmVwbHkgaW4gcHJldmlvdXMgcGF0
Y2guIFNvbWV0aW1lcyBpdCdzIGhhcmQgdG8gdGVsbCB3aGF0J3MgdGhlCmJlc3QgcGF0Y2gtc3Bs
aXR0aW5nIHN0cmF0ZWd5IC4uLgoKPiBCYXJyaW5nIG9uZSBpc3N1ZSAoc2VlIGJlbG93KSBpdHMg
Y29uY2lzZW5lc3Mgc2hvd3MgdGhhdCBnaXR3ZWIgaGFzCj4gcXVpdGUgZ29vZCBpbnRlcm5hbCBB
UEkuCgpNb3N0IGRlZmluaXRlbHkuIEkgZmluZCB0aGF0IHdvcmtpbmcgb24gZ2l0d2ViIGlzIGFs
bW9zdCBwbGVhc3VyYWJsZSA7LSkKW0kgbWVhbiwgaXQncyBzdGlsbCBQZXJsLCB3aGljaCBpcyBu
b3QgVGNsIGJ1dCBub3QgUnVieSBlaXRoZXIgOC1QXQoKPj4gICAgICAgbXkgQGZvcmtsaXN0Owo+
PiAgICAgICBteSAoJGNoZWNrX2ZvcmtzKSA9IGdpdHdlYl9jaGVja19mZWF0dXJlKCdmb3Jrcycp
Owo+Pgo+PiBAQCAtNDUzNSw2ICs0NTM3LDEzIEBAIHN1YiBnaXRfc3VtbWFyeSB7Cj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJGNnaS0+YSh7LWhyZWYgPT4gaHJlZihhY3Rpb249PiJo
ZWFkcyIpfSwgIi4uLiIpKTsKPj4gICAgICAgfQo+Pgo+PiArICAgICBpZiAoQHJlbW90ZWxpc3Qp
IHsKPj4gKyAgICAgICAgICAgICBnaXRfcHJpbnRfaGVhZGVyX2RpdigncmVtb3RlcycpOwo+PiAr
ICAgICAgICAgICAgIGdpdF9oZWFkc19ib2R5KFxAcmVtb3RlbGlzdCwgJGhlYWQsIDAsIDE1LAo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICQjcmVtb3RlbGlzdCA8PSAxNSA/IHVuZGVm
IDoKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAkY2dpLT5hKHstaHJlZiA9PiBocmVm
KGFjdGlvbj0+ImhlYWRzIil9LCAiLi4uIikpOwo+PiArICAgICB9Cj4+ICsKPgo+IFRoZSBvbmx5
IHByb2JsZW0gaXMgdGhhdCBsaW5rIGxlYWRzIHRvIGxpc3Qgb2YgX2FsbF8gaGVhZHMgKGJlc3Qg
Y2FzZSksCj4gb3IgbGlzdCB0byBsb2NhbCBicmFuY2hlcyAod29yc3QgY2FzZSwgYnV0IEkgZG9u
J3QgdGhpbmsgZ2l0d2ViIGRvZXMKPiBpdCksIGluc3RlYWQgb2Ygb25seSBsaXN0IG9mIHJlbW90
ZXMgcmVmcyAocmVtb3RlLXRyYWNraW5nIGJyYW5jaGVzKSwKPiBhcyBvbmUgd291bGQgdGhpbmsu
ICBQZXJoYXBzIHdlIGNvdWxkIHVzZSAnaCcgKGhhc2gpLCBvciAnb3B0IChleHRyYQo+IG9wdGlv
bnMpIHBhcmFtZXRlciBmb3IgdGhpcyBhY3Rpb24sIG9yIGp1c3QgYWRkICdyZW1vdGVzJyBhY3Rp
b24/CgpBZGRpbmcgYSAncmVtb3Rlcycgc2VjdGlvbiAoYW5kIGNvcnJlc3BvbmRpbmcgYWN0aW9u
LCB0b28pIGlzIHdoYXQgaXMKZG9uZSBieSBzdWJzZXF1ZW50IHBhdGNoZXMuIEl0J3MgcXVpdGUg
b2J2aW91cywgSSB0aGluaywgdGhhdCB0aGUKcGF0Y2ggc2VxdWVuY2UgZm9sbG93cyBfdmVyeV8g
Y2xvc2VseSB0aGUgb3JkZXIgaW4gd2hpY2ggSQppbXBsZW1lbnRlZC90ZXN0ZWQgZmVhdHVyZXMu
IEl0IG1pZ2h0IG1ha2UgbW9yZSBzZW5zZSB0byBtb3ZlIHNvbWUgb2YKdGhlbSBlYXJsaWVyLCBi
dXQgdGhlbiBzdWNoIGVhcmxpZXIgcGF0Y2hlcyB3b3VsZCBvbmx5IG1ha2Ugc2Vuc2UKYmVjYXVz
ZSBvZiB0aGUgb25lcyB0aGF0IGZvbGxvdyAuLi4gdGhpcyBpcyB3aHkgSSBkZWNpZGVkIHRvIGtl
ZXAgdGhlCnNlcXVlbmNlIGFzIGlzLgoKPj4gMS41LjYuNQo+Cj4gUC5TLiBOb3QgdXB0b2RhdGUg
KGdpdCB2ZXJzaW9uIDEuNi4wLjQpPyBKdXN0IGtpZGRpbmcuLi4KClllYWgsIEkga25vdywgZ2l2
ZW4gdGhhdCBJIHdvcmsgd2l0aCAnbmV4dCcgZ2l0d2ViLCBJIGNvdWxkIGFzIHdlbGwKanVzdCB1
cGdyYWRlIHRoZSBzeXN0ZW0gZ2l0IHRvIHRoZSBzYW1lIHZlcnNpb24gOC1QCgpJbnN0ZWFkLCBJ
J20ganVzdCByZWx5aW5nIG9uIHN0b2NrIERlYmlhbiBzdHVmZiwgd2hpY2ggb2J2aW91c2x5LApi
ZWluZyBpbiBmcmVlemUgbm93LCBpcyBub3QgdXBkYXRpbmcgdW5zdGFibGUgZWl0aGVyIDgtUAoK
Ci0tIApHaXVzZXBwZSAiT2Jsb21vdiIgQmlsb3R0YQo=
