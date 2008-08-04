From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Mon, 4 Aug 2008 19:29:24 +0700
Message-ID: <fcaeb9bf0808040529q7583f65fj83780d2e818d39d2@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <alpine.DEB.1.00.0807231713280.8986@racer>
	 <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807231753240.8986@racer>
	 <20080803183749.GA3482@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Aug 04 14:30:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPzCp-0007Kz-Kc
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 14:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbYHDM32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 08:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbYHDM32
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 08:29:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:13120 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYHDM31 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 08:29:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so978317fgg.17
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 05:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nEjB1V2BaIqQX9uFpMc1BcjFP39AOXRlXu5RNrs7A7A=;
        b=uUiTmKPl4jkneKAyGPKcVNW87S/JfIzQE1k+L64DmkN4eFkNp+PQ1589eZKXvOMRY9
         ZU/pJYMiapDtM8PGjQ4uSQJu3svM7QS3loQxxHyrQ01Ngq3GU3fxkHHO8BJnX5847YfN
         R4kYzrHm6dd5Ij791UXI7vS5ssIujZmFYRFoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Yh0P+fjsdhoxoSrIRtv9qXgcoecqOKo9JnXBlfO8DwduhhLtIJ8qwS9NLdZ823FGNe
         KHLTVrKj+mzGarzxZYqpPkcPjsyiGtuKyX5ZW3dI0nVCg1kA+4stUZpZdPH9nyPrPBAf
         fnmOXQhJfCfAKIJuWSIu6GFXnnHuMiN7cJVWQ=
Received: by 10.86.87.5 with SMTP id k5mr10322935fgb.59.1217852964964;
        Mon, 04 Aug 2008 05:29:24 -0700 (PDT)
Received: by 10.86.93.13 with HTTP; Mon, 4 Aug 2008 05:29:24 -0700 (PDT)
In-Reply-To: <20080803183749.GA3482@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91346>

