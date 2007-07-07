From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible BUG in 'git log --parents'
Date: Sat, 7 Jul 2007 12:14:30 +0200
Message-ID: <e5bfff550707070314q3b78ac65p9a8ff3130a7bfaef@mail.gmail.com>
References: <e5bfff550707070249i6f3f7288uce1f922686f6e14d@mail.gmail.com>
	 <7vps348qzi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 12:14:36 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I77JC-0003zh-E2
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 12:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbXGGKOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 06:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbXGGKOc
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 06:14:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:40944 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbXGGKOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 06:14:31 -0400
Received: by wa-out-1112.google.com with SMTP id v27so620017wah
        for <git@vger.kernel.org>; Sat, 07 Jul 2007 03:14:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d+nHpHZ8XQNcQ+iHJ60By6i4W3XVZo/sU18aurNtHPvIlqILsifwCZ5kTpe7wRnoqzDAfslsPMHgqYlvpMbNz/AAN3QOOQwXQlZGieSCRu2tBgDDd/2fNmUVgHoN24VOPc1iPKsn4kbw+v+hK2yK/rQ3qeCfeAah1na9Q3N72F0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T8wGhQpe3oFJDiSQZgF6MY44meekPWOCr97+enpFC/br6D+SEZDnk2f+9Wv6ns028Vvm6XRvhaqNm9eG9xVT9oGKxhryYuEZscuevVbFbxeSbgoxsQ2Tc3botb2kdwqKGQdFyU4NYAahM1bTW+16h2gR6N4JUaB2KqjiHJ3k4Xo=
Received: by 10.115.55.1 with SMTP id h1mr1428798wak.1183803270883;
        Sat, 07 Jul 2007 03:14:30 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 7 Jul 2007 03:14:30 -0700 (PDT)
In-Reply-To: <7vps348qzi.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51811>

On 7/7/07, Junio C Hamano <gitster@pobox.com> wrote:
>
> Line wrapping in the middle of a single object name makes it
> hard to read doesn't it?
>

Sorry!

> I recall we added an extra logic in rev-list side to squash the
> parent commits that artificially becomes duplicate due to this
> history simplification logic, which we might want to port to
> git-log.  However, I have a slight suspicion that we earlier
> decided not to do so on purpose with git-log and for a good
> reason.  I do not have much energy left tonight to dig into this
> right now, but mailing list log and commit log messages for
> rev-list.c, builtin-log.c and builtin-rev-list.c might tell you
> more.
>

I will take a look hoping to *not* find anything important, now that
qgit rely on git log instead of git-rev-list to show the graph, I
would really hope that it is possible to patch git-log in the same way
then git-rev-list.

Thanks
Marco
