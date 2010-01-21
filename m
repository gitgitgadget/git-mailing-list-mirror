From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv11 12/20] Builtin-ify git-notes
Date: Thu, 21 Jan 2010 10:28:33 -0800
Message-ID: <780e0a6b1001211028t35a19e2la6bb92f8ba94a689@mail.gmail.com>
References: <1263762277-31419-1-git-send-email-johan@herland.net> 
	<1263762277-31419-13-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 19:29:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY1me-0006mt-DU
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 19:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753361Ab0AUS2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 13:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986Ab0AUS2y
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 13:28:54 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:50197 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab0AUS2y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 13:28:54 -0500
Received: by pwi21 with SMTP id 21so162143pwi.21
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 10:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4JPQH7lplBDyNdmosKTWZE71tyMYpnIpAOVEcCHoimk=;
        b=W/b3B0wfZsFaj0yMrUFSKMztF8Eg1Q3Bjj4Ni6uGrUfN4oXr4S6I+fPbA5HvhplKQ5
         VJLBX38jtX4jf1KkFaOZfjT3tazpGIF1P8YbQ39HvUMn4TcA9nm/5fIGNaL5D058GkZk
         yslhbV7QANeBW9uzxF+znFfTHrV3PCht6qL4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bI+sBJoD2sUrQxcCyitmqqkCQstGnEb/WC4+Q+qGqn6Atkz04i8QH4Fmys89450MTz
         w1POB78okXYDzHX7o7jX2IWBszGfY9XqkDdvZJqJvPR73ezKcBn/oZHc3y9b1/9oVZvn
         DOD4YtfJZR8ASGqZkjfLfjPbGR23yP4wF7VAs=
Received: by 10.142.4.11 with SMTP id 11mr1226990wfd.128.1264098533115; Thu, 
	21 Jan 2010 10:28:53 -0800 (PST)
In-Reply-To: <1263762277-31419-13-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137683>

T24gU3VuLCBKYW4gMTcsIDIwMTAgYXQgMTowNCBQTSwgSm9oYW4gSGVybGFuZCA8am9oYW5AaGVy
bGFuZC5uZXQ+IHdyb3RlOgo+ICsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChsYXVuY2hf
ZWRpdG9yKHBhdGgsIGJ1ZiwgTlVMTCkpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGZwcmludGYoc3RkZXJyLCAiUGxlYXNlIHN1cHBseSB0aGUgbm90ZSBjb250ZW50cyB1
c2luZyIKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICIg
ZWl0aGVyIC1tIG9yIC1GIG9wdGlvbi5cbiIpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgZXhpdCgxKTsKCmRpZSgpPwo=
