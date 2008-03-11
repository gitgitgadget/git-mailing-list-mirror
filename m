From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 03/10] Make get_git_dir() and 'git rev-parse --git-dir' absolute path
Date: Tue, 11 Mar 2008 22:39:02 +0700
Message-ID: <fcaeb9bf0803110839m582bed5cr5b3e198712e0fe8e@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103348.GA8929@laptop>
	 <alpine.LSU.1.00.0803111420080.3873@racer.site>
	 <fcaeb9bf0803110806u43fbd8b8v3ec2adf84fa1cd5e@mail.gmail.com>
	 <alpine.LSU.1.00.0803111616050.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:40:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ6Zw-00061T-50
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbYCKPjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753580AbYCKPjH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:39:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:48710 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbYCKPjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:39:05 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2455906fga.17
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cS/wIY/gykTkrQYfZWlWshdiJzxEZAjvZyQdTi9HXiY=;
        b=oje0AHKBsBXG5M1G24dkAc2OdpEl9z3kl+rV470wnA7Q+/KWuAKJfvKD52Q5/4ABvXquPVqXZO/rwCsZFTOkoFzb0+IkBpeqF53Mu8YNS0iHi7ETsDPkpnYf4s5dG1fTZUz54SEswRMINuv8z6/7lurMVV6vrDwUdzX8TppZ0vA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U0AadW9127WuL7Lbkt97AvlO1dHPm7bF+w6ES01e/5dX0lPJq/1daqLaYzPsnDyIbiInpRUYu6j/Zh3hamw3jyRvzi1MhZbOfwwaRWiYEZ3z/HTfFzNoEwqqlBObPoci97GXFTAMycwl7OhdqCZmIXObBia5xPxJSgaRUQ9Y3lU=
Received: by 10.86.96.18 with SMTP id t18mr8362278fgb.4.1205249942803;
        Tue, 11 Mar 2008 08:39:02 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 08:39:02 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111616050.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76869>

T24gVHVlLCBNYXIgMTEsIDIwMDggYXQgMTA6MTggUE0sIEpvaGFubmVzIFNjaGluZGVsaW4KPEpv
aGFubmVzLlNjaGluZGVsaW5AZ214LmRlPiB3cm90ZToKPiBIaSwKPgo+Cj4gIE9uIFR1ZSwgMTEg
TWFyIDIwMDgsIE5ndXllbiBUaGFpIE5nb2MgRHV5IHdyb3RlOgo+Cj4gID4gT24gVHVlLCBNYXIg
MTEsIDIwMDggYXQgODoyMCBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo+ICA+IDxKb2hhbm5lcy5T
Y2hpbmRlbGluQGdteC5kZT4gd3JvdGU6Cj4gID4KPgo+ID4gPiAgT24gU3VuLCAyIE1hciAyMDA4
LCBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IHdyb3RlOgo+ICA+ID4KPiAgPiA+ICA+IFNpZ25l
ZC1vZmYtYnk6IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgPHBjbG91ZHNAZ21haWwuY29tPgo+
ICA+ID4KPiAgPiA+ICBJIGRvIG5vdCBsaWtlIHRoaXMgY2hhbmdlLiAgSXQgaXMgSU1PIGNvbXBs
ZXRlbHkgdW5uZWNlc3NhcnksIGFuZAo+ICA+ID4gIG1pZ2h0IGJyZWFrIGFzc3VtcHRpb25zLgo+
ICA+Cj4gID4gSXQgY291bGQuIEFuZCBJIHRyaWVkIG15IGJlc3QgdG8gbWFrZSBzdXJlIGl0IGRp
ZCBub3QgYnJlYWsgYW55dGhpbmcuCj4KPiAgVGhhdCBpcyBjb250cmFkaWN0aW5nLiAgSSB0aGlu
ayB0aGF0IHdoYXRldmVyIHlvdSB0cmllZCwgb25jZSB5b3UgbGV0Cj4gIHJldi1wYXJzZSAtLWdp
dC1kaXIgcmV0dXJuIG9ubHkgYWJzb2x1dGUgcGF0aHMsIHlvdSBhbHJlYWR5IHJpc2tlZAo+ICBi
cmVha2FnZS4KPgo+ICBCZXNpZGVzLCBJIHJlbWVtYmVyIHRoYXQgSnVuaW8gc3BlY2lmaWNhbGx5
IHJlcXVlc3RlZCB0aGF0IEkgd291bGQgX25vdF8KPiAgZG8gc29tZXRoaW5nIGxpa2UgdGhhdCAo
dGhpcyB3YXMgZm9yIC0tc2hvdy1jZHVwLCBidXQgSSB0aGluayBpdCByZWFsbHkKPiAgYXBwbGll
cyBoZXJlLCB0b28pLgoKSSBtaWdodCBoYXZlIGxvc3QgdHJhY2suIENvdWxkIHlvdSBwcm92aWRl
IG1lIHRoZSBsaW5rIGZvciByZWZlcmVuY2U/IFRoYW5rcy4KCj4gID4gV2hpbGUgaXQncyBub3Qg
cmVhbGx5IG5lY2Vzc2FyeSwgaXQgd291bGQgYmUgSU1ITyBhIGdvb2QgY2hhbmdlIGFzIHlvdQo+
ICA+IHdvdWxkIG5vdCBoYXZlIHRvIHJlbHkgb24gYGN3ZGAgYW55bW9yZSAodGhhdCB3b3VsZCBt
ZWFuIHdoZXRoZXIgbW92aW5nCj4gID4gY3dkIGJ5IHByZWZpeCBvciBub3Qgd291bGQgbm8gbG9u
Z2VyIG1hdHRlcikuCj4KPiAgSSBkbyBub3Qgc2VlIHRoZSBwcm9ibGVtLiAgQW5kIHRoZXJlZm9y
ZSBJIGRvIG5vdCBzZWUgdGhhdCB0aGlzIHBhdGNoCj4gIHNvbHZlcyBhbnl0aGluZy4KCkl0IGNh
biBzaW1wbGlmeSB0aGluZ3MgKGluIG90aGVyIHBhdGNoZXMsIHN1Y2ggYXMgYnVpbHRpbi1jb25m
aWcuYwpjaGFuZ2VzKS4gVGhvdWdoIHdpdGhvdXQgaXQgdGhpbmdzIGp1c3QgcnVuIGZpbmUgKHdp
dGggYSBsaXR0bGUgbW9yZQpjb21wbGljYXRpb24gaW4gcHJlZml4IGhhbmRsaW5nKS4gUmVjZW50
IG1haWxzIGFib3V0IGdpdC1hbSBydW5uaW5nIGluCnN1YmRpcmVjdG9yeSAoTWVzc2FnZS1JRDoK
MjAwODAzMDEwNjIyNTUuR0EyNzUzOEBjb3JlZHVtcC5pbnRyYS5wZWZmLm5ldCkgbWFkZSBtZSB0
aGluayB0aGVyZQp3YXMgcm9vbSBmb3IgdGhpcy4KCkl0IGlzIGFsc28gcHJlcmVxdWlzaXRlIGZv
ciBsYXRlciBjaGFuZ2VzIGluIHRoZSBzZXJpZXMgKElJUkMsCnJlbW92aW5nIHByZWZpeCBmcm9t
IHNldHVwKl9nZW50bHkoKSBuZWVkcyBpdCkuCgo+ICBDaWFvLAo+ICBEc2Nobwo+CgoKCi0tIApE
dXkK
