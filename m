From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Tue, 26 Feb 2013 13:09:18 -0500
Message-ID: <CAEvUa7=eFPgmyOXH=357RcFzs20iE2ZGAn0qUKpVACqBAhzBvw@mail.gmail.com>
References: <20130226172504.GA2271@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Gorchak <mike.gorchak.qnx@gmail.com>, kraai@ftbfs.org
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:09:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAOyH-0002U8-6i
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 19:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984Ab3BZSJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 13:09:19 -0500
Received: from mail-vb0-f49.google.com ([209.85.212.49]:42788 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab3BZSJT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 13:09:19 -0500
Received: by mail-vb0-f49.google.com with SMTP id s24so44809vbi.8
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ZnF//JilLklhajDkS4VtXRLIAJ9ir/uamMHzMETAwzw=;
        b=TBe49ZO0m53bNxI9nPj1Dfj5K6FYiu1TdIJD5xzFoArE1ipv0ZxdjEjgVvz4voTYhz
         efpcqUbv3zhunR6zwIUFEfEDuBEugG8fjxXxBqMAiejZlwD7cewuH0TwOiL20BbpiCM8
         P/zIlQNYdZE5hasnzWy8MeTV2RNPmJw26fY2Hn2eCkAzI3Lf4GpCBH+ttgI8/lz2QtBz
         QFYBmMzng8z+LurU1e/FZuZDdzyDS3PMA8ubCXS6N25vd9UxNRTywbbq+MWJwZ6cPanm
         q7jkFIQRba3DA5DdQm/ZhQg6b8wDJcwJMFSHdieaOt/BaI7m8947IXkjzERWBdikxohW
         WNhg==
X-Received: by 10.52.74.102 with SMTP id s6mr10589151vdv.28.1361902158508;
 Tue, 26 Feb 2013 10:09:18 -0800 (PST)
Received: by 10.58.45.3 with HTTP; Tue, 26 Feb 2013 10:09:18 -0800 (PST)
In-Reply-To: <20130226172504.GA2271@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217154>

Hi,

On Tue, Feb 26, 2013 at 12:25 PM, Matt Kraai <kraai@ftbfs.org> wrote:
> I didn't realize that QNX 6.3.2 provided getpagesize.  Its header
> files don't provide a prototype, so when I saw the warning, I assumed
> it wasn't available.  Since NO_GETPAGESIZE is only used by QNX, if
> it's OK to reintroduce the warning, NO_GETPAGESIZE might as well be
> removed entirely.

I have been using this feature locally for building on z/OS USS.  IBM
decided to drop the getpagesize definition by default, as it was
removed from SUSv3.  There is a way to re-enable the withdrawn legacy
functions, but I'd rather this option for using sysconf(_SC_PAGESIZE)
since that is apparently the preferred method now anyway.

So, if it's not being too much trouble, I'd vote for keeping this feature.

Thanks.

David
