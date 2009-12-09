From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: PATCH/RFC] gitweb.js: Workaround for IE8 bug
Date: Tue, 08 Dec 2009 16:08:58 -0800
Message-ID: <1260317338.5658.101.camel@swboyd-laptop>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com>
	 <200912081729.11890.jnareb@gmail.com>
	 <1260309382.5658.41.camel@swboyd-laptop>
	 <200912082332.29925.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 01:09:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIA78-0003Uy-KI
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 01:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966948AbZLIAI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 19:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966789AbZLIAIz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 19:08:55 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:35424 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966786AbZLIAIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 19:08:54 -0500
Received: by pzk1 with SMTP id 1so2539210pzk.33
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 16:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=W9Pt9pabBDFSkQT/hL9Y25v18duZHZd2xDucB1M+yR8=;
        b=wU5CSE20u7rfksDJhJ/Tzxl23AxExRv2399TVBjh2nm8xuZCj1wGZaElq5R1ifObhW
         A5PA/4Wpor+zwXhWPBtFyRcCH36msCJPJWiUlvAlAg7rrWm4TYSr6nCKL4zGpjT1nMJ/
         rAQzw3BZTnB3RFk6Y8iklQpLGrT6OS/CloQu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=D4uTlBav66MGl7hwCTFMy0da4U5qZhptmEkVKXDOMy8pkH9UqWZFte6ETPxVjK8mMM
         x/Pg8YIJDILBHn/ml00OJbxOi8+WCHMiGHH4diyT7DA7UD7vkW/GJaU5BWZjVQAEjRR2
         BpBaiXcGXdqvhhMPUnvCpub0bazm/UnD7GYK4=
Received: by 10.114.33.33 with SMTP id g33mr16594636wag.212.1260317340474;
        Tue, 08 Dec 2009 16:09:00 -0800 (PST)
Received: from ?192.168.1.5? (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm553979pzk.11.2009.12.08.16.08.59
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 16:08:59 -0800 (PST)
In-Reply-To: <200912082332.29925.jnareb@gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134927>

On Tue, 2009-12-08 at 23:32 +0100, Jakub Narebski wrote:
> Dnia wtorek 8. grudnia 2009 22:56, Stephen Boyd napisa=C5=82:
> > Yes, there is no longer an error but IE8 still locks up and takes a=
bout
> > 30 seconds. It doesn't seem to be any more responsive. Isn't puttin=
g the
> > error in a try-catch just papering over the issue?
>=20
> Does increasing interval in setInterval call at the end of startBlame
> finction in gitweb.js from 1000 (1 second) to e.g. 2000 (2 seconds)
> help there?
>=20

I tried numbers from 100 to 10000 and didn't see a difference. Files
with only a few hundred lines or less don't lock up though. I've been
using builtin-apply.c for testing.
