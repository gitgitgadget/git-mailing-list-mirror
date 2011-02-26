From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 64/73] gettextize: git-describe basic messages
Date: Sat, 26 Feb 2011 14:16:36 +0100
Message-ID: <AANLkTimui6T5b8w1wXgVsNu5y0OA9S_UMofs2K=Tx-ZW@mail.gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
	<1298418152-27789-65-git-send-email-avarab@gmail.com>
	<201102261055.58539.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 14:16:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtK0q-0002KU-0t
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 14:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab1BZNQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 08:16:38 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60853 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab1BZNQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 08:16:37 -0500
Received: by fxm17 with SMTP id 17so2545681fxm.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 05:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Bd+VVy88o4SRzX2+3kli/1WJo/CVqQu6cQgqsf9f9e8=;
        b=wDPI9qUHxI60WSx44bjCM8eQ+/WwHBqO1bJov8RnVL7Hw+3ETtP7fbuDpU2CHnF/Ub
         BaJoAO31n8+laA5/D25DEpNi/ySEfKuAZdbHDS9lAtU+PCpTUeXCGKr6v9KxDz6hvvHp
         Lf4Eu+6pA81mLCgShV6zB1f1vo5tfrdo37gRE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dDxKnconwc40xUTORdBy6NKPqsLeJY6E6o3kpROTL4YH2anzWmB3KDn9lyJfvru2k1
         yF821B0IWVozPLBprkpVNx3/jOqXPgvENm7thwdZlCN+KZZOGZZ7+PrVw1Mlr1fFxHRv
         LvLRQVLxjoeFcSkTQ4nrbL6JlUE4eN1X5GFes=
Received: by 10.223.81.76 with SMTP id w12mr4069993fak.26.1298726196510; Sat,
 26 Feb 2011 05:16:36 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Sat, 26 Feb 2011 05:16:36 -0800 (PST)
In-Reply-To: <201102261055.58539.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167982>

T24gU2F0LCBGZWIgMjYsIDIwMTEgYXQgMTA6NTUsIEpha3ViIE5hcmVic2tpIDxqbmFyZWJAZ21h
aWwuY29tPiB3cm90ZToKPiBPbiBXZWQsIDIzIEZlYiAyMDExLCDDhnZhciBBcm5masO2csOwIEJq
YXJtYXNvbiB3cm90ZToKPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChz
dHJjbXAobi0+dGFnLT50YWcsIGFsbCA/IG4tPnBhdGggKyA1IDogbi0+cGF0aCkpCj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2FybmluZygidGFnICcl
cycgaXMgcmVhbGx5ICclcycgaGVyZSIsIG4tPnRhZy0+dGFnLCBuLT5wYXRoKTsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3YXJuaW5nKF8oInRhZyAn
JXMnIGlzIHJlYWxseSAnJXMnIGhlcmUiKSwgbi0+dGFnLT50YWcsIG4tPnBhdGgpOwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG4tPm5hbWVfY2hlY2tlZCA9IDE7Cj4+IMKgwqDC
oMKgwqDCoMKgwqB9Cj4KPiBEb24ndCB3ZSBuZWVkIHRvIHVzZSBvcmRlciBub3RhdGlvbiB0byBi
ZSBhYmxlIHRvIGNoYW5nZSBvcmRlciBvZiB0aG9zZQo+IHR3byBwYXJhbWV0ZXJzLCBpLmUuIHVz
ZQo+Cj4gwqArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHdhcm5pbmcoXygidGFn
ICclMSRzJyBpcyByZWFsbHkgJyUyJHMnIGhlcmUiKSwgbi0+dGFnLT50YWcsIG4tPnBhdGgpOwo+
Cj4gUGVyaGFwcyBhbHNvIHNvbWUgY29tbWVudCBmb3IgdHJhbnNsYXRvcnMgZGVzY3JpYmluZyBw
bGFjZWhvbGRlcnM/CgpObywgdGhlIG9yaWdpbmFsIHN0cmluZyBkb2Vzbid0IG5lZWQgdGhvc2Uu
IEJ1dCB0aGUgdHJhbnNsYXRvcnMgY2FuCmluc2VydCB0aGVtIGluIHRoZWlyIFBPIGZpbGUgaWYg
dGhleSB3YW50Lgo=
