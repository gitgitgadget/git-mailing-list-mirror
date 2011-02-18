From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Fri, 18 Feb 2011 10:56:37 +0700
Message-ID: <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org> <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 04:58:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqHU4-0001Y6-5T
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 04:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063Ab1BRD6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 22:58:13 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38799 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997Ab1BRD6N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 22:58:13 -0500
Received: by wyb28 with SMTP id 28so3272459wyb.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 19:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=rC1Zun9YHkrVCBJfUt40Zdm68k5IKIA44Vtu7buiLuA=;
        b=dCBzmFOThG3R0QfxOLAYY9bQlIfwqABPvKdV03q6TM4dPf4YbQegHtKg6XXqeW8/B6
         H/2owuXiqn3mGWV5XR7R5u3R55h6KXE9pHq6NtITwX2HV1vHWnXPMQ5ju7tOCmMZXJz1
         KOGrWexeB0ZK1MQhayDw0CZVkQddMxV/US/c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ptHqOaLXa9I18pI3GkXfCC6KlfwK/IqhHuICe9h7A2zXKAg59K17qroMuFWxVRNKDW
         ++SzFp3Qb8bsg3kJzLhNSN1hBgSeTxEJpLOJo0mfPJeR0DffrMH+IcXdTuIbFJXHR3dG
         NZV6orchBWEsYaABdTvEvYjAef6EEwSXbp0MA=
Received: by 10.216.89.71 with SMTP id b49mr191283wef.28.1298001427381; Thu,
 17 Feb 2011 19:57:07 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Thu, 17 Feb 2011 19:56:37 -0800 (PST)
In-Reply-To: <20110218022701.GA23435@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167160>

MjAxMS8yLzE4IEpvbmF0aGFuIE5pZWRlciA8anJuaWVkZXJAZ21haWwuY29tPjoKPiBIaSwKPgo+
IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgd3JvdGU6Cj4KPj4gwqAuZ2l0aWdub3JlIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHwg
wqAgMTkgLS0tLS0tLS0tLS0tCj4+IMKgTWFrZWZpbGUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfCDCoCAzMCArKysrKysrKysr
LS0tLS0tLS0tLQo+PiDCoHQvaGVscGVyLy5naXRpZ25vcmUgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8IMKgIDE5ICsrKysrKysrKysrKwo+IFsuLi5dCj4+
IMKgMjQgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pCj4K
PiBIZXJlJ3MgYSB2YXJpYXRpb24gb24gdGhlIHRoZW1lIHRoYXQganVzdCBtb3ZlcyBzb3VyY2Ug
YW5kIC5vIGZpbGVzCj4gKGxlYXZpbmcgcXVlc3Rpb25zIGFib3V0IGhvdyB0byBjb3BlIHdpdGgg
YnJlYWtpbmcgbXVzY2xlIG1lbW9yeSBmb3IKPiB0aGUgcmVzdWx0aW5nIGV4ZWN1dGFibGVzIGZv
ciBsYXRlcikuIMKgV2hhdCBkbyB5b3UgdGhpbms/CgpFeHRlcm5hbCBjb21tYW5kcyBhcmUgbm93
IG1vcmUgdmlzaWJsZS4gTmljZS4KLS0gCkR1eQo=
