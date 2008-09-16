From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Tue, 16 Sep 2008 20:13:33 +0700
Message-ID: <fcaeb9bf0809160613w3aed3db4g8ce2cb8cfc92818a@mail.gmail.com>
References: <1221397685-27715-1-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-9-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-10-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-11-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-12-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-13-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-14-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-15-git-send-email-pclouds@gmail.com>
	 <1221397685-27715-16-git-send-email-pclouds@gmail.com>
	 <48CF879F.6020006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 15:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfaOD-0000YE-2a
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 15:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbYIPNNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 09:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbYIPNNg
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 09:13:36 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:18066 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbYIPNNg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 09:13:36 -0400
Received: by yx-out-2324.google.com with SMTP id 8so785932yxm.1
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pXSjHLyHjetyjTtRY5rxlIqP0NgMvDglZQDd73I9GGA=;
        b=ikDUMAJWPno4UfrC1EzbVCV0Or8Y3tkBdi6gs/tQNtB7MpFDtpxeWkDcuLgPKc3z2p
         dSN9nFd4W+MC3gQka28qhxTnXL32Ck/dx58z+Wnd6upw85L0gt22ja0qXJoRSrD9es1m
         XUKA3SddNQGn1UQywe5xbPjNJASUOeyEPLz0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PkSJPgctNEQYXfIMULDEU8Oxb+NeqDRc55egS217Fonk0KuA34ir83E+o1pCQgKLkB
         wC1o6s2PgH6GaKWQ+u1zvTw+vQx7SrRwzoipxjKupC53drPU7zCY2S8Nln4XMwwvMFwS
         LY/k+joTLd8x1k2/FycoMeCpXMBTPi4dgd2SU=
Received: by 10.86.93.19 with SMTP id q19mr769017fgb.4.1221570813858;
        Tue, 16 Sep 2008 06:13:33 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Tue, 16 Sep 2008 06:13:33 -0700 (PDT)
In-Reply-To: <48CF879F.6020006@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96000>

T24gOS8xNi8wOCwgSm9oYW5uZXMgU2l4dCA8ai5zaXh0QHZpc2NvdmVyeS5uZXQ+IHdyb3RlOgo+
IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgc2NocmllYjoKPgo+ID4gKy0tZnVsbDo6Cj4gID4g
KyAgICAgUXVpdCBuYXJyb3cgY2hlY2tvdXQgbW9kZS4gUmV0dXJuIHRvIGZ1bGwgY2hlY2tvdXQu
Cj4gID4gKwo+ICA+ICstLXBhdGg9PG5hcnJvd19zcGVjPjo6Cj4gID4gKyAgICAgUmUtYXBwbHkg
bmV3IG5hcnJvdyBzcGVjIG9uIGN1cnJlbnQgd29ya2luZyBkaXJlY3RvcnkgdG8KPiAgPiArICAg
ICBmb3JtIG5ldyBjaGVja291dCBhcmVhLgo+ICA+ICsKPiAgPiArLS1hZGQtcGF0aD08bmFycm93
X3NwZWM+OjoKPiAgPiArICAgICBDaGVja291dCBtb3JlIGFyZWFzIHNwZWNpZmllZCBieSBuYXJy
b3cgc3BlYyB0byBjdXJyZW50Cj4gID4gKyAgICAgY2hlY2tvdXQgYXJlYS4KPiAgPiArCj4gID4g
Ky0tcmVtb3ZlLXBhdGg9PG5hcnJvd19zcGVjPjo6Cj4gID4gKyAgICAgTmFycm93IGNoZWNrb3V0
IGFyZWEgYnkgcmVtb3ZpbmcgZmlsZXMgc3BlY2lmaWVkIGJ5IG5hcnJvdyBzcGVjCj4gID4gKyAg
ICAgZnJvbSBjdXJyZW50IGNoZWNrb3V0IGFyZWEuIFRoaXMgb3BlcmF0aW9uIHdpbGwgZmFpbCBp
ZiB0aGVyZQo+ICA+ICsgICAgIGlzIHVubWVyZ2VkIG9yIG1vZGlmaWVkIGZpbGVzIGluIHRoZSBy
ZW1vdmluZyBhcmVhcy4KPgo+Cj4gVGhlIG9wdGlvbiAtLXBhdGggaXMgbmFtZWQgYSBiaXQgdG9v
IGdlbmVyaWMgZm9yIG15IHRhc3RlLiBIb3cgYWJvdXQKPiAgLS1uYXJyb3c9Li4uPwoKLS1uYXJy
b3cgb3IgLS1uYXJyb3ctdGVtcGxhdGUgKG9yIC0tY2hlY2tvdXQtdGVtcGxhdGU/KSBzZWVtcyBn
b29kLgoKPiBBbmQgaG93IHdvdWxkIHlvdSBsaWtlIC0tbW9yZT0gaW5zdGVhZCBvZiAtLWFkZC1w
YXRoPSBhbmQKPiAgLS1sZXNzPSBpbnN0ZWFkIG9mIC0tcmVtb3ZlLXBhdGg9PwoKTm93IHRoZXNl
IC0tbW9yZS8tLWxlc3MgYXJlIHRvbyBnZW5lcmljIHRvIG1lIDspCgo+IEkgZG8gdGhpbmsgdGhh
dCAtLWZ1bGwgaXMgT0suCj4KPiAgLS0gSGFubmVzCj4KPgoKCi0tIApEdXkK
