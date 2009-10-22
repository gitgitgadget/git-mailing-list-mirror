From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] describe: when failing, tell the user about options that 
	work
Date: Thu, 22 Oct 2009 18:40:33 +0200
Message-ID: <81b0412b0910220940n78ddb774i30338147327b198a@mail.gmail.com>
References: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
	 <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 22 18:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N10pV-0002MY-Pu
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 18:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740AbZJVQrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 12:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756215AbZJVQrg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 12:47:36 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39929 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429AbZJVQrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 12:47:35 -0400
Received: by fxm18 with SMTP id 18so9403198fxm.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=flszMq+P09uyGpKtbU7Ep0hNfbEAAmL7khEwLJk3Luo=;
        b=PSOtSILVgtTqOYmbmgCsNcIekEzvyVzphSbRUfaRzKZOfqox5bw+CaNf4wU7VztXx+
         Um2Esrcc21vAgTFMzX22wmNWAVjOAGGJksbUEq3XuwPGl5hK3HcwMF8y/Ff5w86S03V1
         KKeZ3SE7yrgi2HxBCPIcAXIO4Er9ztD4RMWh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F6BxgpyUdOjQR71isvIPXo0BCS/T+K+JdQctwghake7iBqjNG0mC1Tiu2subjwyO0n
         Ox8HWzvRPg7cRX9bWlvK1rew9hVePJmtnmo7l2cdQ5WRIUtatv46Rz40+spW9S0teBgx
         b/DrQZjdr+WeyioHYRaQRQ3LfPyl6cudePi9Q=
Received: by 10.204.154.207 with SMTP id p15mr1444171bkw.202.1256229633468; 
	Thu, 22 Oct 2009 09:40:33 -0700 (PDT)
In-Reply-To: <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131031>

T24gVGh1LCBPY3QgMjIsIDIwMDkgYXQgMTc6NDQsIFRob21hcyBSYXN0IDx0cmFzdEBzdHVkZW50
LmV0aHouY2g+IHdyb3RlOgo+IEBAIC0yNTksNyArMjYwLDE0IEBAIHN0YXRpYyB2b2lkIGRlc2Ny
aWJlKGNvbnN0IGNoYXIgKmFyZywgaW50IGxhc3Rfb25lKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcHJpbnRmKCIlc1xuIiwgZmluZF91bmlxdWVfYWJicmV2KHNoYTEsIGFi
YnJldikpOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOwo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgZGllKCJjYW5u
b3QgZGVzY3JpYmUgJyVzJyIsIHNoYTFfdG9faGV4KHNoYTEpKTsKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGlmICh1bmFubm90YXRlZF9jbnQpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBkaWUoImNhbm5vdCBkZXNjcmliZSAnJXMnIgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgIiB3aXRoIG9ubHlcbmFubm90YXRlZCB0YWdzLiBUcnkgLS10
YWdzLiIsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzaGExX3Rv
X2hleChzaGExKSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBlbHNlCj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaWUoImNhbm5vdCBkZXNjcmliZSAnJXMnIgo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgIiB3aXRoIHRhZ3NcblRyeSAtLWFs
d2F5cywgb3IgY3JlYXRlIHNvbWUgdGFncy4iLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgc2hhMV90b19oZXgoc2hhMSkpOwoKVGhlc2UgYXJlIHF1aXRlIHZlcmJv
c2UuIENvdWxkIHRoZXkgYmUgY29uZGl0aW9uYWwgb24gc29tZXRoaW5nIGxpa2UKYWR2aWNlLmRl
c2NyaWJlSGludHM/Cg==
