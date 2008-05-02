From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/5] Introduce -ff=<fast forward option>
Date: Fri, 2 May 2008 20:33:00 +0800
Message-ID: <46dff0320805020533u179e16cej2c4db3105252d0bd@mail.gmail.com>
References: <402c10cd0804232246i6f7cd946h955b75832cf32876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 14:34:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JruSl-00038u-OM
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 14:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934813AbYEBMdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 08:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934849AbYEBMdD
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 08:33:03 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:2754 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763553AbYEBMdB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 08:33:01 -0400
Received: by an-out-0708.google.com with SMTP id d40so304348and.103
        for <git@vger.kernel.org>; Fri, 02 May 2008 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jHSekst+RoQ4T6Q5ZTYIgwrxbtCxeSu20gIOyaQ65EU=;
        b=cAakaMqAfwT7+3QFatvaPtP7jAZCSRtxFUunkwHWEKEzgCUiIScu/0vRq6TCkKuYl0o+fvsnjk/0y3o5jw25VXBPVlxnebYGtxrJfu1DVdA4wl5wQQkIKJo1YSHDHtedJCC1Kg/wze2fyIT8R8tzIX5tzIf32CuR3GMKUQgBfBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vILlpvoeBO6Zk1l10JWHCxhyzJIqzcKM6pTpPOJs3MRaBTo5CWE9Z6WuIZecUVbkHHEZKXeivLxDH4AYaEJmsTLA6DmTe7UPIsSLW9p4UyyLFBLKo4Vi4PjZoxfU0G0RZ0gFuhV+DLvi2Z1EyI+jMSjC55/aiAJwF0Ya0Sc4hIU=
Received: by 10.101.70.5 with SMTP id x5mr4458764ank.93.1209731580103;
        Fri, 02 May 2008 05:33:00 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 2 May 2008 05:33:00 -0700 (PDT)
In-Reply-To: <402c10cd0804232246i6f7cd946h955b75832cf32876@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80982>

T24gVGh1LCBBcHIgMjQsIDIwMDggYXQgMTo0NiBQTSwgU3ZlcnJlIEh2YW1tZW4gSm9oYW5zZW4K
PGh2YW1tZW5AZ21haWwuY29tPiB3cm90ZToKPiAtLWZmIG5vdyB0YWtlcyBhbiBhcmd1bWVudCBh
bGxvd2luZyAtLWZmIHRvIGJlIHdyaXR0ZW4KPiAgYXMgLS1mZj1hbGxvdyBhbmQgLW5vLWZmIHRv
IGJlIHdyaXR0ZW4gYXMgLS1mZj1uZXZlci4KPiAgVGhpcyBjaGFuZ2UgYWxsb3cgb3RoZXIgZmFz
dCBmb3J3YXJkIG9wdGlvbnMgdG8gYmUKPiAgaW50cm9kdWNlZCBsYXRlci4KPgo+ICBTZWUgdGhl
IGRvY3VtZW50YXRpb24gZm9yIGEgZnVydGhlciBleHBsYW5hdGlvbiBvZiB0aGVzZSBvcHRpb25z
Lgo+Cj4gIFNpZ25lZC1vZmYtYnk6IFN2ZXJyZSBIdmFtbWVuIEpvaGFuc2VuIDxodmFtbWVuQGdt
YWlsLmNvbT4KPiAgLS0tCj4gICBEb2N1bWVudGF0aW9uL2Zhc3QtZm9yd2FyZC1vcHRpb25zLnR4
dCB8ICAgNDQgKysrKysrKysKPiAgIERvY3VtZW50YXRpb24vZ2l0LW1lcmdlLnR4dCAgICAgICAg
ICAgIHwgICAgNiArLQo+ICAgRG9jdW1lbnRhdGlvbi9naXQtcHVsbC50eHQgICAgICAgICAgICAg
fCAgICAyICsKPiAgIERvY3VtZW50YXRpb24vbWVyZ2Utb3B0aW9ucy50eHQgICAgICAgIHwgICAg
OSArLQo+ICAgZ2l0LW1lcmdlLnNoICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDQ3ICsr
KysrLS0tCj4gICBnaXQtcHVsbC5zaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDQg
Ky0KPiAgIHQvdDc2MDEtbWVyZ2UtZmYtb3B0aW9ucy5zaCAgICAgICAgICAgIHwgIDE4OCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAgNyBmaWxlcyBjaGFuZ2VkLCAyNzcgaW5z
ZXJ0aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9mYXN0LWZvcndhcmQtb3B0aW9ucy50eHQKPgo+ICBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9mYXN0LWZvcndhcmQtb3B0aW9ucy50eHQKPiAgYi9Eb2N1bWVudGF0aW9uL2Zhc3Qt
Zm9yd2FyZC1vcHRpb25zLnR4dAo+ICBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ICBpbmRleCAwMDAw
MDAwLi45NWQwZTZmCj4gIC0tLSAvZGV2L251bGwKPiAgKysrIGIvRG9jdW1lbnRhdGlvbi9mYXN0
LWZvcndhcmQtb3B0aW9ucy50eHQKPiAgQEAgLTAsMCArMSw0NCBAQAo+ICArRkFTVCBGT1JXQVJE
IE9QVElPTlMKPiAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICsKPiAgK2FsbG93OjoKPiAgKwo+
ICArICAgICAgIERvIG5vdCBnZW5lcmF0ZSBhIG1lcmdlIGNvbW1pdCBpZiB0aGUgbWVyZ2UgcmVz
b2x2ZXMgYXMgYQo+ICArICAgICAgIGZhc3QtZm9yd2FyZCwgb25seSB1cGRhdGUgdGhlIGJyYW5j
aCBwb2ludGVyLiAgVGhpcyBvcHRpb24gaXMKPiAgKyAgICAgICBlcXVpdmFsZW50IG9mICctLWZm
JyB3aXRob3V0IGFueSBhcmd1bWVudC4gIFRoaXMgaXMgdGhlCj4gICsgICAgICAgZGVmYXVsdCBi
ZWhhdmlvci4KCm9ubHkgYW5kIG5ldmVyIGFyZSBib3RoIGFkdmVyYu+8jGJ1dCBhbGxvdyBpcyBh
IHZlcmIuIFNvIGhvdyBhYm91dCB1c2luZwphdXRvIGluc3RlYWQgb2YgYWxsb3c/CgoKLS0gClBp
bmcgWWluCg==