T24gOC80LzA4LCBKYW4gSHVkZWMgPGJ1bGJAdWN3LmN6PiB3cm90ZToKPiBIZWxsbywKPgo+ICBz
b3JyeSBmb3IgcmVwbHlpbmcgdG8gYW4gb2xkIHRocmVhZCwgYnV0IEkgYW0gYSBiaXQgcHV6emxl
ZCBoZXJlLAo+Cj4KPiAgT24gV2VkLCBKdWwgMjMsIDIwMDggYXQgMTc6NTU6MTQgKzAxMDAsIEpv
aGFubmVzIFNjaGluZGVsaW4gd3JvdGU6Cj4gID4gT24gV2VkLCAyMyBKdWwgMjAwOCwgTmd1eWVu
IFRoYWkgTmdvYyBEdXkgd3JvdGU6Cj4gID4gPiBPbiA3LzIzLzA4LCBKb2hhbm5lcyBTY2hpbmRl
bGluIDxKb2hhbm5lcy5TY2hpbmRlbGluQGdteC5kZT4gd3JvdGU6Cj4gID4gPiA+ICBPbiBXZWQs
IDIzIEp1bCAyMDA4LCBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IHdyb3RlOgo+ICA+ID4gPgo+
ICA+ID4gPiAgPiBTbyBpbiBzaG9ydCwgc3BhcnNlIHByZWZpeCB3aWxsIGJlIHN0b3JlZCBpbiBj
b25maWcsCj4gID4gPiA+ICA+IGNvcmUuc3BhcnNlY2hlY2tvdXQuCj4gID4gPiA+Cj4gID4gPiA+
IERvIHlvdSByZWFsbHkgdGhpbmsgdGhlIHByZWZpeCBzaG91bGQgYmUgc3RvcmVkIGFueXdoZXJl
IGVsc2UgdGhhbiB0aGUKPiAgPiA+ID4gaW5kZXg/Cj4gID4gPiA+Cj4gID4gPiA+IFdpdGggY29y
ZS5zcGFyc2VDaGVja291dCB5b3UgaGF2ZSB0byBpbnRyb2R1Y2UgYSBfc2gqdGxvYWRfIG9mIGNv
bmZpZwo+ICA+ID4gPiBsb2FkZXJzLgo+ICA+ID4gPgo+ICA+ID4gPiBBbmQgd2l0aCBjb3JlLnNw
YXJzZUNoZWNrb3V0IHlvdSBhcmUgYXQgdGhlIHdoaW0gb2YgdGhlIHVzZXIsIHNpbmNlCj4gID4g
PiA+IC5naXQvY29uZmlnIGlzIF9zdXBwb3NlZF8gdG8gYmUgdXNlci1lZGl0YWJsZS4KPiAgPiA+
ID4KPiAgPiA+ID4gRnJvbSBhIGxvZ2ljYWwgcG9pbnQgb2YgdmlldywgSSdkIHNheSB0aGF0IHRo
ZSBzcGFyc2UgcHJlZml4IGhhcwo+ICA+ID4gPiBub3RoaW5nIHRvIGRvIHdpdGggdGhlICJjb25m
aWd1cmF0aW9uIiBvZiB0aGUgbG9jYWwgcmVwb3NpdG9yeS4KPiAgPiA+Cj4gID4gPiBXZWxsLCB3
aGF0ZXZlciBwbGFjZS4gSSBjaG9zZSAuZ2l0L2NvbmZpZyBiZWNhdXNlIEkgZGlkIG5vdCB3YW50
IHRvCj4gID4gPiBpbnRyb2R1Y2UgYSBuZXcgY29uZmlnIHBsYWNlLiBCdXQgdGhlbiBob3cgYWJv
dXQgLmdpdC9zcGFyc2VjaGVja291dD8KPiAgPgo+ICA+IE5vLCBJIGRpZCBtZWFuIHRoZSBpbmRl
eC4gIFRoaXMgaXMgYW4gYXR0cmlidXRlIG9mIHRoZSBpbmRleDogZWl0aGVyIGl0IGlzCj4gID4g
c3BhcnNlbHkgY2hlY2tlZCBvdXQgb3Igbm90LiAgWW91IGNhbiBldmVuIGhhdmUgbXVsdGlwbGUg
aW5kaWNlcwo+ICA+IChzd2l0Y2hpbmcgYmV0d2VlbiB0aGVtIGJ5IHNldHRpbmcgR0lUX0lOREVY
X0ZJTEUpIHdoaWNoIGhhdmUgZGlmZmVyZW50Cj4gID4gcHJlZml4ZXMuCj4KPgo+IFVtLCBidXQg
ZG9lcyB0aGUgcHJlZml4IHdlIHdhbnQgdG8gdXNlIGRlcGVuZCBvbiB3aGF0IGZpbGVzIGFyZSBw
aHlzaWNhbGx5Cj4gIHByZXNlbnQgaW4gdGhlIHRyZWU/IFRoYXQgd291bGQgaG93ZXZlciBpbXBs
eSB0aGF0IGl0J3MgL25vdC8gYW4gYXR0cmlidXRlIG9mCj4gIHRoZSBpbmRleCwgYnV0IHRoZSB0
cmVlIGFuZCB0aGVyZWZvcmUgc2hvdWxkIGJlIHN0b3JlZCBpbiBhIHNlcGFyYXRlIG9iamVjdC4K
Pgo+ICBUaGUgcXVlc3Rpb24gd2hldGhlciBpdCBnb2VzIGluIHRoZSAuZ2l0L2NvbmZpZyBvciAu
Z2l0L3NwYXJzZWNoZWNrb3V0IGlzCj4gIHRoYW4gdGhhdCBvZiBzZW1hbnRpY3MgLS0gaWYgaXQn
cyBpbiAuZ2l0L2NvbmZpZywgdGhhbiB1c2VyIGNoYW5nZXMgdGhhdCBieQo+ICBlZGl0aW5nIHRo
ZSBmaWxlIG9yIGdpdCBjb25maWcgYW5kIG5vIG90aGVyIHdheSwgd2hpbGUgaWYgaXQncyBpbgo+
ICAuZ2l0L3NwYXJzZWNoZWNrb3V0LCB1c2VyIGNoYW5nZXMgaXQgYnkgcnVubmluZyBjaGVja291
dCB3aXRoIGFwcHJvcHJpYXRlCj4gIGFyZ3VtZW50cy4KClBsZWFzZSBzZWUgdGhlIHBvc3QgSnVu
aW8gdGFsa2VkIGFib3V0IG5hcnJvdy9zcGFyc2UgY2hlY2tvdXQgWzFdLgpXaXRoIHRoYXQgYXBw
cm9hY2ggKHRoYXQgaXMgZmluZXIgZ3JhaW4gY2hlY2tvdXQgdGhhbiBteSBhcHByb2FjaCksIGl0
CmJlY29tZXMgY2xlYXIgdGhhdCAicHJlZml4IiBpcyBhbiBhdHRyaWJ1dGUgb2YgaW5kZXguCgpb
MV0gaHR0cDovL2FydGljbGUuZ21hbmUub3JnL2dtYW5lLmNvbXAudmVyc2lvbi1jb250cm9sLmdp
dC85MDAxNi9tYXRjaD1uYXJyb3crY2hlY2tvdXQKCj4gIEJ5IHRoZSB3YXksIHdoeSBpcyBpdCAq
cHJlZml4Kj8gV291bGRuJ3QgYSAqcGF0aCBsaW1pdCogYmUgYmV0dGVyPwoKV2VsbCwgeWVzICJw
YXRoIGxpbWl0ZXIiIHNlZW1zIGEgYmV0dGVyIHRlcm0uIEJ1dCBpdCdzIGlycmVsZXZhbnQgbm93
CmJlY2F1c2UgdGhpcyBhcHByb2FjaCB3b24ndCBmbHkuIEknbSBnb2luZyB0byB3YWl0IHRvIHNl
ZSBpZiBhbnlvbmUKdGFrZXMgdGhlIHRhc2sgYXMgcGFydCBvZiBoYWNrb250ZXN0LiBPdGhlcndp
c2UgSSB3aWxsIHJlZG8gbXkgc2VyaWVzLAp1c2luZyBhc3N1bWUgdW5jaGFuZ2VkIGJpdC4KCj4g
IC0tCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEph
biAnQnVsYicgSHVkZWMgPGJ1bGJAdWN3LmN6Pgo+CgoKLS0gCkR1eQo=
