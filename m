From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Allow 'git cmd -h' outside of repository
Date: Fri, 29 Aug 2008 18:44:55 +0700
Message-ID: <fcaeb9bf0808290444n579590a3ob01f7b4178e7a210@mail.gmail.com>
References: <1219958917-22780-1-git-send-email-szeder@ira.uka.de>
	 <alpine.DEB.1.00.0808291333010.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 29 13:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ2Qc-0005c8-1w
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 13:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095AbYH2Lo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 07:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbYH2Lo5
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 07:44:57 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:35415 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbYH2Lo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 07:44:56 -0400
Received: by rv-out-0506.google.com with SMTP id k40so845644rvb.1
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 04:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=y2K9ojLc1p/0jBcH3btwKl9wIAM63BOHptmdg7Z0VCg=;
        b=XFj0g+ElFHj17Xzngt7JEgSqoLvh4pUfTPZRDj1lpn3yi4/SoJq+Kn6gm09/Ikojsd
         PKIjMcIhmYLTe7Y2JgBtbhx2p+VGAbQz3546QU0F01Z+ElAGEn+Eq1ErlhZepMfpY8ru
         k98TWxYayLwJb4jfd0vxjKqXOeyGyK8LOUlXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=B0otqjgvffyLsU1oS+QPsj1gpQoRDt+uiRWQIFxWq72sJ6ozmST0GiRHHDQPVZsDIs
         NKd/o5tlGcVqeLsDWCUq93ytfKQmUbADPMsFpMMPWxkdp+nK8NRrcKlRl3scovRcc1dA
         nxSFHF8jokLE3XHjpSBlQ64C4vGGnd8EJbuk8=
Received: by 10.141.171.1 with SMTP id y1mr1416673rvo.252.1220010295673;
        Fri, 29 Aug 2008 04:44:55 -0700 (PDT)
Received: by 10.141.98.6 with HTTP; Fri, 29 Aug 2008 04:44:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0808291333010.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T24gOC8yOS8wOCwgSm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXgu
ZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gVGh1LCAyOCBBdWcgMjAwOCwgU1pFREVSIEfDoWJv
ciB3cm90ZToKPgo+ICA+IFByaW50aW5nIHVzYWdlIHN0cmluZ3Mgb2YgZ2l0IGNvbW1hbmRzIHNo
b3VsZCBvYnZpb3VzbHkgbm90IGRlcGVuZCBvbgo+ICA+IHRoZSBjb21tYW5kIGJlaW5nIHJ1biBp
bnNpZGUgYSBnaXQgcmVwb3NpdG9yeS4gIEhvd2V2ZXIsIGluIGNhc2Ugb2YgYQo+ICA+IGNvbW1h
bmQgcmVxdWlyaW5nIGEgcmVwb3NpdG9yeSwgdGhlIGNvbW1hbmQgbGluZSBvcHRpb25zIGFyZSBw
YXJzZWQgb25seQo+ICA+IGFmdGVyIGl0IGlzIGVuc3VyZWQgdGhhdCB0aGUgY29tbWFuZCB3YXMg
c3RhcnRlZCBpbnNpZGUgYSByZXBvc2l0b3J5LAo+ICA+IHJlc3VsdGluZyBpbiBhICdmYXRhbDog
Tm90IGEgZ2l0IHJlcG9zaXRvcnknIGlmICdnaXQgY21kIC1oJyB3YXNuJ3QKPiAgPiBleGVjdXRl
ZCBpbnNpZGUgYSByZXBvc2l0b3J5Lgo+ICA+Cj4gID4gVG8gZ2V0IGFyb3VuZCB0aGlzIGlzc3Vl
LCB3ZSB3aWxsIGNoZWNrIGVhcmx5IGZvciB0aGUgcHJlc2VuY2Ugb2YgJy1oJwo+ICA+IG9wdGlv
biwgYW5kIHNraXAgZW5zdXJpbmcgdGhhdCB0aGUgY29tbWFuZCBpcyBydW4gaW5zaWRlIGEgcmVw
b3NpdG9yeS4KPgo+Cj4gWW91IG1pc3MgdGhlIGZhY3QgdGhhdCAiZ2l0IGdyZXAgLWgiIGRvZXMg
bm90IG1lYW4gInNob3cgdXNhZ2UiLiAgT2gsIGFuZAo+ICAiZ2l0IGxzLXJlbW90ZSAtaCIgbmVp
dGhlci4gIFRocmVlIHRpbWVzJ3MgYSBjaGFybTogImdpdCBzaG93LXJlZiAtaCIgZG9lcwo+ICBu
b3Qgc2hvdyB0aGUgaGVscCBlaXRoZXIuCj4KPiAgSSBhbSBhbHNvIG5vdCBxdWl0ZSBjZXJ0YWlu
IGlmIHdlIHNob3VsZCBub3QganVzdCB0b3V0ICJnaXQgaGVscCA8Y21kPiIgYXMKPiAgdGhlIG9m
ZmljaWFsIHdheSB0byByZXF1ZXN0IGhlbHAuCgpObyB3ZSBzaG91bGQgbm90IChhdCBsZWFzdCB0
byBtZSksIHVzYWdlIHN0cmluZ3MgYXJlIHNob3J0ZXIgYW5kIGRvbid0CnJlcXVpcmUgbWFuLiAg
QXMgZm9yIGFsbG93aW5nICJnaXQgY21kIC1oIiBvdXRzaWRlIHJlcG9zaXRvcnksIEkgdGhpbmsK
SmVmZidzIGlkZWEgb2YgcmVmYWN0b3Jpbmcgc2V0dXAgcHJvY2VkdXJlLCBzZXR0aW5nIHVwIGlm
IHBvc3NpYmxlIGJ1dApub3QgYmFyZmluZywgd291bGQgc29sdmUgaXQuCi0tIApEdXkK
