From: Adrien Beau <adrienbeau@gmail.com>
Subject: Re: [ANNOUNCE] GIT preformatted documentation available.
Date: Wed, 28 Dec 2005 17:51:37 +0100
Message-ID: <94fc236b0512280851n797ecbedjecae3f8131b84369@mail.gmail.com>
References: <7vu0cuc4c2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 17:51:50 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EreWi-0000qk-Oq
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 17:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVL1Qvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 11:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVL1Qvi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 11:51:38 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:26328 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964855AbVL1Qvi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2005 11:51:38 -0500
Received: by zproxy.gmail.com with SMTP id 13so1636561nzn
        for <git@vger.kernel.org>; Wed, 28 Dec 2005 08:51:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y6fFDvkyJvSstiVw6HEk8IoMs5zor5bMAKTsXg2n4XI09dRJZL953q2Ww+lTUyPyXwUjqw7mhGufvRLQ+QL71MMUQY5eTI1RJp3yIHkUuSeB1GjawmKd5qjQT1x9GdpD/3b1DI6ucZriwP6ePjmqOAs3VfyNhSzEZ80W9BOJkTk=
Received: by 10.36.13.7 with SMTP id 7mr2762328nzm;
        Wed, 28 Dec 2005 08:51:37 -0800 (PST)
Received: by 10.36.250.55 with HTTP; Wed, 28 Dec 2005 08:51:37 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0cuc4c2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14102>

On 12/27/05, Junio C Hamano <junkio@cox.net> wrote:
>
> I was asked to provide pre-formatted man pages (and perhaps html
> pages), since the time of kernel developers are better spent on
> what they do best, rather than preparing the xmlto toolchain.
>
> I was planning to do a tarball every time I do a "release", but
> that would mean it is no better than the current way --- you
> could extract manpages out of rpm anyway.
>
> So instead, I'll do independent branches "html" and "man" in
> git.git repository to keep the preformatted documentation.

Having preformatted documentation is a great step forward, but it
would be even better if we could have it without installing some weird
RPM tool or a local copy of the Git repository -- not all my machines
have that.

Besides, it's not very beginner- or newcomer-friendly. Grab the
source; discover you need a complex toolchain to have manpages; maybe
learn sometime later that "all you had to do" was get an RPM and
explode some parts of it -- nah, it just doesn't feel right.

You're already generating five RPMs and two tarballs everytime you
release a version, would it be much more taxing to generate a third
tarball?

That said, those two new branches are neat. Thanks!
