From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 01/12] git-grep: read config
Date: Fri, 25 Jul 2008 01:45:58 +0700
Message-ID: <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
References: <20080723145535.GA29053@laptop>
	 <20080724171519.GA21043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:47:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5q8-0003xn-O2
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbYGXSqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYGXSqA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:46:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:48279 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbYGXSqA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:46:00 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1471615fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=vYJfsm8bMWa7Bsdn4nlIb0oY0AY9MYH8Qm8DozdcO4E=;
        b=ig4NW0S/8gOXbByRrtDrnroAH3UXq5XNd8hIpZgBnfffvTm71j+Bzev8wSiJ859XNj
         xivgDzIcitlSdLwRZpGEIaP7QP8UDAK66pNHJwUguiZSR0jIPUQiFheYEcC02lEm1L9C
         8DnnlV7E6YpRXDk2R3od8TAWVbMO8n302JKRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kHVlpvazUxHJYjLHmx3kp1mlOCZZYwxalOqGGhlDqyNh99Cwri4rSTC0yxVEHNPbkA
         ymidsn5e4xe3OsPsw92Z3OhWRW9imrtBkt1B2vwSazZ+t/KJiaHbL9oK1cWpVI8d5cnI
         SyFIABabh2VcLFdKln39bISrZ5wOiGDpIElMg=
Received: by 10.86.76.20 with SMTP id y20mr1131614fga.41.1216925158541;
        Thu, 24 Jul 2008 11:45:58 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 11:45:58 -0700 (PDT)
In-Reply-To: <20080724171519.GA21043@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89935>

T24gNy8yNS8wOCwgSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0PiB3cm90ZToKPiBPbiBXZWQsIEp1
bCAyMywgMjAwOCBhdCAwOTo1NTozNVBNICswNzAwLCBOZ3V5ZW4gVGhhaSBOZ29jIER1eSB3cm90
ZToKPgo+ICA+Cj4gID4gU2lnbmVkLW9mZi1ieTogTmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8
cGNsb3Vkc0BnbWFpbC5jb20+Cj4KPgo+IFRoZSBjb21taXQgbWVzc2FnZSBpcyBhIGJpdCBsYWNr
aW5nLi4ud2hhdCBjb25maWcgYXJlIHdlIGludGVyZXN0ZWQgaW4/Cgpjb3JlLnNwYXJzZWNoZWNr
b3V0LCBidXQgSSB3aWxsIHByb2JhYmx5IHN0YXkgYXdheSBmcm9tIGNvbmZpZy4KCi0tIApEdXkK
