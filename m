From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH/RFC] Add [] as an alias for a reference to the empty tree
Date: Mon, 10 May 2010 11:51:05 +0200
Message-ID: <AANLkTinsofcjlVmnMtW7mONO8zGQd2eT9rMEynVNchsR@mail.gmail.com>
References: <1273250247-20762-1-git-send-email-pkj@axis.com> 
	<20100508045319.GD14998@coredump.intra.peff.net> <7vhbmjc6dy.fsf@alter.siamese.dyndns.org> 
	<A612847CFE53224C91B23E3A5B48BAC74482E511E7@xmail3.se.axis.com> 
	<20100510092054.GA2602@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 10 11:51:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBPe9-0002lp-Iv
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 11:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab0EJJv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 05:51:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65185 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab0EJJv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 05:51:26 -0400
Received: by wyf19 with SMTP id 19so708713wyf.19
        for <git@vger.kernel.org>; Mon, 10 May 2010 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=GvJbNijrbhnklHBfGtv9IDxFamp6aVHhU8PkgQNLJXQ=;
        b=M75y0cyhXUX6t1qTkmb/YrKReROWCqfWScgvm4I0+MbDqGXzHa11RN0w+1UqjSSDhq
         BUbkxkHrZHi9Zb+KKNHl4XlOu/S0XYXX3hIvsvdx0+cGCkB73+T3APuItBkn++jaSHw9
         dt5EP0ow5Lfb1qBlur+p4R8a7rwx2eeDb0l7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=koqhzAW+WP2m7Wlq7atFLrmAoGV8YOTuw73Qakl75yIIyegyHQHzHReU2Dgk+U0EmD
         8FOI+TG3zL3wtoEpVgoMKT+s6Lbgm1xdXDBVPjUkDgOfPV25hJP+/eKlHF+4vvHX46Dn
         2H9rhGhjQ9Wnem7A9hHk3g4xGVODr/YyAJzVM=
Received: by 10.216.87.140 with SMTP id y12mr2201948wee.36.1273485085357; Mon, 
	10 May 2010 02:51:25 -0700 (PDT)
Received: by 10.216.60.147 with HTTP; Mon, 10 May 2010 02:51:05 -0700 (PDT)
In-Reply-To: <20100510092054.GA2602@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146781>

Heya,

On Mon, May 10, 2010 at 11:20, Jeff King <peff@peff.net> wrote:
>> However, if INDEX, WORKTREE and EMPTY are preferred as syntactic sugar
>> tokes, then that is fine by me.

Must it be ALL CAPS? In Mercurial the fairly elegant 'nil' is used for
the empty commit, why can't we do the same?

> So certainly if you want to do EMPTY, I wouldn't let the lack of the
> other two hold you back. The only reason they are related at all is that
> they would probably share a syntax, if the other two ever even get
> implemented.

I still don't see the point in having INDEX and WORKTREE, especially
since they're so CAPSY. Almost as if they're supposed to be
environment variables.

-- 
Cheers,

Sverre Rabbelier
