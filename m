From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 03/10] Make get_git_dir() and 'git rev-parse --git-dir' absolute path
Date: Tue, 11 Mar 2008 22:06:23 +0700
Message-ID: <fcaeb9bf0803110806u43fbd8b8v3ec2adf84fa1cd5e@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103348.GA8929@laptop>
	 <alpine.LSU.1.00.0803111420080.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:09:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ65j-0001uC-8u
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:08:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753980AbYCKPGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbYCKPGx
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:06:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:34685 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbYCKPGw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:06:52 -0400
Received: by ug-out-1314.google.com with SMTP id z38so15850ugc.16
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+87HdC12/peFggq1fp4rEuhk4qhx9LgW79UiBOV76wg=;
        b=fS/k+RpUi0jq1axmcwqraOZqTVrtbOUVh8XaJKtbw5eQfoOCkgEzgPuKjc75y2zEE/cajrEpLfxn1qCmSUs8GPi88KGfLLKTwpwK5Sr0m4EcymfjKKILr5C5Cl0TMTuHRYBzcdye2wDWUaxK9tQ6KWaxKuDbAI1qzNtYQmJZCNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kSOO34LVUV0ATyu4tCdWB76BpeNqV1mGG5r4G9pq3tIE01jAeGpG54LXyW1GQBzmZEjQk4maqPpeBgO30B83mPnQBeJwo2at1fxOZZqZ2aPehNfcG7pEsInso0LmpRXdjCFNbsaRffXGVZ5N200ZYGHt0hRxV5i632Skdph24+s=
Received: by 10.66.220.17 with SMTP id s17mr27751ugg.20.1205248010312;
        Tue, 11 Mar 2008 08:06:50 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 08:06:23 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111420080.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76863>

T24gVHVlLCBNYXIgMTEsIDIwMDggYXQgODoyMCBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo8Sm9o
YW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gU3VuLCAyIE1h
ciAyMDA4LCBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IHdyb3RlOgo+Cj4gID4KPiAgPiBTaWdu
ZWQtb2ZmLWJ5OiBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IDxwY2xvdWRzQGdtYWlsLmNvbT4K
Pgo+ICBJIGRvIG5vdCBsaWtlIHRoaXMgY2hhbmdlLiAgSXQgaXMgSU1PIGNvbXBsZXRlbHkgdW5u
ZWNlc3NhcnksIGFuZCBtaWdodAo+ICBicmVhayBhc3N1bXB0aW9ucy4KCkl0IGNvdWxkLiBBbmQg
SSB0cmllZCBteSBiZXN0IHRvIG1ha2Ugc3VyZSBpdCBkaWQgbm90IGJyZWFrIGFueXRoaW5nLgpJ
dCBpcyBhbHNvIGRvY3VtZW50ZWQgKGlmIG5vdCBjbGVhcmx5LCBJIGNhbiBjb3JyZWN0IHRoZSBk
b2N1bWVudCkuCldoaWxlIGl0J3Mgbm90IHJlYWxseSBuZWNlc3NhcnksIGl0IHdvdWxkIGJlIElN
SE8gYSBnb29kIGNoYW5nZSBhcyB5b3UKd291bGQgbm90IGhhdmUgdG8gcmVseSBvbiBgY3dkYCBh
bnltb3JlICh0aGF0IHdvdWxkIG1lYW4gd2hldGhlcgptb3ZpbmcgY3dkIGJ5IHByZWZpeCBvciBu
b3Qgd291bGQgbm8gbG9uZ2VyIG1hdHRlcikuCgo+ICBDaWFvLAo+ICBEc2Nobwo+Ci0tIApEdXkK
