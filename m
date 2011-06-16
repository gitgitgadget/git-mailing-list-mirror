From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Thu, 16 Jun 2011 11:16:21 +0930
Message-ID: <BANLkTimYsvHqZsxYA34o7s94c9V8vzkHbw@mail.gmail.com>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>
	<m3pqmodzee.fsf@localhost.localdomain>
	<BANLkTi=w10KQ3MSd5YuYR+S=eMgywNTY-A@mail.gmail.com>
	<201106151735.07137.jnareb@gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Peter Harris <git@peter.is-a-geek.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 03:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX1f9-0001lq-VP
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 03:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998Ab1FPBqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 21:46:23 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37867 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab1FPBqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 21:46:22 -0400
Received: by eyx24 with SMTP id 24so381278eyx.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 18:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+QEk5Ky/IbQttTUsjrGmRICjRJJXAQnt1DprYrX617I=;
        b=E0ZoEDWGwfXLktmj7QGEvs9Irc1AmzLrS2roD8+X7/IDHJvXgFW4239TURQZhSzM3Q
         Qx07PhL15Cjz6oGiblnOaZFZryXkDUmz3wRCCB29YzK9vcbCoUOuCqoB0bG7XJwCbHIO
         l79VAplTlfxDlOWce3UkaDZyn4zfMhQf34g5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=gZ2qlrfn0JA8ZBxr9go5QvfD0SZzoiYicZqeYWBVT6rPYLN4xULMbNVwzG2Y4AZ4CQ
         0TovikLfXlHk/mKFSv+zvo/glc3PGiPhFmvxVxFQxQUlZNpdgPF9zqOnMUwSy1ku7RYV
         R9tNuAW+LqP4TcEWnrVItXCgvUS0vbF0a34J8=
Received: by 10.14.10.18 with SMTP id 18mr133776eeu.172.1308188781263; Wed, 15
 Jun 2011 18:46:21 -0700 (PDT)
Received: by 10.14.98.205 with HTTP; Wed, 15 Jun 2011 18:46:21 -0700 (PDT)
In-Reply-To: <201106151735.07137.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175879>

2011/6/16 Jakub Narebski <jnareb@gmail.com>
>
>
> Why did you set packSizeLimit at all?
>
>

Some time ago (31/8/2010) I had a problem which seemed to be caused by
large packs (>4GB), you
can find it in the git list with a subject of "Large pack causes git
clone failures ... what to do?"

Anyway, I set packSizeLimit and fiddled around for a bit ...
eventually the problem went
away when I moved the central repository to another machine with less load and
more memory. At which point I gave a sigh of relief and forgot to
remove the packSizeLimit
until recently bitten. But the original problem was probably nothing
to do with large
packs and hasn't recurred.

Cheers,
Geoff.
