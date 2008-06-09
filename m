From: "David Aguilar" <davvid@gmail.com>
Subject: Re: [StGIT PATCH 3/5] Create a git.Branch class as ancestor of stack.Stack
Date: Sun, 8 Jun 2008 17:07:36 -0700
Message-ID: <402731c90806081707m384edef4p4c2328ac1ee1ea08@mail.gmail.com>
References: <20080604210655.32531.82580.stgit@localhost.localdomain>
	 <20080604211334.32531.74258.stgit@localhost.localdomain>
	 <20080605070126.GC23209@diana.vm.bytemark.co.uk>
	 <b0943d9e0806050503x40191104ye332d6a8435811a5@mail.gmail.com>
	 <20080605130415.GB28995@diana.vm.bytemark.co.uk>
	 <b0943d9e0806060144x48176566m277ba2969087b91e@mail.gmail.com>
	 <20080607090636.GB32647@diana.vm.bytemark.co.uk>
	 <b0943d9e0806081516y575faba9g8b5a27646615f72f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>,
	git-python@googlegroups.com
To: "Catalin Marinas" <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 02:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Uw4-0006wR-Pe
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 02:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbYFIAHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 20:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754742AbYFIAHj
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 20:07:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:63502 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbYFIAHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 20:07:38 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1034890ugf.16
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wa9YXSgMqCbWekMB54Y0AS3siBswkzX6heBeBf64+Is=;
        b=ibfN20jfcagoQ7Xn+G8AQw6KNmaVUNSOBEtLApWx/kfdLiT/gjkhGufYSy7SkvoLD4
         sMqnYUaiQjy58SFJ+sJ502Q2w3cNQpSILq+5q8LtVc5fN9T0Q8EzPKwOnlIgD0eOEmu+
         bd6rPxcqWOLofjM3jlwpU3UT5uVizThbnRrpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WrguNkzzhyU+iULdIrFkB36zT/U58kiCk7YBi4+3n+FEV5felJt2cO2tVxmlV5blir
         SN9sGwUkjb+UGeJQeb33YClzirhtSHTl1TcGhaKj/fq9O0eiXzcm2KQ7pNtmVlFvckvk
         rFx1Ne7Dwn3NreSE0DGOSpgRR54NoukFCdq7A=
Received: by 10.67.89.17 with SMTP id r17mr1295985ugl.2.1212970056668;
        Sun, 08 Jun 2008 17:07:36 -0700 (PDT)
Received: by 10.67.89.14 with HTTP; Sun, 8 Jun 2008 17:07:36 -0700 (PDT)
In-Reply-To: <b0943d9e0806081516y575faba9g8b5a27646615f72f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84350>

T24gU3VuLCBKdW4gOCwgMjAwOCBhdCAzOjE2IFBNLCBDYXRhbGluIE1hcmluYXMKPGNhdGFsaW4u
bWFyaW5hc0BnbWFpbC5jb20+IHdyb3RlOgo+IE9uIDA3LzA2LzIwMDgsIEthcmwgSGFzc2Vsc3Ry
w7ZtIDxraGFAdHJlc2thbC5jb20+IHdyb3RlOgo+PiBPbiAyMDA4LTA2LTA2IDA5OjQ0OjM3ICsw
MTAwLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6Cj4+ICA+IDIwMDgvNi81IEthcmwgSGFzc2Vsc3Ry
w7ZtIDxraGFAdHJlc2thbC5jb20+Ogo+PiA+ID4gV2UnbGwgaGF2ZSB0byBiZSB3YXRjaGZ1bCBh
Z2FpbnN0IGF0dGVtcHRzIHRvIGNyZWF0ZSBvYmplY3RzIG90aGVyCj4+ID4gPiB0aGFuIHZpYSB0
aGUgb2ZmaWNpYWxseSBkZXNpZ25hdGVkIGZhY3RvcmllcywgdGhvdWdoLiBQeXRob24KPj4gPiA+
IGRvZXNuJ3QgcmVhbGx5IGhhdmUgYW55IG1lY2hhbmlzbXMgdGhhdCBoZWxwIHVzIGhlcmUuCj4+
ID4KPj4gPiBJZiB5b3UgcmVhbGx5IHdhbnQgZW5mb3JjaW5nIHRoaXMsIGl0IGNhbiBwcm9iYWJs
eSBiZSBkb25lIGJ5Cj4+ID4gaGFja2luZyBfX25ld19fIGFuZCBfX2luaXRfXy4KPj4KPj4gTm8s
IEkgcmVja29uIHlvdSdyZSByaWdodCAtLSBpdCdzIG92ZXJraWxsLiBTdEdpdCBpcyBzbWFsbCBl
bm91Z2ggdGhhdAo+PiAgd2UgY2FuIHByb2JhYmx5IGVuZm9yY2UgdGhlIHJlbGV2YW50IHJlc3Ry
aWN0aW9ucyBieSBoYW5kLgo+Cj4gSGlkZGVuIHBsYW4gLSBvbmNlIHRoZSBuZXcgc3RnaXQubGli
LmdpdCBtb2R1bGUgaXMgY29tcGxldGUsIHdlIGNhbgo+IGFkdmVydGlzZSBpdCBhcyBhIHN0YW5k
LWFsb25lIG9iamVjdC1vcmllbnRlZCBHaXQgd3JhcHBlciBmb3IgUHl0aG9uCj4gOi0pLiBBdCB0
aGF0IHBvaW50LCB3ZSBjYW4gdGhpbmsgYWJvdXQgZW5mb3JjaW5nIHRoZSBmYWN0b3J5Cj4gbWVj
aGFuaXNtLgo+Cj4gLS0KPiBDYXRhbGluCgpTdXJlbHkgeW91IGRvbid0IHdhbnQgcGVvcGxlIHRv
IGhhdmUgdG8gaW5zdGFsbCBzdGdpdCBqdXN0IHRvICJpbXBvcnQgZ2l0Ij8KKG9yIHBlcmhhcHMg
eW91IGRvLCBzaW5jZSB0aGF0J2QgZ2l2ZSBwZW9wbGUgaW5jZW50aXZlIHRvIGluc3RhbGwgc3Rn
aXQgOykpCgpCYWNrIHRvIHRoZSBwb2ludC4uLgoKQSBmZXcgZm9sa3MgYXJlIHdvcmtpbmcgdG93
YXJkcyBhbiBPTyBnaXQgaW50ZXJmYWNlIGZvciBweXRob24uClBlcmhhcHMgam9pbmluZyBmb3Jj
ZXMgd291bGQgYmUgYSBiaWcgd2luIGZvciBldmVyeW9uZT8KCmh0dHA6Ly9naXRvcmlvdXMub3Jn
L3Byb2plY3RzL2dpdC1weXRob24KCkl0IHdvdWxkIGJlIHJlYWxseSBjb29sIGlmIHdlIGNvdWxk
IHdyYW5nbGUgaW4gYWxsIGludGVyZXN0ZWQgcGFydGllcwp0b3dhcmRzIGEgY29tbW9uIGdvYWwg
Zm9yIHB5dGhvbi4gIFlvdSBndXlzICh0aGUgc3RnaXQgdGVhbSkgaGF2ZSBhCmxvdCBvZiBleHBl
cmllbmNlIGluIHRoaXMgZG9tYWluIHNvIHlvdXIgaWRlYXMgYW5kIG9waW5pb25zIHdvdWxkIGJl
CmdyZWF0bHkgYXBwcmVjaWF0ZWQuCgotLSAKIERhdmlkCg==
