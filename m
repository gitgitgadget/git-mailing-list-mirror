From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] add alloc_ref_with_prefix()
Date: Sat, 18 Oct 2008 14:07:48 +0200
Message-ID: <36ca99e90810180507q2dedf4ck7262239ae91d892f@mail.gmail.com>
References: <48F9A054.4010703@lsrfire.ath.cx>
	 <36ca99e90810180227u367783f6vc3b7af0176f6df06@mail.gmail.com>
	 <48F9AECA.3020606@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Oct 18 14:09:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrAc9-0000J3-8U
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 14:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYJRMHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 08:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYJRMHu
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 08:07:50 -0400
Received: from hs-out-0708.google.com ([64.233.178.248]:21098 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbYJRMHt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 08:07:49 -0400
Received: by hs-out-0708.google.com with SMTP id 4so373779hsl.5
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 05:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sY6WcYNpA+Cz5TcTlBeJ+1AEgtT+YbPOUEkGNMwFf84=;
        b=AaOSNiUeEwl73A9iU/tBx2djijnb8MMNBW/X2ufqSHOn9YeQDNKvb/KJqs+zHjQfld
         Dngn+rJPjhCeAoOb8JoBlUgBkrYF/wH0L5ha4E+1+OBiPjPp5InOarcdmayPx3adNOpS
         hwEic4aV/n3RaCM5N4WWX2aduCoVKi/qNeH/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uBYzwVTONCDkKaro83AHbPv7NaBENHrtwk6bIv2bxcZ2KkdayLCopyVJVw04ezU+86
         A7H1EarurXFU6drEQ/xKfPHb4F1w0QOOn6dJ1INhElgQaUxczWxp1lKX2U50Gv2ri9YN
         guRTtw3nN7FDiEftCahCINVyBF2BpXVJGRVpw=
Received: by 10.150.52.2 with SMTP id z2mr7916277ybz.210.1224331668177;
        Sat, 18 Oct 2008 05:07:48 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Sat, 18 Oct 2008 05:07:48 -0700 (PDT)
In-Reply-To: <48F9AECA.3020606@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98539>

T24gU2F0LCBPY3QgMTgsIDIwMDggYXQgMTE6MzksIFJlbsOpIFNjaGFyZmUgPHJlbmUuc2NoYXJm
ZUBsc3JmaXJlLmF0aC5jeD4gd3JvdGU6Cj4+PiArc3RhdGljIHN0cnVjdCByZWYgKmFsbG9jX3Jl
Zl93aXRoX3ByZWZpeChjb25zdCBjaGFyICpwcmVmaXgsIHNpemVfdCBwcmVmaXhsZW4sCj4+PiAr
ICAgICAgICAgICAgICAgY29uc3QgY2hhciAqbmFtZSkKPj4+ICt7Cj4+PiArICAgICAgIHNpemVf
dCBsZW4gPSBzdHJsZW4obmFtZSk7Cj4+PiArICAgICAgIHN0cnVjdCByZWYgKnJlZiA9IHhjYWxs
b2MoMSwgc2l6ZW9mKHN0cnVjdCByZWYpICsgcHJlZml4bGVuICsgbGVuICsgMSk7Cj4+PiArICAg
ICAgIG1lbWNweShyZWYtPm5hbWUsIHByZWZpeCwgcHJlZml4bGVuKTsKPj4+ICsgICAgICAgbWVt
Y3B5KHJlZi0+bmFtZSArIHByZWZpeGxlbiwgbmFtZSwgbGVuKTsKPj4gV2hlcmUgZG9lcyB5b3Ug
XDAtdGVybWluYXRlIHRoZSBzdHJpbmc/Cj4KPiB4Y2FsbG9jKCkgY2FsbHMgY2FsbG9jKCksIHdo
aWNoIHplcm9lcyB0aGUgbWVtb3J5LgpTbywgeW91IHdyaXRlIHRoZSBtZW1vcnkgcmFuZ2UgdHdp
Y2UsIGp1c3QgZm9yIHRoZSBsYXN0IFwwPwoKQmVydAo+Cj4gUmVuw6kKPgo=
