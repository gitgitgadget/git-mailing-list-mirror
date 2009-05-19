From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 15:33:16 +0200
Message-ID: <36ca99e90905190633l46fff979jecb61d4d0d907815@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519132854.GA9606@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Tue May 19 15:34:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6PSK-0006dl-C8
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 15:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZESNdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 09:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbZESNdU
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 09:33:20 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:57162 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbZESNdT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 09:33:19 -0400
Received: by fxm2 with SMTP id 2so3874535fxm.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BUhP/UQ1V/FxMwGhMToT85I6wDtzVl8OxEkBPmAnjjs=;
        b=sBbyRve2xWc9QIBNlqk3PZFFf8yDDEY1XBQyp0rDaPJTDG9ccnfBHWCNfchnsL/V51
         VOHnHCtenIvV1ECLKgTsuLiN5/bmDulbNxZczpLQatbvZmo3lB8g1p5up2QbF6YkwJB9
         xGqux4P5SAPkP1p+W+keqoK/D2eGehcEZabPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pwupk4crox+hE7JOZExeZAJtirN4nCUupyFEdx2lIR3qtMrzHNnmmMbXtU/CoEWqN9
         dScPOhHG0ypZZnieoOTcOoowGDl/NUGkEgxpMKQ5SsYfX2glzt9W9amV980MeAQFfX7q
         SrxmfufcU3ErWfyrQEkX/lb4U/neS+dRvkjMc=
Received: by 10.204.68.73 with SMTP id u9mr37664bki.192.1242739999627; Tue, 19 
	May 2009 06:33:19 -0700 (PDT)
In-Reply-To: <20090519132854.GA9606@piper.oerlikon.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119527>

T24gVHVlLCBNYXkgMTksIDIwMDkgYXQgMTU6MjgsIG1hcnRpbiBmIGtyYWZmdCA8bWFkZHVja0Bk
ZWJpYW4ub3JnPiB3cm90ZToKPiBhbHNvIHNwcmFjaCBCZXJ0IFdlc2FyZyA8YmVydC53ZXNhcmdA
Z29vZ2xlbWFpbC5jb20+IFsyMDA5LjA1LjE5LjA3NDQgKzAyMDBdOgo+PiBAQCAtNjIsMTIgKzcw
LDMzIEBAIGdpdCBmb3ItZWFjaC1yZWYgcmVmcy90b3AtYmFzZXMgfAo+PiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBjb250aW51ZQo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmaQo+
PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBbIC1uICIkZ3JhcGh2aXoiIF07IHRoZW4KPj4gKwo+
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIFsgLW4gIiRncmFwaHZpel92ZXJi
b3NlIiBdOyB0aGVuCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgdHlwZT0iaGVhZGVyIgo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGxpbmVzPTAKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBlY2hvICJcdFwiJG5hbWVcIiBbIgo+Cj4gWW91IG5lZWQgdG8gcGFzcyAtZSB0byBlY2hv
IGZvciBpdCB0byBob25vdXIgZXNjYXBlIHNlcXVlbmNlcy4gVGhhdAo+IHNob3VsZCBzb2x2ZSBN
aWNoYWVsJ3MgcHJvYmxlbS4gQWx0ZXJuYXRpdmVseSwganVzdCB1c2UgXkkgZGlyZWN0bHkuCkNv
cnJlY3QsIHRoYW5rcy4gTG9va3MgbGlrZSBhIGZlYXR1cmUgZnJvbSBiYXNoIG9yIGRhc2ggdG8g
aG9ub3IKZXNjYXBlIHNlcXVlbmNlcyB3aXRob3V0IC1lJwoKQmVydAo=
