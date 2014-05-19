From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Problem: staging of an alternative repository
Date: Mon, 19 May 2014 17:05:44 +0700
Message-ID: <CACsJy8BAYgjeKzy8Rssz2tNzeCRSAg1UO+XK1JxuXyJh+uZMoQ@mail.gmail.com>
References: <CAKpPgveXqraM4bXb499mJm5Ls+EinihfEJ6VgOFikC0_Qp8iTA@mail.gmail.com>
 <20140430213545.GV9218@google.com> <CACsJy8C4bO_ZB-DMOkbJc9cJd_LmR6z0RZ1UZB3wKPEX005xmA@mail.gmail.com>
 <CAKpPgvdC3VEHoW4eqmjoPtr4Duh8hkaeHL-JehaVMVUAdGhLAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 12:06:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmKSZ-0006nI-6d
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 12:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbaESKGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 06:06:15 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:48080 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaESKGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 06:06:15 -0400
Received: by mail-qg0-f44.google.com with SMTP id i50so8487607qgf.31
        for <git@vger.kernel.org>; Mon, 19 May 2014 03:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j5baM0ZrWp52ymAGbT9cpnmPYy0MMiexZqDQFAHLPKg=;
        b=avXcL9HKJ5fgcsFEk4RgggW4oXNXrMfS59f7rpFoUMsfGS4S2e7ApMZ+s8Juydn8E6
         24mqWtxQw9Z1d3R9IM0euLBclaeddUb3NYoQ/80a+0M5h3hKTriPNNCGN0qh4mEfd/6N
         0Dr1N+4l3rCO4Ge2uQGbCRcwCdnEXtxtMvP0xBIkLWxlJ2ip7J2X3ylvBaEIEglbMal9
         WP6aR0EtR7xja+M9GeuHs9MfUDI1eGjrdtBMv0XYeE6xFQBoSEJCg9NUOnyVCtqGInZ+
         z+0w/dGPWTSwz5wgGbkbBATHooR3qczwZe1KNKn3cFtnxtzldvfQ6JeMSKkZBz1vHn/8
         LpJw==
X-Received: by 10.224.87.132 with SMTP id w4mr32568596qal.89.1400493974403;
 Mon, 19 May 2014 03:06:14 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Mon, 19 May 2014 03:05:44 -0700 (PDT)
In-Reply-To: <CAKpPgvdC3VEHoW4eqmjoPtr4Duh8hkaeHL-JehaVMVUAdGhLAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249571>

On Sat, May 17, 2014 at 11:31 PM, Pasha Bolokhov
<pasha.bolokhov@gmail.com> wrote:
>     Now if you guys don't see anything against this, I would shoot out a patch?
>

If you have written the patch already, I see no harm in sending it
here. I'm concerned about the perfomance impact on this code, which is
already slow when the repo is large. But we can benchmark it later.
-- 
Duy
