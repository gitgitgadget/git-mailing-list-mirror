From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 09:45:34 -0400
Message-ID: <76718490803230645k13471472sc99932563b0239da@mail.gmail.com>
References: <47E65AF5.4060708@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?UTF-8?Q?Dirk_S=C3=BCsserott?=" <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 23 14:46:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdQWe-0000n2-4s
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 14:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbYCWNpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 09:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757541AbYCWNpf
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 09:45:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:45892 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757002AbYCWNpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 09:45:34 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2848865wah.23
        for <git@vger.kernel.org>; Sun, 23 Mar 2008 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rx2hR3uFCC2mvtxl3wHEurlyZpQJ/cHF5Rm//eueGQM=;
        b=kkwWeEIMVgRj9feWlxdzvgULb2EwIOdQw8VuC0rVhh+BXzYO26lZpPHZ2Dcf0Gvu4jGgKc3BJAjmTtw19Fz/NAzKdccW9TLKBfbgn2exCDzjIZQkiVt1JOM0huSsn5CpajSagkQSSVLqeHHXOSbhdJa/1DIeFzotHZLH29EsjeU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QVMkvpTidqguypM5ad1jzctVB6Bc49UTZve4c49U9xVYYeEBsjiLMWxWB85MbeyRbQ1Rf3ETOau864yr5zPFviesn2vJUutPHOZoHNzAmjthAI1HnNHszTXrY55HRD/IVBqDR3CoBd4rgdrX4iv3MYDkhlnpgkzJJdaMlxLCcfs=
Received: by 10.114.26.18 with SMTP id 18mr9641249waz.130.1206279934482;
        Sun, 23 Mar 2008 06:45:34 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Sun, 23 Mar 2008 06:45:34 -0700 (PDT)
In-Reply-To: <47E65AF5.4060708@dirk.my1.cc>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77895>

T24gU3VuLCBNYXIgMjMsIDIwMDggYXQgOToyOCBBTSwgRGlyayBTw7xzc2Vyb3R0IDxuZXdzbGV0
dGVyQGRpcmsubXkxLmNjPiB3cm90ZToKPiBIaSwgSSd2ZSBhIHF1ZXN0aW9uIGNvbmNlcm5pbmcg
Z2l0IGNvbmZpZyBhbmQgdGhlIGFsaWFzIHRoaW5ncy4KPiAgSSdkIGxpa2UgdG8gY3JlYXRlIGFu
IGFsaWFzICdhdGFnJyB0aGF0IGNyZWF0ZXMgYW4gYW5ub3RhdGVkCj4gIHRhZyB3aXRoIHRoZSBt
ZXNzYWdlIGJlaW5nIHRoZSBzYW1lIGFzIHRoZSB0YWcuIFVzdWFsbHkgSSBjcmVhdGUKPiAgYW5u
b3RhdGVkIHRhZ3MgbGlrZSB0aGlzOgo+Cj4gICQgZ2l0IHRhZyAtYSAtbSAibXl0YWciIG15dGFn
Cj4KPiAgKEJUVzogSXQncyBub3QgZG9jdW1lbnRlZCwgYnV0IEkgaGF2ZSB0aGUgaW1wcmVzc2lv
biB0aGF0Cj4gIHRoZSAnLWEnIHN3aXRjaCBpcyBpbXBsaWNpdGVseSBhZGRlZCB3aGVuIHRoZSAn
LW0nIHN3aXRjaAo+ICBpcyBwcmVzZW50LiBJcyB0aGF0IHRydWU/KQo+Cj4gIEknZCBsaWtlIHRv
IGhhdmUgYW4gYWxpYXMgbGlrZSB0aGlzOgo+Cj4gIFthbGlhc10KPiAgICAgYXRhZyA9IHRhZyAt
YSAtbSAiJDEiCj4KPiAgU28gdGhhdCBJIGNhbiBzaW1wbHkgY2FsbAo+Cj4gICQgZ2l0IGF0YWcg
bXl0YWcKPgo+ICBJcyBpdCBwb3NzaWJsZSB0byBwYXNzIHBhcmFtZXRlcnMgdG8gdGhlIGFsaWFz
IGRlZmluaXRpb24/Cj4gIFdpdGggdGhlIGRlZmluaXRpb24gYWJvdmUgSSBnb3QgYSB0YWcgd2l0
aCBtZXNzYWdlICIkMSIuCgphdGFnID0gIWdpdCB0YWcgLWEgLW0gIiQxIgoKai4K
