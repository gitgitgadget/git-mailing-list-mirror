From: "Matthias Kestenholz" <mk@spinlock.ch>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 18:04:00 +0200
Message-ID: <1f6632e50808260904t6bea0be5kc69342917e3db97@mail.gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <1219664940.9583.42.camel@pmac.infradead.org>
	 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <1219764860.4471.13.camel@gaara.bos.redhat.com>
	 <1219766398.7107.87.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, users@kernel.org
To: "David Woodhouse" <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 18:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY12q-00031i-CY
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 18:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763AbYHZQEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 12:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756599AbYHZQEF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 12:04:05 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:52970 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbYHZQEC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 12:04:02 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1790080ika.5
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 09:04:01 -0700 (PDT)
Received: by 10.210.52.9 with SMTP id z9mr8581095ebz.189.1219766640844;
        Tue, 26 Aug 2008 09:04:00 -0700 (PDT)
Received: by 10.210.130.16 with HTTP; Tue, 26 Aug 2008 09:04:00 -0700 (PDT)
In-Reply-To: <1219766398.7107.87.camel@pmac.infradead.org>
Content-Disposition: inline
X-Google-Sender-Auth: a0fccd4c2ddb7b74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93753>

T24gVHVlLCBBdWcgMjYsIDIwMDggYXQgNTo1OSBQTSwgRGF2aWQgV29vZGhvdXNlIDxkd213MkBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPiBPbiBUdWUsIDIwMDgtMDgtMjYgYXQgMTE6MzQgLTA0MDAs
IEtyaXN0aWFuIEjDuGdzYmVyZyB3cm90ZToKPj4gSXQncyBwcmV0dHkgbm9ybWFsIHRvIHNlZSBv
cHBvbmVudHMgb2YgYSBkZWNpc2lvbiBsaWtlIHRoaXMgY29tcGxhaW4KPj4gbG91ZGx5IHdoZW4g
aXQgbGFuZHMgb24gdGhlaXIgc3lzdGVtLCB3aGVyZWFzIHRoZSBzaWxlbnQgbWFqb3JpdHkgaW4K
Pj4gZmF2b3VyIHdpbGwgYmUgaGFwcHkgdG8gc2VlIHRoZSBjaGFuZ2UgZmluYWxseSBpbXBsZW1l
bnRlZCBidXQgcmVsdWN0YW50Cj4+IHRvIHN0aXIgdXAgdGhlIGRpc2N1c3Npb24gYWdhaW4uCj4+
Cj4+IEkgZG9uJ3QgdGhpbmsgbmV3IGFyZ3VtZW50cyBhcmUgYnJvdWdodCB0byB0aGUgZGlzY3Vz
c2lvbiwganVzdCBuZXcKPj4gcGVvcGxlLCB3aG8gYXJlIHRlbXBvcmFyaWx5IGluY29udmVuZWQg
YnkgYSBjaGFuZ2UgdG93YXJkcyBzYW5pdHkuCj4KPiBOaWNlIGVtb3RpdmUgcmVzcG9uc2UsIGVz
cGVjaWFsbHkgdGhlIHN1YnRsZSBidXQgdW5zdWJzdGFudGlhdGVkICdzaWxlbnQKPiBtYWpvcml0
eSBpbiBmYXZvdXInIGJpdCAtLSBidXQgeW91IGZvcmdvdCB0aGUgcGFydCB3aGVyZSB5b3Ugd2Vy
ZQo+IHN1cHBvc2VkIHRvIGFjdHVhbGx5IHBvaW50IG91dCBhIHRhbmdpYmxlIGJlbmVmaXQgd2hp
Y2ggaXMgYWNoaWV2ZWQgYnkKPiBicmVha2luZyBjb21wYXRpYmlsaXR5IGxpa2UgdGhpcy4KPgo+
IEFuZCBubywgcmVkdWNpbmcgdGhlIHNpemUgb2YgL3Vzci9iaW4gYnkgYSB0aW55IGZyYWN0aW9u
IGlzbid0IHJlYWxseSBhCj4gd29ydGh3aGlsZSBiZW5lZml0IC0tIGluIHJlYWxpdHksIHRoZSAn
c2lsZW50IG1ham9yaXR5JyByZWFsbHkgY291bGRuJ3QKPiBnaXZlIGEgbW9ua2V5J3MgbGVmdCB0
ZXN0aWNsZSBhYm91dCB0aGF0LCBhbmQgYnJlYWthZ2UgY2F1c2VkIGJ5IHRoZQo+IGdyYXR1aXRv
dXMgY2hhbmdlIF9mYXJfIG91dHdlaWdocyBhbnkgbWludXNjdWxlIGltcHJvdmVtZW50Lgo+CgpD
b3JyZWN0LCBidXQgdGhlcmUgaXMgYSBiZW5lZml0LiBJbWFnaW5lIGEgbmV3IHVzZXI6CgpnaXQt
PHRhYj48dGFiPiAuLi4gd2hhdD8gMTQwLXNvbWV0aGluZyBjb21tYW5kcz8gSSdsbCBiZXR0ZXIg
c3RhcnQgbG9va2luZwpmb3IgYWx0ZXJuYXRpdmVzIF9yaWdodCBub3dfIQoKSGF2aW5nIGEgY2x1
dHRlcmVkIG5hbWVzcGFjZSBpcyBuZXZlciBhIGdvb2QgdGhpbmcuIEl0IG1lYW5zIHRoYXQgaXQn
cwpsZXNzIG9idmlvdXMgd2hpY2ggY29tbWFuZHMgeW91IGFyZSBzdXBwb3NlZCB0byB1c2UgZXRj
Lgo=
