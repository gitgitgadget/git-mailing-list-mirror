From: "Jonathan del Strother" <maillist@steelskies.com>
Subject: Re: [PATCH] Add OS X support to the pre-auto-gc example hook
Date: Sat, 27 Sep 2008 10:53:31 +0100
Message-ID: <57518fd10809270253s4c07318bjd54c7d86460ce7d7@mail.gmail.com>
References: <1222209803-4401-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <20080925232008.GO23137@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 11:55:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjWVz-0003lG-EN
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 11:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbYI0Jxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 05:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbYI0Jxd
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 05:53:33 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:54585 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYI0Jxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 05:53:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1472985wfd.4
        for <git@vger.kernel.org>; Sat, 27 Sep 2008 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=PIM7eltF+/e4rcMRJ8wU79PBKNRNbvdvjc9CNPxwyL4=;
        b=Q37hXUdWaq6hqChu6QH7kmct7j+F2FOMQoIe8eWC1HosuuuhZRvRTkT4y6VWMwh0b7
         id2Ds9TDeuKcoi0W7hISb9c85J8qE50fWaQvNTr/hUD2Xy5OOiBAk3L8VP1GljStgWsC
         sMjx9BDXHepPUzq4O/QzpWxl9oupt9JwqsBqg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=snLXGPXQbvsb62g8q/quMs2IGQrw51H779VjUQ2zQQFOzzgAHmeu9smMPkNMUj+yqY
         /B7EtOy1LbUZWqC2b8Tw1Ce0x/d0zhxT7Wd2iVRXFo4ZtSunimvYHEinXvA7WUImBgFX
         nUcp8jxATGacXj0xL/qPNo759AFwTFLL2I4Eg=
Received: by 10.143.37.20 with SMTP id p20mr1078335wfj.252.1222509211546;
        Sat, 27 Sep 2008 02:53:31 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Sat, 27 Sep 2008 02:53:31 -0700 (PDT)
In-Reply-To: <20080925232008.GO23137@genesis.frugalware.org>
Content-Disposition: inline
X-Google-Sender-Auth: 1a611a6be5507548
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96909>

T24gRnJpLCBTZXAgMjYsIDIwMDggYXQgMTI6MjAgQU0sIE1pa2xvcyBWYWpuYSA8dm1pa2xvc0Bm
cnVnYWx3YXJlLm9yZz4gd3JvdGU6Cj4gT24gVHVlLCBTZXAgMjMsIDIwMDggYXQgMTE6NDM6MjNQ
TSArMDEwMCwgSm9uYXRoYW4gZGVsIFN0cm90aGVyIDxqb24uZGVsU3Ryb3RoZXJAYmVzdGJlZm9y
ZS50dj4gd3JvdGU6Cj4+IFNoZWxsIHNjcmlwdGluZyBpc24ndCBteSBmb3J0w6ksIHN1Z2dlc3Rp
b25zIGZvciBpbXByb3ZlbWVudHMgd291bGQgYmUKPj4gd2VsY29tZS4KPj4KPj4gK2VsaWYgdGVz
dCAteCAvdXNyL2Jpbi9wbXNldCAmJiAoISAvdXNyL2Jpbi9wbXNldCAtZyBiYXR0IHwgZ3JlcCAt
cSAnQmF0dGVyeSBQb3dlcicgKQo+Cj4gV2hhdCBhYm91dAo+Cj4gK2VsaWYgdGVzdCAteCAvdXNy
L2Jpbi9wbXNldCAmJiAvdXNyL2Jpbi9wbXNldCAtZyBiYXR0IHwgZ3JlcCAtcSAnQUMgUG93ZXIn
Cj4KPiA/Ckkgd2FzIHRyeWluZyB0byBoYW5kbGUgcG1zZXQgcmVwb3J0aW5nIGFueXRoaW5nIG90
aGVyIHRoYW4gQmF0dGVyeQpQb3dlciAoY3VycmVudGx5IGl0IHJlcG9ydHMgZWl0aGVyIEJhdHRl
cnksIFVQUywgb3IgQUMpLCBidXQgdGhpbmtpbmcKYWJvdXQgaXQsIGlmIHlvdSdyZSBvbiBVUFMs
IHlvdSBwcm9iYWJseSBkb24ndCB3YW50IGdpdCBnYyBlYXRpbmcgaW50bwp5b3VyIHJlbWFpbmlu
ZyBwb3dlci4uLgpJJ2xsIHBvc3QgYW4gdXBkYXRlZCB2ZXJzaW9uIG9uIE1vbmRheS4K
