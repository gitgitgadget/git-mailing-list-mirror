From: Stefanus Du Toit <sjdutoit@gmail.com>
Subject: Re: git-subtree manpage missing from git-manpages tarballs
Date: Sun, 8 Dec 2013 19:40:30 -0500
Message-ID: <CABGRy0qNqTotQFp+GnCNVEY09ymD2yXHb8YMG0KUhpk975ijSA@mail.gmail.com>
References: <CABGRy0o3AJLMhmVJL8XAjrnQJd=yuV+1Q=cLToetnhmB0V=hfA@mail.gmail.com>
	<20131208223020.GB9108@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	"David A. Greene" <greened@obbligato.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 01:40:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vpoto-000779-58
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 01:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760075Ab3LIAkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 19:40:32 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:38429 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760070Ab3LIAkb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Dec 2013 19:40:31 -0500
Received: by mail-wg0-f53.google.com with SMTP id k14so2756255wgh.20
        for <git@vger.kernel.org>; Sun, 08 Dec 2013 16:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QYKfh67xGbD39YGlqk6hsxMZWpxNjuSAtGGt+8swYSI=;
        b=R1fNnJZZmKhUckFj/+MdH6fj+IoM+t3h2ugwz25wx3oDqF2C+vKcxe8e1t85ZW81CL
         Nhu4/qSoDjCyOYsba5mla+28BLgpI5R7QlAAOt89WmUBEW1apIz0kK6RVXkaVgc/Ry4Q
         ISb+Cw4Ctzszq+kEDlXxTlVNQjUKPOtdpzJgHW2uVJLD+mYDHYsGKUMzExrhGUB+LG5P
         z9zg+QSrnidvaRrGoat41SXyIgNp+suzGPWiTmc+/D0YFYdrHXo5EP4Y4BSdZDpzEmGL
         guKNXXE7qPU66YL6tDVgMJ9q1R0NQHT7jIbdsAYvyecgBNKj9Qqm7XSB/GZJ7ci1rh7l
         kcWg==
X-Received: by 10.194.240.129 with SMTP id wa1mr13095500wjc.31.1386549630142;
 Sun, 08 Dec 2013 16:40:30 -0800 (PST)
Received: by 10.195.9.5 with HTTP; Sun, 8 Dec 2013 16:40:30 -0800 (PST)
In-Reply-To: <20131208223020.GB9108@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239057>

Hi Jonathan,

On Sun, Dec 8, 2013 at 5:30 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> git-subtree and its documentation are in the contrib/subtree
> directory.  contrib/subtree/Makefile includes rules to build
> a manpage for it.

Thanks - I guess git-manpages generally doesn't include bits from contrib then.

> If the homebrew rules are installing the git-subtree command
> from there, perhaps they could be tweaked to build the manpage,
> too.  What do you think?

The homebrew recipe states:

    # We could build the manpages ourselves, but the build process depends
    # on many other packages, and is somewhat crazy, this way is easier.

So while I'm sure it's possible it sounds like the current process is preferred.

> Alternatively: I'm not sure what the status of git-subtree
> maintenance is.  Is there someone taking active enough care
> of it that it would make sense to promote it out of contrib/
> to be a full git command installed by default?

This would be most excellent; I'm only starting to use subtrees but
after some painful experiences with submodules I really like the
subtree model so far.

Thanks,

Stefanus
