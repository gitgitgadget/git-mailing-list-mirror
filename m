From: Yohann =?utf-8?b?QsOpbsOpZGlj?= <yohann.benedic@orange.com>
Subject: Splitting a project into branches afterwards
Date: Tue, 3 May 2016 15:20:44 +0000 (UTC)
Message-ID: <loom.20160503T090745-628@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 10:15:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axrxo-0004sx-Mz
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757639AbcEDIPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:15:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:55843 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757618AbcEDIPF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:15:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1axrxW-0004kt-In
	for git@vger.kernel.org; Wed, 04 May 2016 10:15:02 +0200
Received: from 161.106.4.5 ([161.106.4.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 May 2016 10:15:02 +0200
Received: from yohann.benedic by 161.106.4.5 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 04 May 2016 10:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 161.106.4.5 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 7.1 points;
 *  1.8 DATE_IN_PAST_12_24 Date: is 12 to 24 hours before Received: date
 *  2.6 RCVD_NUMERIC_HELO Received: contains an IP address used for HELO
 *  2.8 BASE64_LENGTH_79_INF BODY: BASE64_LENGTH_79_INF
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293512>

SGVsbG8gZXZlcnlvbmUhCgpGaXJzdCBvZiBhbGwsIEkgYmVsaWV2ZSB0aGF0IHdoYXQgSSBhbSBhYm91dCB0byBhc2sgaXMgaW1wb3NzaWJsZSwgYnV0IEkgCmdpdmUgaXQgYSBzaG90IGJlY2F1c2UgdGhlcmUgbWF5IGJlIHdheXMgdG8gZ2V0IGEgY2xvc2UgZW5vdWdoIHJlc3VsdCBvciAKYW5vdGhlciBhcHByb2FjaCB0aGF0IEkgaGF2ZSBub3QgdGhpbmtlZCBvZi4KCldoYXQgSSBoYXZlLgpBIGdpdCByZXBvc2l0b3J5IGNsb25lZCBmcm9tIHN2biAoZW50aXJlIHJlcG8gOiAzMCwwMDAgY29tbWl0cyBpbiA2MCAKYnJhbmNoZXMpIHRoYXQgY29udGFpbnMgdGhlIHNvdXJjZSBjb2RlIG9mIHNldmVyYWwgcHJvZHVjdHMgYnVpbHQgYXJvdW5kIGEgCmNvbW1vbiBmcmFtZXdvcmsuIEJyYW5jaGVzIHdoZXJlIG1hZGUgdG8gdHJhY2sgdGhlIGRlbGl2ZXJlZCB2ZXJzaW9uIG9mIGVhY2ggCnByb2R1Y3QsIHNvIHRoYXQgdGhlcmUgaXMgYSBwcm9kdWN0X0FfdjEgYnJhbmNoLCBhIHByb2R1Y3RfQl92MiBicmFuY2gsIGV0Yy4gClRoZSBrZXkgcG9pbnQgaXMgdGhhdCB0aGVyZSBpcyBvbmx5IG9uZSB0cnVuayB0aGF0IGlzIGNvbW1vbiB0byBhbGwgb2YgdGhl
 IApwcm9kdWN0cyBhbmQgZnJhbWV3b3JrLiBUaGUgc291cmNlIGNvZGUgaXMgb3JnYW5pemVkIGluIGEgbG93LWxldmVsIC0+IGhpZ2ggCmxldmVsIGhpZXJhcmNoeSB3aGljaCByZXN1bHRzIGluIG5vdCBoYXZpbmcgYSBjbGVhbiB0b3AgbGV2ZWwgZm9sZGVycyBmb3IgCnByb2R1Y3RfQSwgcHJvZHVjdF9CLCDigKYgYW5kIGZyYW1ld29yay4KCldoYXQgSSB3aXNoIEkgaGFkLgpBIGdpdCByZXBvc2l0b3J5IHdpdGggYSBmcmFtZXdvcmsgYnJhbmNoIHRoYXQgb25seSBjb250YWlucyBjb21tb24gY29kZSwgYSAKcHJvZHVjdF9BIGJyYW5jaCB0aGF0IGRlcml2ZWQgZnJvbSB0aGUgZnJhbWV3b3JrIGJyYW5jaCBhdCBzb21lIHBvaW50LCAKaW50cm9kdWNpbmcgYWxsIHRoZSBwcm9kdWN0X0Etc3BlY2lmaWMgc291cmNlIGNvZGUuIFNhbWUgd2l0aCB0aGUgb3RoZXIgCnByb2R1Y3RzLgoKTXkgYXR0ZW1wdC4KSSBzdGFydGVkIGZyb20gdGhlIG1hc3RlciBicmFuY2ggYW5kIGNyZWF0ZWQgYSBmcmFtZXdvcmsgYnJhbmNoIG91dCBvZiBpdC4gSSAKcmVtb3ZlZCBhbGwgdGhlIHByb2R1Y3Qgc3BlY2lmaWMgY29kZSBmcm9tIGl0IChBLCBCIGV0Yy4pIGFuZC
 Bjb21taXRlZCAKKGxldCdzIGNhbGwgdGhhdCB0aGUgaW5pdGlhbF9yZW1vdmFsIGNvbW1pdCBmb3IgZnVydGhlciByZWZlcmVuY2UpLiBJIHRoZW4gCmNyZWF0ZWQgYSBwcm9kdWN0X0EgYnJhbmNoIGZyb20gdGhlIG1hc3RlciBicmFuY2ggYW5kIHJlbW92ZWQgYWxsIHRoZSAKcHJvZHVjdC1zcGVjaWZpYyBjb2RlIG90aGVyIHRoYW4gcHJvZHVjdCBBJ3MgKGtlZXBpbmcgdGhlIGZyYW1ld29yaykgYW5kIApjb21taXRlZCAodGhhdCdzIGFub3RoZXIgaW5pdGlhbF9yZW1vdmFsIGNvbW1pdCkuIEkgdGhlbiBkaWQgdGhlIHNhbWUgZm9yIApwcm9kdWN0X0IsIEMsIGV0Yy4KQXQgdGhpcyBwb2ludCwgSSBhbSBoYXBweSB3aXRoIHRoZSBzaXR1YXRpb24sIGV2ZW4gdGhvdWdoIHRoZSBoaXN0b3J5IApyZW1pbmRzIG1lIHRoYXQgdGhlIHByb2R1Y3RzIHdlcmUgbm90IGNsZWFubHkgc2VwYXJhdGVkIGZyb20gZWFjaCBvdGhlciBpbiAKdGhlIHBhc3QuIFRoZSBwcm9ibGVtIGlzIHdpdGggdGhlICJpbml0aWFsX3JlbW92YWwiIGNvbW1pdHMgSSBtYWRlIG9uIGVhY2ggCmJyYW5jaC4gSWYgdGhlIGZyYW1ld29yayBicmFuY2ggbW92ZXMgZm9yd2FyZCwgSSB3
 YW50IG15IHByb2R1Y3RfQSBicmFuY2ggdG8gCmJlIGFibGUgZm9sbG93IGFsb25nIDogdGhhdCdzIGEgbWVyZ2Ugb2YgdGhlIGZyYW1ld29yayBmcm9tIHByb2R1Y3RfQS4gSW4gCnByb2R1Y3RfQSwgSSBtaWdodCBmaXggc29tZXRoaW5nIGZyb20gdGhlIGZyYW1ld29yayBhbmQgbmVlZCB0byBwYXRjaCB0aGUgCmxhdHRlci4gVGhhdCdzIGEgbWVyZ2UgaW4gdGhlIG90aGVyIGRpcmVjdGlvbi4gQm90aCB0aGVzZSBtZXJnZXMgd2lsbCBhcHBseSAKdGhlICJpbml0aWFsX3JlbW92YWwiIGNvbW1pdHMsIGdlbmVyYXRpbmcgY29uZmxpY3MgYXQgYmVzdCwgc2lsZW50bHkgCnN1Y2NlZWRpbmcgYXQgd29yc3QuIEFuZCB0aGF0J3Mgd2VyZSBJIGFtIHN0dWNrIGJlY2F1c2UgYW5kIGNhbid0IGZpbmQgYSB3YXkgCnRvIHRlbGwgZ2l0IHRvIGlnbm9yZSB0aGVtIG9uY2UgYW5kIGZvciBhbGwgc28gdGhhdCBJIGNhbiBoYXZlIGEgbm9ybWFsIAp3b3JrZmxvdyBhZnRlcndhcmRzLgoKRnVydGhlciBpZGVhcy4KSSBmZWVsIGxpa2Ugc3ViLXRyZWVzIG1pZ2h0IGhlbHAgbWUgaGVyZSwgYnV0IEkgaGF2ZW4ndCBsZWFybmVkIGVub3VnaCBhYm91dCAKdGhlbSB0by
 BrbndvIGZvciBzdXJlOiBhbnlvbmUgdGVsbGluZyBtZSAibm9wZSB0aGV5IHdvbid0IGhlbHAiIG9yICJ5ZXMgCnRoYXQncyB3aGF0IHlvdSBhcmUgbG9va2luZyBmb3IiIHdvdWxkIGhlbHAuCkFueSBjb21wbGV0ZSBwcm9jZWR1cmUgaXMgd2VsY29tZGUgdG9vIDopIGFzIHdlZWwgYXMgcG9pbnRlcnMgdG8gb3RoZXIgZ2l0IApjb25jZXB0cy4KClRoYW5rIHlvdSBhbGwgZm9yIHlvdXIgdGltZS4KCllvaGFubgoKUFMuIEkgYW0gbm90IGEgbmF0aXZlIGVuZ2xpc2ggc3BlYWtlci4gUGxlYXNlLCBmb3JnaXZlIGFueSBtaXN0YWtlIG9yIAptaXNsZWFkaW5nIHNlbnRlbmNlIEkgbWlnaHQgaGF2ZSB3cml0dGVuLiBDb3JyZWN0aW9ucyBhcmUgd2VsY29tZWQgdG9vIQ==
