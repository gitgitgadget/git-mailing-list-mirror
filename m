From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] diffcore-rename: support rename cache
Date: Sat, 8 Nov 2008 11:01:20 +0700
Message-ID: <fcaeb9bf0811072001o6df7ae00k1b1bffaadf75d3a1@mail.gmail.com>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com>
	 <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net>
	 <7vy6zvdt25.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Yann Dirson" <ydirson@altern.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 05:02:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyf1y-0006kT-G4
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 05:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbYKHEBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 23:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbYKHEBX
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 23:01:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:45982 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbYKHEBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 23:01:22 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1292790fgg.17
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 20:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xSVATnVFlaUTZDH43tTcHzKve0syEMDh0UHGNzN2DXo=;
        b=tQFJLwoG0WwjvvJTnHBRHtyOUY1XvAJuZqn+0iPukW+HFLW9ipEib2FLeEfoAL/Ivm
         aJ/wC+dAiM/h3NQBZ9brTvatEXp5DrmuKxgnUPqft4P34wUSOHxOHtkFqIghq4hHsFag
         iDI55iUJDof2ASN7/76aez1nh66JY4Avf6wRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Pz4yydcFyGKR3znr9um7nrR1h92RM7W7jgfE20sg9IklW5Jbb6v4c+9B+MF7OlttE3
         lbw3EV+G1dhVsgd2BU77oWUNiU8/0OQVjCGSXQnV3IO2X1DlbIBg/ZIE8kFPmP0aGmU9
         adfzh36x3/CpZBL7Gw/bG6PmTepPhlXqXsg9E=
Received: by 10.86.51.10 with SMTP id y10mr4676115fgy.9.1226116880591;
        Fri, 07 Nov 2008 20:01:20 -0800 (PST)
Received: by 10.86.27.20 with HTTP; Fri, 7 Nov 2008 20:01:20 -0800 (PST)
In-Reply-To: <7vy6zvdt25.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100373>

T24gMTEvOC8wOCwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToKPiBZ
YW5uIERpcnNvbiA8eWRpcnNvbkBhbHRlcm4ub3JnPiB3cml0ZXM6Cj4KPiAgPiBPbiBGcmksIE5v
diAwNywgMjAwOCBhdCAwOTozNTozMlBNICswNzAwLCBOZ3V5Pz8/biBUaMOhaSBOZz8/P2MgRHV5
IHdyb3RlOgo+ICA+PiBUaGlzIHBhdGNoIHRlYWNoZXMgZGlmZmNvcmVfcmVuYW1lKCkgdG8gbG9v
ayBpbnRvCj4gID4+ICRHSVRfRElSL3JlbmFtZS1jYWNoZSBhbmQgbWFrZSB1c2Ugb2YgaXQgdG8g
cmVjcmVhdGUgZGlmZl9maWxlcGFpci4KPiAgPj4gV2l0aCBwcm9wZXIgY2FjaGUsIHRoZXJlIHNo
b3VsZCBiZSBubyBhdmFpbGFibGUgZW50cnkgZm9yIGVzdGltYXRpb24KPiAgPj4gYWZ0ZXIgZXhh
Y3QgbWF0Y2hpbmcuCj4gID4KPiAgPiBUaGlzIGlzIHNvbWV0aGluZyBJIGhhdmUgdGhvdWdodCBh
Ym91dCBpbiB0aGUgcGFzdCwgZ29vZCB0byBzZWUgdGhhdAo+ICA+IGltcGxlbWVudGVkIDopCj4g
ID4KPiAgPj4gUmVuYW1lIGNhY2hpbmcgaXMgcGVyIGNvbW1pdC4gSSBkb24ndCB0aGluayBhYml0
cmFyeSB0cmVlLXRyZWUgY2FjaGluZwo+ICA+PiBpcyB3b3J0aCBpdC4KPiAgPgo+ICA+IFRoYXQg
Y291bGQgYmUgYSBuaWNlIGNvbXBsZW1lbnQgdG8gbXkgZGlyZWN0b3J5LXJlbmFtZSBwYXRjaC4K
Pgo+Cj4gSGFzIGFueWJvZHkgdGhvdWdodCBhYm91dCBpbnRlcmFjdGlvbiBiZXR3ZWVuIHRoYXQg
Y2FjaGluZyBhbmQgcGF0aHNwZWMKPiAgbGltaXRlZCBvcGVyYXRpb24/Cj4KCkkgZGlkbid0LiBC
dXQgSSB0aGluayBhbGwgb3V0LW9mLXBhdGhzcGVjIGRpZmYgcGFpcnMgYXJlIHJlbW92ZWQKYmVm
b3JlIGl0IHJlYWNoZXMgZGlmZmNvcmVfcmVuYW1lKCkgc28gdGhlIGNhY2hlIGhhcyBub3RoaW5n
IHRvIGRvCndpdGggaXQgKGV4Y2VwdCBpdCBzdGlsbCBsb2FkcyBmdWxsIGNhY2hlIGZvciBhIGNv
bW1pdCkuCi0tIApEdXkK
