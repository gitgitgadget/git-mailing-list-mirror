From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Make boundary characters for --color-words configurable
Date: Sat, 3 May 2008 21:57:59 +0800
Message-ID: <46dff0320805030657w1c9bef0dr346a51b2678c97c0@mail.gmail.com>
References: <20080502143650.GB3079@mithlond.arda.local>
	 <1209774178-26552-1-git-send-email-pkufranky@gmail.com>
	 <481C6707.5060308@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: tlikonen@iki.fi, gitster@pobox.com, git@vger.kernel.org
To: "=?UTF-8?Q?Dirk_S=C3=BCsserott?=" <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat May 03 15:58:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsIGG-0006kN-DM
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 15:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286AbYECN6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 09:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbYECN6B
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 09:58:01 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:4024 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYECN6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 09:58:00 -0400
Received: by an-out-0708.google.com with SMTP id d40so400407and.103
        for <git@vger.kernel.org>; Sat, 03 May 2008 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0ouoc/bEFXz70ivO1qYhMDl1bNVj+fKkuBVI12uQAL4=;
        b=YumcJJK1hRoGQoUFt+0jejupmSXLZRNXQf8FnOybbtCk6HiAtYOZygkhTnUmoXaoMix/b+RXOe+rQhGrQevSx6nscrVlSoJUY+350QgeqhHDDJX722XPKEv3kgbSNP6Kw7jh0zDaI7eKTZEyNNTs6oJUBy8MaLEP5PFkzk3kdto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KoN/14jAp3XYdTeshTvWRPu5vvPdDOjYs1CrhAOF2skS0ahO6y2SeHSexmXeuAloclBOVMrwV6Nenf4Q49gJDSR6uSdAIlJXcP7mLvjVAb72u0x+lmMdXFtslUaxHmmtxTlKzrL4RnzTr8H6cGJLQ3JOH6lMlVOZjF1YBTed3IA=
Received: by 10.100.14.2 with SMTP id 2mr5914559ann.67.1209823079239;
        Sat, 03 May 2008 06:57:59 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 3 May 2008 06:57:59 -0700 (PDT)
In-Reply-To: <481C6707.5060308@dirk.my1.cc>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81086>

T24gU2F0LCBNYXkgMywgMjAwOCBhdCA5OjIyIFBNLCBEaXJrIFPDvHNzZXJvdHQgPG5ld3NsZXR0
ZXJAZGlyay5teTEuY2M+IHdyb3RlOgo+IEhpIFBpbmcsCj4KPiAgSSBoaWdobHkgYXBwcmVjaWF0
ZSB5b3VyIGVmZm9ydCBpbnRvICJkaWZmIC0tY29sb3Itd29yZHMiCj4gIGFuZCBob3BlIGl0IG1h
a2VzIGl0IGludG8gdGhlIHRoZSBuZXh0IHJlbGVhc2UuCgpHbGFkIHRvIGhlYXIgdGhhdC4KCj4K
PiAgSG93ZXZlciwgSSdkIGxpa2UgdG8gYXNrIHlvdSB3aGV0aGVyIHlvdSd2ZSBkb25lIGFueSBy
ZXNlYXJjaAo+ICBpbiBob3cgdG8gdXNlICItLWNvbG9yLXdvcmRzIiBpbiBnaXRrPwoKb2gsIGkg
aGF2bicgdCBldmVuIHVzZWQgZ3RrIHlldC4gSSBkb24ndCBoYXZlIHRoZSBYIGVudmlyb25tZW50
CmJlY2F1c2UgaSB1c2Ugd2luZG93cyBhbmQgdGhlbiB1c2Ugc2VjdXJlY3J0IHRvIHNzaCB0byAg
cmVtb3RlIHNlcnZlci4KCgotLSAKUGluZyBZaW4K
