From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: PATCH/RFC] gitweb.js: Workaround for IE8 bug
Date: Tue, 8 Dec 2009 23:32:29 +0100
Message-ID: <200912082332.29925.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200912081729.11890.jnareb@gmail.com> <1260309382.5658.41.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 23:32:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI8bu-0005pJ-BZ
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 23:32:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966200AbZLHWca convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756380AbZLHWca
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 17:32:30 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:54986 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582AbZLHWc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 17:32:29 -0500
Received: by fxm5 with SMTP id 5so6822945fxm.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 14:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=a2XddvDZ1+KgiCLfnCHT2tPHAQWpg5G1UOtQifsHadg=;
        b=btLzbCYQIz+9XkKrXI6vD+xxIvlJVyAj43x6R4orycCcxEi0nFTtRiVLNvo5DvTjok
         30QQlNUhn6E9vbELUpOi6EaJSv17OhAHQwp4KR1ScnvXt7EDZxHaClGV5Vcbp6xE6ar+
         m4dovre4JaworHS6GS5y2HPf9d3590b+WhwBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=s2guOVe1L8jse0U1uoaRuK9onS83c7GujyM6WedARBqKhYOlKgwCibojGqD/TLC0uw
         yeuHx0t3x5QTv61e72Z9SL0ggg5k51eobhtwpjeqONr3iH/Azdb4Uum5Nubj/WP+cNTr
         vXHwywqtHFLNelRC+zwI/3Ax8poLJ2l3F0Rj8=
Received: by 10.102.224.15 with SMTP id w15mr1826424mug.62.1260311554853;
        Tue, 08 Dec 2009 14:32:34 -0800 (PST)
Received: from ?192.168.1.13? (abwp196.neoplus.adsl.tpnet.pl [83.8.239.196])
        by mx.google.com with ESMTPS id j9sm3456050mue.59.2009.12.08.14.32.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Dec 2009 14:32:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1260309382.5658.41.camel@swboyd-laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134918>

Dnia wtorek 8. grudnia 2009 22:56, Stephen Boyd napisa=C5=82:
> On Tue, 2009-12-08 at 17:29 +0100, Jakub Narebski wrote:=20
> >=20
> > Does the following fixes the issue for IE8 for you (it works for me=
)?
> >=20
>=20
> Yes, there is no longer an error but IE8 still locks up and takes abo=
ut
> 30 seconds. It doesn't seem to be any more responsive. Isn't putting =
the
> error in a try-catch just papering over the issue?

Does increasing interval in setInterval call at the end of startBlame
finction in gitweb.js from 1000 (1 second) to e.g. 2000 (2 seconds)
help there?

--=20
Jakub Narebski
Poland
