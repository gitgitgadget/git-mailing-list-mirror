From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 00:50:20 +1300
Message-ID: <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	 <20080209030046.GA10470@coredump.intra.peff.net>
	 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 12:50:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNoET-0006wR-JX
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 12:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYBILuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 06:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754087AbYBILuX
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 06:50:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:26282 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbYBILuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 06:50:22 -0500
Received: by ug-out-1314.google.com with SMTP id z38so50270ugc.16
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 03:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BW24sZAaQDiqQdUgWJEvU4c05rUvnZi9MQ0tT7Mommw=;
        b=ax5cnWK8Xt+ZHWaL04Y5MQzgyN1xjwyc+YnfL+DUaHYv8XjRdHubKT6oz2FXQGh7VNjUEC4MsXGTaWWUIow3GweB02zKcrWnjgSjFo4o89gi8Cgk3umqQNOOTcXYuA8jmmf+MkYgoBkKsl3Y4cahUCy4Am9YBvH4p0nMvqCo8aU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x9DO4+CXfxF8pgWUpOh9xQznf8sVJrg8U+vPw6z27Bu7NKAsVpfPP9in//C3XqkSilnaXsIQ5jKhH4AZSlUrlIjEZdrJ82dsB3C5pMEOluZTO0ec8SZaTP5AVFBC0J9BxWsNgetmT5mSz4YCTtFIhUdFg91pVNWhdN3vdpvp+xk=
Received: by 10.67.25.6 with SMTP id c6mr6571946ugj.65.1202557820173;
        Sat, 09 Feb 2008 03:50:20 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Sat, 9 Feb 2008 03:50:20 -0800 (PST)
In-Reply-To: <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73214>

On Feb 9, 2008 4:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Is there anything wrong with "git push $there $branch_name"?

This works, but is rather verbose to type all the time.

>         $ git push origin HEAD
>
> and you are done.  No need to spell out the long branch name you
> are currently on.

Didn't know this was meant to work. I'll give it a go.

> I do not know if this was part of the last round of patches, but
> I suspect it is not a problem to allow
>
>         $ git push HEAD
>
> if it is unambiguous.  That is, "HEAD?  Do we have such a remote
> nickname?  No.  Then can we default to 'origin' and use it as
> the ref to push?  Yeah, we can, so the user meant 'git push
> origin HEAD'".

If I can say git push HEAD it will be nice.

Still, the big fat ![rejected] do seem over the top when I know it
really means "stale".

And I don't completely follow how bad the impact of
auto-fast-forwarding local tracking branches on a merge. If it's a
fast-forward, my "local state" wasn't that exciting to begin with ;-)
and revlogs can potentially rescue my olden state (but what's the use
case for the local state being interesting, anyway?). Yes - user state
is important, but something that resolves to a fast-forward means that
the user state, whatever it is, is in sync with the repo.

As per the subject, these are minor annoyances. The whole
remotes+local heads setup works like a charm ;-)

cheers,



m
