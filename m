From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] Add gitk-git Hungarian translation
Date: Mon, 14 Dec 2009 10:03:05 +1100
Message-ID: <20091213230305.GA8135@brick.ozlabs.ibm.com>
References: <1258284204-17247-1-git-send-email-djszapi@archlinux.us>
 <19205.2740.244981.703612@cargo.ozlabs.ibm.com>
 <a362e8010911220005u1783cd44yf84ae5bc5b42d980@mail.gmail.com>
 <a362e8010911281833p58058a06sbe305d61709ac051@mail.gmail.com>
 <a362e8010912131030v4c1ef231r7246d7291f6a5677@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Laszlo Papp <djszapi2@gmail.com>, git@vger.kernel.org
To: Laszlo Papp <djszapi@archlinux.us>
X-From: git-owner@vger.kernel.org Mon Dec 14 00:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJxUH-0003o7-Ug
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 00:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbZLMXEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2009 18:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbZLMXEW
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Dec 2009 18:04:22 -0500
Received: from ozlabs.org ([203.10.76.45]:52807 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614AbZLMXEU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2009 18:04:20 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0DC47B6F2B; Mon, 14 Dec 2009 10:04:20 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <a362e8010912131030v4c1ef231r7246d7291f6a5677@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135158>

On Sun, Dec 13, 2009 at 07:30:21PM +0100, Laszlo Papp wrote:

> This is the x. time (6. ?) when I try to get answer, can I count any
> answer after more months ? What happens here, what's the reason for it
> not be answered ? It's a new translation that could help git project,
> Why didn't I get any response ? But if this is the general situation I
> need to ignore my dream to contribute more in git project... :(

Actually, I thought I had put it in.  In any case, a gentle reminder
would suffice, you don't have to whinge about it.  Re-posting the
patch cleanly with a nice clear stand-alone patch description (without
distractions such as unnecessary "Re:" or incorrect "[PATCH 2/2]" in
the subject) is very helpful and is probably the best way to get your
patch noticed.

In any case, your patch has problems: I applied it and then ran
make to update the message catalogs, and I got these errors:

Generating catalog po/hu.msg
msgfmt --statistics --tcl po/hu.po -l hu -d po/
po/hu.po:41: end-of-line within string
po/hu.po:41:4: syntax error
po/hu.po:42: end-of-line within string
po/hu.po:666: end-of-line within string
po/hu.po:666:10: syntax error
po/hu.po:667: end-of-line within string
msgfmt: found 6 fatal errors
make: *** [po/hu.msg] Error 1

so I reverted it.

Paul.
