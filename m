From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 23:17:57 +0300
Message-ID: <f36b08ee0606151317j235d3da9s1304ca9766289a47@mail.gmail.com>
References: <1150324030.23268.12.camel@dv>
	 <20060615072450.GF7766@nowhere.earth>
	 <20060615133146.GA5794@steel.home>
	 <20060615163209.GJ7766@nowhere.earth>
	 <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 22:18:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqyI0-0008VQ-3a
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031259AbWFOUR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031272AbWFOUR6
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:17:58 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:38622 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1031259AbWFOUR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 16:17:58 -0400
Received: by py-out-1112.google.com with SMTP id i49so402248pye
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 13:17:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PB0l3y4knHYoqiAyYZNpRZyTvyr+Y8+E4RqcgxKGRPu1bSRV4OuwJDjUzSIHAS5/SKUfwdXhgQpTRaS6WAZ/Bv/MWKVz1Zg3rw6EWefjg2zS/KUDXWSQ29B8rVHyKz27XCqx/rLf85cFYa1ujEtbeNuyWyFGeM+I0h04SwW+2JI=
Received: by 10.35.69.11 with SMTP id w11mr3588034pyk;
        Thu, 15 Jun 2006 13:17:57 -0700 (PDT)
Received: by 10.35.14.20 with HTTP; Thu, 15 Jun 2006 13:17:57 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606150954430.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21904>

On 6/15/06, Linus Torvalds <torvalds@osdl.org> wrote:
> These days, there aren't fifteen different versions of UNIX. There's a
> couple, and it's perfectly ok to actually say "fix your damn system and
> just install GNU make". It's easier to install GNU make than it is to
> install autoconf/automake.

It's easier to learn GNUmake than to learn autoconf/automake or jam, too.

However, the idea of compiling small pieces of main() at the
configure-time to automatically figure what exactly is available --
I like how well this approach works. It works more
precisely than relying on uname.

Yakov
