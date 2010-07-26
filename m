From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] config --get --path: check for unset $HOME
Date: Mon, 26 Jul 2010 16:35:56 +0000
Message-ID: <AANLkTimf73aczIILlQ5N_id97kJNmGAUf0QLlMl8my2r@mail.gmail.com>
References: <20100723003456.2976.899.reportbug@dr-wily.mit.edu>
	<20100723012322.GA27113@burratino>
	<20100725085939.GA5281@radis.liafa.jussieu.fr>
	<20100726005111.GA29755@burratino>
	<20100726140756.GH12476@radis.liafa.jussieu.fr>
	<20100726150651.GA4021@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Julien Cristau <jcristau@debian.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 18:36:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdQew-0006VC-Po
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 18:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab0GZQgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 12:36:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37804 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab0GZQgB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 12:36:01 -0400
Received: by iwn7 with SMTP id 7so2918832iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JEmE6KQSbaKU+V1XQtjYg3H4XQAA4LQcnw2Tt8UBhr0=;
        b=ehGMG02bHw6NNqce2fQoVzq/B6J9k01lwRu2t2M7gH60JiHEn7Fkvpymawyb5dkR5e
         WPzy8oJMc6ss5Kakzk+idWLCtis/WTh8MmqRVc370cgU5yIhvjYU5dJrR8f2dtCo15bF
         SYVrmAALSiFUerAXSOe6RmCtH4kTb3VUvLuW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZD8Qo1wlTeFJjEEC3rn9Y4WcS1ClD/Z32LAikfJ8NRfB6OFFwgf0jqnmD5tYGQku2Q
         3axo8fu5omUwsKT9XP+P2DzXXspK53mC4krffae1HB2pwhXPPomSskrmVmUSf5xsch9k
         W3uOjRaGyvBtm15ZXDWeI8Pv6/TNRYwxejmLM=
Received: by 10.231.32.198 with SMTP id e6mr8853188ibd.86.1280162156528; Mon, 
	26 Jul 2010 09:35:56 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 26 Jul 2010 09:35:56 -0700 (PDT)
In-Reply-To: <20100726150651.GA4021@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151854>

T24gTW9uLCBKdWwgMjYsIDIwMTAgYXQgMTU6MDYsIEpvbmF0aGFuIE5pZWRlciA8anJuaWVkZXJA
Z21haWwuY29tPiB3cm90ZToKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNpemVfdCB1c2VybmFt
ZV9sZW4gPSBmaXJzdF9zbGFzaCAtIHVzZXJuYW1lOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKHVzZXJuYW1lX2xlbiA9PSAwKSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBjb25zdCBjaGFyICpob21lID0gZ2V0ZW52KCJIT01FIik7Cj4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIWhvbWUpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIHJldHVybl9udWxsOwo+IMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RyYnVmX2FkZCgmdXNlcl9wYXRoLCBob21lLCBzdHJsZW4o
aG9tZSkpOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIHsKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN0cnVjdCBwYXNzd2QgKnB3ID0gZ2V0cHdfc3RyKHVzZXJu
YW1lLCB1c2VybmFtZV9sZW4pOwoKU2hvdWxkIHdlIG1heWJlIGZhbGwgYmFjayBvbiBjaGVja2lu
ZyBwd19kaXIgaW4gZ2V0cHd1aWQoKSBpZiAkSE9NRSBpc24ndCBzZXQ/Cg==
