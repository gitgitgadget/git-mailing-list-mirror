From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Sat, 12 Jul 2014 10:53:47 +0200
Message-ID: <CAOvwQ4gEeTS4o6dEUczq+tnS3HePbab-=NpWWA1Z5tkNTjMxfQ@mail.gmail.com>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
 <1405024438.3775.3.camel@stross> <CAOvwQ4hq5AZ0ZhB-1etUZfLfJ4X=11_03syH2pgY_fi=FSLAPQ@mail.gmail.com>
 <1405025616.3775.6.camel@stross> <CAOvwQ4h=uFCN36dQt4uqwJv8393iVhiCh09+71DhhzyWrbCfUA@mail.gmail.com>
 <CAOvwQ4in4aufZX2PGkAoX4vWhg_mq+n6Baov_ifGjiyfR_UbPQ@mail.gmail.com> <20140712045616.GA14459@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 10:54:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5t4l-0001a2-Cr
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 10:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbaGLIy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 04:54:29 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:34509 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaGLIy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 04:54:28 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp4so306084obc.15
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=58uoOrxprv4rzrdOxUX7vtovfcatyozWM+c/ffZwA+M=;
        b=H0JEMRrSE1XQ9yxXGlt6j3q9/WhV/enuFX7bvrNASU8Mav8bejq8qUOO3cd23V471j
         2MvrD3A9vxawIZC8Ja9V8AFMWzbuxtA7QgEDGp4d6/5JV/zwQwbTJFctjv/FCL4IMCqU
         Xdo6Q8VWUuwEtQgLcYfAeY8wIbGkA4sE44U0o13qS7h4VVy8neKIblA+Hv8L/o4J8y2k
         s0pPFEDYWPQ3taRfsAkH7GaM7hA+hRLwgOevnt+4zZDwj6YPEft62pwBkt/mN92lL3lj
         dY1qAodvdSECXASWVu7jVxg+wGWJn2LsY3HZPLquB47v0CZ8ITr1utrTGC1ix/lyN+RP
         Ew1A==
X-Received: by 10.182.102.197 with SMTP id fq5mr4914428obb.3.1405155267779;
 Sat, 12 Jul 2014 01:54:27 -0700 (PDT)
Received: by 10.76.127.116 with HTTP; Sat, 12 Jul 2014 01:53:47 -0700 (PDT)
In-Reply-To: <20140712045616.GA14459@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253386>

On Sat, Jul 12, 2014 at 6:56 AM, Jeff King wrote:

> I think none of the regular devs uses PROFILE, and it bit-rotted

By the way, is there no build (CI) server for git.git to regularly
test branches on different platforms or at least different build
configs on the same platform?
