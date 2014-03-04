From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: Re: [BUG] Halt during fetch on MacOS
Date: Tue, 4 Mar 2014 23:21:40 +0100
Message-ID: <CAL0uuq0MPSnB+HNxfD2Mj6mLbhTcvhKQ_e20EV0QgS8Os8CsJw@mail.gmail.com>
References: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
	<20140301061532.GC20397@sigill.intra.peff.net>
	<F9B4418D-9414-4857-9199-EDBA20B952C6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Conley Owens <cco3@android.com>, Jeff King <peff@peff.net>,
	Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:21:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKxie-0002T8-AX
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 23:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbaCDWVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 17:21:43 -0500
Received: from mail-vc0-f173.google.com ([209.85.220.173]:64354 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190AbaCDWVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 17:21:42 -0500
Received: by mail-vc0-f173.google.com with SMTP id ld13so177347vcb.18
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 14:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ml7Kw1i0uf8+bmKwOCW7F9qwICG2el3PWAqkNiu2ddg=;
        b=gmt354/Cudw7I22Uh1Nkh81JgSaOOUonAbOZqQg0bx1zfmmQ0VWWruHIJOs8tJwCh6
         Dp1xAhR5I/rvixzLh5tYcmkpChssm9+L2iVE+Sas8iI4ROtEUUrbYtKY71poyvEyqaJo
         TeJqi0W4rpDXIBO/A8N7w/6uiHxQreo/J4R4YIhSXNx5DEsGl+3DGnapuPZiMGp8AC60
         Ob3KTVwEnleOgj6Q2JeAXIZpoRF0YQE6aSIIAFummtIRFv02zdUf3Tkw42aHN5R8yUBF
         I1jkKL/QtPUQZT9evjglfPBf2Q5gpLKV3jI8S9Krx1wSK4uTbh4FJNszbniFlzfiKb5o
         mM0w==
X-Received: by 10.58.4.138 with SMTP id k10mr1675395vek.8.1393971701037; Tue,
 04 Mar 2014 14:21:41 -0800 (PST)
Received: by 10.52.73.161 with HTTP; Tue, 4 Mar 2014 14:21:40 -0800 (PST)
In-Reply-To: <F9B4418D-9414-4857-9199-EDBA20B952C6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243397>

On Sun, Mar 2, 2014 at 3:02 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> I can't reproduce, mostly, on Mac OS X 10.5.8 or 10.6.8.
>
> What I mean by mostly is that the very first time I ran the test script I
> got approximately 36 of these errors:
>
> fatal: unable to access
> 'https://android.googlesource.com/platform/external/tinyxml2/': Unknown SSL
> protocol error in connection to android.googlesource.com:443
>
> The rest of the fetches completed.  That was with Git 1.8.5.1.
>
> However, I was never able to reproduce those errors again.  All the
> subsequent runs completed all fetches successfully using that same Git
> version so I also tried Git 1.8.5.2, 1.8.5.5 and Git 1.7.6.1 on the original
> and another machine.

With Git 1.9.0.138.g2de3478 (latest build from source) on Mac OS X
10.9.2 I report similar results. A first run yielded several  "fatal:
unable to access" errors, while a second run yielded just one.
