From: Mattias =?utf-8?b?VmFubmVyZ8OlcmQ=?= 
	<mattias.vannergard@gmail.com>
Subject: Re: FW: Query on git submodules
Date: Tue, 2 Jun 2015 09:45:39 +0000 (UTC)
Message-ID: <loom.20150602T113612-540@post.gmane.org>
References: <4C328B7D13677A4EAF715D0755A6D7EE25C56C89@irsmsx110.ger.corp.intel.com> <4C328B7D13677A4EAF715D0755A6D7EE25C589BF@irsmsx110.ger.corp.intel.com> <20150526170125.GC31115@book.hvoigt.net> <4C328B7D13677A4EAF715D0755A6D7EE25C5AD9E@irsmsx110.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 11:50:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yziq0-0002L4-3b
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 11:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbbFBJuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 05:50:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:46720 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbbFBJuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 05:50:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Yziph-00027Y-1K
	for git@vger.kernel.org; Tue, 02 Jun 2015 11:50:05 +0200
Received: from 194.103.240.26 ([194.103.240.26])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:50:05 +0200
Received: from mattias.vannergard by 194.103.240.26 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:50:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.103.240.26 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.81 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.4 points;
 *  2.6 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  2.8 BASE64_LENGTH_79_INF BODY: BASE64_LENGTH_79_INF
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270513>

