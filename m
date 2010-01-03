From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] git-update-index: report(...) now flushes stdout after 
	printing the report line
Date: Mon, 4 Jan 2010 07:03:19 +0800
Message-ID: <be6fef0d1001031503h11cb65c6ha34eee345b9b7055@mail.gmail.com>
References: <loom.20091119T221732-624@post.gmane.org>
	 <loom.20100103T114055-16@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Sebastian Thiel <byronimo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 00:03:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRZTp-00073W-Hx
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 00:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145Ab0ACXDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 18:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140Ab0ACXDV
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 18:03:21 -0500
Received: from mail-iw0-f197.google.com ([209.85.223.197]:40680 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097Ab0ACXDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 18:03:20 -0500
Received: by iwn35 with SMTP id 35so10046070iwn.4
        for <git@vger.kernel.org>; Sun, 03 Jan 2010 15:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ZOvR6Vtp88PwvzUSE0y1puNgI7pZ9lWKJvT15sqfVHI=;
        b=DNLuuBjAab7IcCHn/g1YSq3N9aGuXNOQ5g3DJV875ALJ9oweQOVcVjzxoERhBZNb3S
         VT3wuqL8MnJ1WRgi06uYQlpJE3bHy8Bs45Fvgg8n4TwIwqYNgNXSIjLBv0kb0AdOFZi6
         WaJBWwBYGVkFqKBn5DpIlNeIBeeH+dALqnFxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=heb7UTPXkD5Gmvmet8ezM2BROuI+Btq9FRfSTH0DqrNUwqRe3LscHVhPnq5Uy8UFxH
         D8TvGULZssUDR31aE6y2qwueHdVLJDEKdhLhKkI+8B27e8uMsfEt4g5ncuvMxrf9R673
         8T2lyIxWvYsJ79Q4LbQaHw7GbGOX1shpC5aHo=
Received: by 10.231.147.78 with SMTP id k14mr1118263ibv.11.1262559799917; Sun, 
	03 Jan 2010 15:03:19 -0800 (PST)
In-Reply-To: <loom.20100103T114055-16@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136084>

Hi,

(you dropped the Cc list; fixed that for you.)

On Sun, Jan 3, 2010 at 6:41 PM, Sebastian Thiel <byronimo@gmail.com> wrote:
> Adding a commandline option to git-push and git-pull that enforces progress
> messages to be printed to stderr would be a feasible and simple fix that would
> clearly improve the usability of tortoise-git and git-python to name only two.
>
> That said, I hope I managed to make myself clear enough this time to help the
> people in charge to figure out how to solve the issue. Once the desired solution
> has been sketched out and the desired new commandline options have been named,
> it could even be me to implement it if necessary, as I'd consider it a gentle
> start into the world of the git codebase.

from your above message solely and setting aside your original patch,
I presume that you want to introduce the ability to force progress
reporting even if stderr isn't a terminal.

I am working a feature (display progress for http operations) that
happens to add this ability to git-push and git-fetch, by specifying
the --progress option.

Regarding git-pull - I guess it's only git-fetch (being
transport-related) that reports progress?

-- 
Cheers,
Ray Chuan
