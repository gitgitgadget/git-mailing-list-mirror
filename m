From: "=?ISO-8859-2?Q?=A3ukasz_Lew?=" <lukasz.lew@gmail.com>
Subject: Re: How to maintain private/secret/confidential branch.
Date: Sun, 14 Dec 2008 16:38:35 +0100
Message-ID: <c55009e70812140738l8b51adax77cc6e507971554e@mail.gmail.com>
References: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com>
	 <20081214145518.GA26380@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Nick Andrew" <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Sun Dec 14 16:39:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBt4W-0003wT-Ls
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 16:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbYLNPii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 10:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYLNPii
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 10:38:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:44108 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbYLNPih (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 10:38:37 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1000541fgg.17
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 07:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uUaejRUE6rgqaK8rO+va+RQNMaBuAteHZDRfH7l31to=;
        b=UWrABSVloqCogYNqfZxw6s1uSrBviC8M7Dk0cQsy5MyEFBpoIq1ODJln9HPL1iZLY6
         YhocTdlqjP5Hr9YTpuGKy01rCdHMLQolYH9KINixxNP0h85h++l0UXOOhW9bBMo9b7Zy
         ZmzyVFGgCeR6sQKyJuzn7GXasqEDsNuL0jrGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hh/FW+ikTkp9hg4GHR6q/iXRUFr2gURot9RyKtydP2rTJg4HdCxvxqgyfgdJo6ksk4
         5mzTker7fXdGPk7ytsx/WeGJvgsZE6D+JIob98HAv5FZm2bEjS8tHHOiA6sV2Ydm5JPh
         XZvrCEEx/wDt7D4+ZYu8r8HQVbr6xYmIlgdcM=
Received: by 10.86.50.6 with SMTP id x6mr3196842fgx.71.1229269115783;
        Sun, 14 Dec 2008 07:38:35 -0800 (PST)
Received: by 10.86.93.2 with HTTP; Sun, 14 Dec 2008 07:38:35 -0800 (PST)
In-Reply-To: <20081214145518.GA26380@mail.local.tull.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103087>

VGhhbmtzIE5pY2ssIHRoYXRzIHJlYWxseSBoZWxwZnVsIChhbmQgc3VycHJpc2luZ2x5IHNpbXBs
ZSkuCkkgaGF2ZSBhIGNvdXBsZSBtb3JlIHF1ZXN0aW9uczoKCk9uIFN1biwgRGVjIDE0LCAyMDA4
IGF0IDE1OjU1LCBOaWNrIEFuZHJldyA8bmlja0BuaWNrLWFuZHJldy5uZXQ+IHdyb3RlOgo+IE9u
IFN1biwgRGVjIDE0LCAyMDA4IGF0IDAyOjQ5OjUwUE0gKzAxMDAsIKN1a2FzeiBMZXcgd3JvdGU6
Cj4+IEkgZG9uJ3Qga25vdyBob3cgdG8gbWFrZSBzdWNoIGEgc2NlbmFyaW8gd29yazoKPj4gLSB0
d28gcmVwb3NpdG9yaWVzOiBwdWIsIHByaXYKPj4gLSBwcml2IGlzIGNsb25lL2JyYW5jaCBvZiBw
dWIKPj4gLSB0aGVyZSBpcyBzb21lIGNvbnN0YW50IGRldmVsb3BlbWVudCBib3RoIGluIHB1YiBh
bmQgcHJpdgo+PiAtIHRoZXJlIGFyZSByZWd1bGFyIHN5bmNzIHdpdGggcHViIGluIHByaXYKPj4K
Pj4gUHJvYmxlbToKPj4gT2NjYXNpb25hbGx5IEkgd2FudCB0byBwdXNoIHNvbWUgY2hhbmdlcyBm
cm9tIHByaXYgdG8gcHViLgo+PiBUaGVuIGFmdGVyIHN5bmNpbmcgd2l0aCBwdWIgSSB3YW50IHRv
IGdldCBhcyBmZXcgY29uZmxpY3RzIGFzIHBvc3NpYmxlLgo+Pgo+PiBJcyBpdCBwb3NzaWJsZSB0
byBkbyB3aXRoIGdpdD8KPgo+IEdpdCBjYW4gZG8gYWxtb3N0IGFueXRoaW5nLiBPbmUgc2hvdWxk
IGluc3RlYWQgYXNrICJIb3cgdG8gZG8gdGhpcwo+IHdpdGggZ2l0PyIgOi0pCgpTbyBJJ3ZlIGhl
YXJkLCBidXQgbm90IHlldCBleHBlcmllbmNlZCBpdCBteXNlbGYuIEknbSB0aHJpbGxlZCB0byB0
cnkuCgo+Cj4gSWYgSSB1bmRlcnN0YW5kIHlvdXIgcHJvYmxlbSwgeW91IGNvdWxkIHNvbHZlIGl0
IHdpdGggZ2l0IGNoZXJyeS1waWNrCj4gYW5kIHJlYmFzZS4gT24gcHJpdiwgbWFrZSBhIGZvci1w
dWJsaWMgYnJhbmNoIGZyb20gYSBwdWIgYnJhbmNoLiBUaGVuCj4gY2hlcnJ5LXBpY2sgdGhlIGNv
bW1pdHMgeW91IHdhbnQgZnJvbSB5b3VyIHByaXZhdGUgYnJhbmNoIGludG8gdGhlCj4gZm9yLXB1
YmxpYyBicmFuY2guCgpUaGF0IGFsbW9zdCB3b3Jrcy4gQ2FuIEkgc29tZWhvdyBzcGxpdCBleGlz
dGluZyBjb21taXRzIGp1c3QgbGlrZSBpbiBnaXQtYWRkIC1wPwoKPiBQdXNoIHlvdXIgZm9yLXB1
YmxpYyBicmFuY2ggdG8gcHViLAo+IHRoZW4gcmViYXNlIHlvdXIgcHJpdmF0ZSBicmFuY2guCgpS
ZWJhc2UgdG8gdGhlIHRpcCBvZiBtYXN0ZXI/IElzIGl0IG5lZWRlZD8gSWUuIGNoZXJyeS1waWNr
IGRvZXMgbm90CnJlbW92ZSB0aGUgcGF0Y2ggZnJvbQp0aGUgbWFzdGVyIGluIHByaXYuCgpJZiBJ
IG5vdyBwdWxsIGZyb20gcHViLCBJIHdpbGwgZ2V0IHRoZSBzYW1lIGNoYW5nZSBhbmQgaXQgbWVy
ZWdlcyBuaWNlbHkgOkQKCkNhbiBJIGdldCBhd2F5IHdpdGhvdXQgY3JlYXRpbmcgZm9yX3B1YiBi
cmFuY2g/IG1heWJlIGNoZXJyeSBwaWNrIGluCnB1YiBmcm9tIHByaXYgc29tZWhvdz8KCj4KPiBO
aWNrLgo+Cg==
