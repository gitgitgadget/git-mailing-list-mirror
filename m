From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH v2 2/3] git-core: Support retrieving passwords with 
	GIT_ASKPASS
Date: Fri, 26 Feb 2010 10:17:44 +0800
Message-ID: <1976ea661002251817v12f04314vc32fe7924f31c070@mail.gmail.com>
References: <1267143154-5020-1-git-send-email-lznuaa@gmail.com>
	 <20100226005020.GR12429@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Feb 26 03:17:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkpm3-00021f-BI
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 03:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935001Ab0BZCRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 21:17:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37376 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934980Ab0BZCRp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 21:17:45 -0500
Received: by gyh20 with SMTP id 20so1597318gyh.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 18:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e3ilrfjEbdLRj4RIK0//LPPS559dd+EW5n9NoOkmR9o=;
        b=JsMWK9fwJ5qsZ+suBI5ql4zDK05fFnkSAh00tKR2eGMDv1rWDVuCu9dm5ueC9RyK2a
         EFQo/dY1nW0Cw2XBzJKlAm3LGkFlekxWsv9teO1e5HQum5pZF1qyygfVfw+DpkgLMg76
         zfSo6jK61Dq/0C/gfmgV9lMzWfwvkNrKpH3qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QM8PiROOyzhHHxa7DBplmJZ1sL1n8M3Ntom745wgRByziMbYd18EWNJuKM0VKdGVSg
         8KI035cV0Vqpk6+ExH/IRdz93Q8phrnrOCbnk234+GA5E3nyoL9JequB0MYvd05PfsT+
         MExWsBOpCOy1UZeJT3HpxoDirg1gEBob08Dj8=
Received: by 10.151.29.8 with SMTP id g8mr902955ybj.74.1267150664134; Thu, 25 
	Feb 2010 18:17:44 -0800 (PST)
In-Reply-To: <20100226005020.GR12429@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141089>

PiBBY2NvcmRpbmcgdG8gRG9jdW1lbnRhdGlvbi9Db2RpbmdHdWlkZWxpbmVzLCB0aGlzIHdvdWxk
IGJlOgo+Cj4KPiCgIKAgoCCgIKAgoCCgIKBmb3IgKGkgPSAwOyBpIDwgYnVmZmVyLmxlbjsgaSsr
KQo+IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgaWYgKGJ1ZmZlci5idWZbaV0gPT0gJ1xuJyB8fCBi
dWZmZXIuYnVmW2ldID09ICdccicpIHsKPiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
YnVmZmVyLmJ1ZltpXSA9ICdcMCc7Cj4goCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoGJ1
ZmZlci5sZW4gPSBpOwo+IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgfQo+IKAgoCCgIKAgoCCgIKAg
oHJldHVybiBzdHJidWZfZGV0YWNoKCZidWZmZXIsIE5VTEwpOwo+Cj4goCCgIKAgoH0gZWxzZQo+
IKAgoCCgIKAgoCCgIKAgoHJldHVybiBnZXRwYXNzKHByb21wdCk7Cj4KCk9rYXksIEkgd2lsbCBj
aGFuZ2UgaXQuCg==