RnJhd2xleSwgU2FyYWggPHNhcmFoLmZyYXdsZXkgPGF0PiBpbnRlbC5jb20+IHdyaXRlczoKPiBDb3JyZWN0IHdoZW4gSSByZWZlcnJlZCB0byAxMCsgbGF5ZXJzIEkgbWVhbnQgbmVzdGVkIHJlcG9zaXRvcmllcyAKd2hpY2ggbWFrZSB1cCBhIGxhcmdlIGhpZXJhcmNoeS7CoCBTb21lCj4gcmVwb3NpdG9yaWVzIGFyZSByZXBlYXRlZCBhY3Jvc3MgdGhlIGhpZXJhcmNoeS7CoCBXZSBjaGVjay1vdXQgCnN1Ym1vZHVsZXMgdG8gdGFnIHZlcnNpb25zIChhcyBvcHBvc2VkCj4gdG8gbWFzdGVyIGJyYW5jaCkuwqAgSWYgd2UgbmVlZCB0byByb2xsIG91dCBhIHBhcnRpY3VsYXIgY2hhbmdlIGFjcm9zcyAKYSBoaWVyYXJjaHkgKGUuZy4gNjAgcmVwb3MpIHRoZW4KPiBldmVyeSBsZXZlbCBpbiB0aGUgaGllcmFyY2h5IG5lZWRzIHRvIHBpY2sgdXAgbmV3IHN1Ym1vZHVsZSB0YWdzLgo+IAo+IFRoZSBtYWluIDIgaXNzdWVzIHRoYXQgd2Ugc2VlIGFyZToKPiAKPiAxLiBFbmZvcmNlbWVudCBvZiBhYnNvbHV0ZSBwYXRocyBpbiBnaXQgc3VibW9kdWxlcyAtIEkgYW0gY3VycmVudGx5IAp0cmlhbGluZyB1c2luZyBhIHByZS1jb21taXQgaG9vayB0bwo+IGhpZ2hs
 aWdodCB0aGlzIGlzc3VlIHRvIHVzZXJzIHNvIHRoYXQgdGhleSBjYW4gZml4IHRoZWlyIHN1Ym1vZHVsZSAKdXJscyB0byByZWxhdGl2ZSBwYXRocy4KPiAKCldlIGVuZm9yY2VkIHRoZSBjb25maWcgZmlsZSBpbnN0ZWFkIChjb250YWluaW5nIHRoZSBob3N0LCBwb3J0IGFuZCAKdXNlcm5hbWUpIGJlY2F1c2Ugd2UgdXNlIEdlcnJpdC4gU28sIG91ciB1cmxzIGFyZSBqdXN0CnNzaDpcXDxzZXJ2ZXI+OjxyZXBvPgoKPiAyLiBTbG93bmVzcyBJbnRlZ3JhdGluZyB1cGRhdGVzIHRvIHN1Ym1vZHVsZSBoaWVyYXJjaHkgLUkgaGF2ZSBiZWVuIApsb29raW5nIGF0IHdheXMgb2YgYXV0b21hdGluZyBzdWNoIGEKPiByb2xsIG91dCAtIHRoaXMgY2FuIGJlIHVzZWZ1bCBmb3IgbmV3IHByb2plY3Qgc2V0dXBzIG9yIGZvciByb2xsaW5nIApvdXQgYW4gdXBkYXRlIHRvIGFsbCByZXBvcyBhbmQgcXVpY2tseQo+IGludGVncmF0aW5nIGl0IGludG8gdGhlIHN1Ym1vZHVsZSBoaWVyYXJjaHkuwqAgVGhlIGxpbmsgYmVsb3cgc2hvd3MgCnNvbWV0aGluZyBzaW1pbGFyIGhvd2V2ZXIgaXQgY2hlY2tzCj4gb3V0IGEgbWFzdGVyIGJyYW5jaCBvZiBlYWNoIHN1Ym1vZH
 VsZSBpbiBpdHMgaGllcmFyY2h5LiAKaHR0cHM6Ly9jaHJpc2plYW4uY29tL3JlY3Vyc2l2ZWx5LXVwZGF0aW5nLWdpdC1zdWJtb2R1bGVzLwo+IAoKSSBoYXZlbid0IGJlZW4gYWJsZSB0byBjaGVjayBwZXJmb3JtYW5jZSBhdCBvdXIgc2l0ZSB5ZXQuCgo+IFRoYW5rcywKPiBTYXJhaCAKCkkgYW0gcGxhbm5pbmcgb24gdXNpbmcgc3VibW9kdWxlcyBpbiBhIHdheSwgd2hlcmUgSSBjYW4gc3BlY2lmeSBhIApjb25maWd1cmF0aW9uIG9mIHJlcG9zIHdpdGggdGFncywgYW5kIHJlYnVpbGQgdGhlIHN1Ym1vZHVsZSB0cmVlLCB3aGVuIApzZWxlY3RpbmcgYSBjb25maWd1cmF0aW9uIG9uIHRoZSB0b3AgbGV2ZWwuCgpCdXQsIHlldCBJIGhhdmUgZm91bmQgbm8gZWFzeSB3YXkgdG8gc2VsZWN0IHRoZSB0YWcgaW4gYSBzdWJyZXBvLiBJIAp3b3VsZCBsaWtlIHRoZSAuZ2l0bW9kdWxlcyB0byBhY2NlcHQgdGFnIGluc3RlYWQgb2YgYnJhbmNoLiBJIHRoaW5rIAp0aGVyZSBpcyB2ZXJ5IGxpdHRsZSBkaWZmZXJlbmNlIGJldHdlZW4gc3BlY2lmeWluZyBhIGJyYW5jaCBvciBhIHRhZywgCmJ1dCBpdCBpcyBtb3JlIGNvbnZlbmllbnQgdG8gaGF2ZSB0aGUgcmVs
 ZWFzZSB2ZXJzaW9uIGFzIGEgdGFnLgoKU28sIGlmIGEgcHJvZHVjdCBBLCBjb25zaXN0IG9mIHN1YmNvbXBvbmVudHMgYTEsIGEyIGFuZCBhMywgdGhlIHZlcnNpb24gCnYxLjEgb2YgcHJvZHVjdCBBIHdpbGwgaGF2ZSBhIGNvbmZpZ3VyYXRpb24gc2F5aW5nOiBhMSwgdGFnPXYwLjQ7IGEyLCAKdGFnPXYxLjA7IGEzLCB0YWc9djIuMAoKU3ViY29tcG9uZW50IGNhbiBiZSBib3RoIGEgcHJlLWJ1aWx0IGJpbmFyeSBvciBhIHNoYXJlZC9jb21tb24gc291cmNlIApiYXNlLCBvciBhIGNvbXBsZXRlIDNyZCBwYXJ0eSByZXBvc2l0b3J5LgoKSXMgdGhpcyBjb21wYXJhYmxlIHRvIHlvdXIgc2l0dWF0aW9uPwoKSSBhbSBjdXJyZW50bHkgd29ya2luZyBvbiBlZGl0aW5nIHRoZSBnaXQtc3VibW9kdWxlcyB0byBhZGQgLXQgKGFzIGluIAp0YWcpLiBJIG5lZWQgdG8gZmluZCBhbiBlYXN5IHdheSB0byBzd2l0Y2ggYmV0d2VlbiB0cmFja2luZyBhIGJyYW5jaCBhbmQgCmxvY2tpbmcgdG8gdGFnLCB0aG91Z2guCgpCUgovTWF0dGlhcwo=
