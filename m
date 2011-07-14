From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] implement generic key/value map
Date: Thu, 14 Jul 2011 21:18:40 +0200
Message-ID: <CAKPyHN03dvnwZ6O=kROSWpMVtBc4ifwKqboGt0rKo_r0x-bFXg@mail.gmail.com>
References: <20110714173454.GA21657@sigill.intra.peff.net>
	<20110714175105.GA21771@sigill.intra.peff.net>
	<CAKPyHN0-VbzjMaMJFZeGGrGX6HuGNEBHNVNf0cexB2vu21_13g@mail.gmail.com>
	<CAKPyHN3G41iMGmGgp6jTcWN=Rxt=RTUS7ktgVDhZEXPBRXvTDQ@mail.gmail.com>
	<20110714185539.GA27141@sigill.intra.peff.net>
	<CAKPyHN3VV4bmy2CF9vPsRG82EapFtUOCXNYO=mVAJs54QG===g@mail.gmail.com>
	<20110714191416.GC26918@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, "Ted Ts'o" <tytso@mit.edu>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 14 21:18:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhRQt-0001fZ-3t
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 21:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972Ab1GNTSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 15:18:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42217 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757Ab1GNTSl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 15:18:41 -0400
Received: by vws1 with SMTP id 1so416133vws.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EJwVm6j/dcFtCJZ1VREdQsuxcEQFqJQCaiTvEJ2V068=;
        b=NO5+MiDSqQruShgBu56E0GsZBjZ4HJpELq27OSnMJYYULCxr3h88qZsUZAHiBsOSLJ
         +Fu/o6Pr6ZqLuhnIGaJaEP3AGrgB+zpAHBbDdoCL6opVbhjX35lk0xTsX054sprVHBQK
         2ctoQN58YK9FCrODp0DVmQ7/TgbxbdTkPRJ50=
Received: by 10.52.72.161 with SMTP id e1mr2970586vdv.195.1310671120797; Thu,
 14 Jul 2011 12:18:40 -0700 (PDT)
Received: by 10.52.107.228 with HTTP; Thu, 14 Jul 2011 12:18:40 -0700 (PDT)
In-Reply-To: <20110714191416.GC26918@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177163>

On Thu, Jul 14, 2011 at 21:14, Jeff King <peff@peff.net> wrote:
> Yeah, that would work. It can bloat the code more, but in practice, not
> much. It would also work better if we were providing the map API as a
> library to arbitrary code. But we have the luxury of knowing all of the
> types that will be used with it at compile time. :)

Right, my thinking was more in the library world back than.

Bert

>
> -Peff
>
