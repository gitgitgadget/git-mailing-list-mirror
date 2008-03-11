From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 07/10] builtin-archive: mark unused prefix "unused_prefix"
Date: Tue, 11 Mar 2008 21:50:24 +0700
Message-ID: <fcaeb9bf0803110750rd70a303r3fc522b326ea93b@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103446.GA8983@laptop>
	 <alpine.LSU.1.00.0803111432370.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:51:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ5on-0003cd-Oh
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 15:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbYCKOu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 10:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbYCKOu1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 10:50:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:11981 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYCKOu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 10:50:26 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2440035fga.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 07:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ulXqqWXvuos+Aovof4hfaxSEJJ0kZAL3KfVX71WR9pA=;
        b=uj8+Zo9t1ASkuQR7V7DmB4P+iQISngbDwYJUD30hCewnSGdgi5UZJkrCEE67j2kxGCsc5eC4KBLaPuvBJWNXG+JxfFP3Qp/7VDCp2r7lbO+7FX077BC8Qpt4vOzD7R3pK/J7U0/yTWzSI2uJxd+T71yCH2fX+5NFaiYqh62OqTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vy1hK9pHMcwVyuhn9zEUK7EznlzQGMSuIPa7ERiq9CMd11/DonkJx/Ozl9HTYsPH0vpwQ7OzUO3n8YXEPitgzM/2/MWxMNToatGDamrx/sWdNSjZiMh9oglIQTgGX2bN88SPDwVvf/nVra3m7UR71/xwsL1xKSfd8wI1/YkR8k0=
Received: by 10.86.70.8 with SMTP id s8mr8328865fga.29.1205247024998;
        Tue, 11 Mar 2008 07:50:24 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 07:50:24 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111432370.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76856>

T24gVHVlLCBNYXIgMTEsIDIwMDggYXQgODozMyBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo8Sm9o
YW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gU3VuLCAyIE1h
ciAyMDA4LCBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IHdyb3RlOgo+Cj4gID4gY21kX2FyY2hp
dmUoKSBpcyByZWdpc3RlcmVkIHdpdGhvdXQgUlVOX1NFVFVQIHNvIGl0cyBwcmVmaXgKPiAgPiB3
aWxsIGJlIE5VTEwgZm9yZXZlci4gTGV0J3MgbWFrZSB0aGF0IGNsZWFyLgo+ICA+Cj4gID4gU2ln
bmVkLW9mZi1ieTogTmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vkc0BnbWFpbC5jb20+
Cj4gID4gLS0tCj4KPiAgQUZBSUNUIHRoaXMgcGF0Y2ggaXMgLS0gbGlrZSB0d28gb3RoZXJzIC0t
IGFuIGluZGVwZW5kZW50IGZpeCwgYW5kIHNob3VsZAo+ICBiZSBzdWJtaXR0ZWQgYXMgc3VjaC4K
Ckl0J3Mgbm90IHJlYWxseSBpbmRlcGVuZGVudC4gQmVmb3JlIHRoZSBzZXJpZXMsIHNldHVwX2Rp
cl9nZW50bHkoKQpfY2FuXyBjaGFuZ2UgdGhlIHByZWZpeC4gQWZ0ZXIgdGhlIHNlcmllcyBpdCBk
b2VzIG5vdCAoc2VtYW50aWNzCmNoYW5nZSkuIFRoZSBmaXJzdCBwYXRjaCBvZiB0aGUgc2VyaWVz
ICgiZ2l0IHJlYWQtdHJlZSAtbSIpIGlzCmluZGVwZW5kZW50IGFuZCBjYW4gYmUgY2hlcnJ5IHBp
Y2tlZCBpZiBuZWNlc3NhcnkuCi0tIApEdXkK
