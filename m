From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Mon, 25 Jan 2010 22:53:00 +0100
Message-ID: <fabb9a1e1001251353q3739a5efq38606ca0b63ce10@mail.gmail.com>
References: <alpine.LNX.2.00.1001251628431.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 22:53:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZWs9-0007A3-EQ
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 22:53:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab0AYVxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 16:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461Ab0AYVxV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 16:53:21 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:52370 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab0AYVxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 16:53:20 -0500
Received: by pxi12 with SMTP id 12so3043075pxi.33
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=1+ZxCTht8OABuk/2yFuJvqqt+/B9QboWq+ayeFPXW4s=;
        b=XSyrj6yYEX4h+iv+fNOzG5083cLQlxkUx9jOKAaCgWiKB/QQ/07qCngmYHsgE1yP3T
         MPB0zr9iCzVFN6XMuwdDg4jdQMs9nvnG300+QeljYM0dfNoXwbGKe5tVtXeoxuVYmHBb
         DZMY0W5MtiAGoyfH2MEqFznnfzPULGEfc1b7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WUSTvjWl2ZF6GFT8Wo+Gmw2s0Nkh96Rrje0hGwjSuW5O9mCF0Wnm9oZqMmbfWlAHdm
         qLi83KxeyxE03/vW19gjJfI4IEniWDpPYa+39XDvi4418zbMihBxBOwfWZMv8coK9gKv
         N1Ug2nFoIb0Gt1F/ZgXLoxpADe5bomEtYehP0=
Received: by 10.142.7.9 with SMTP id 9mr42968wfg.149.1264456400319; Mon, 25 
	Jan 2010 13:53:20 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001251628431.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137999>

Heya,

On Mon, Jan 25, 2010 at 22:35, Daniel Barkalow <barkalow@iabervon.org> wrote:
> The push support is also currently based on a transport helper
> export design that isn't upstream and I don't like any more; a better
> design is probably to have the core send an "export" command and then a
> gfi stream, but I haven't worked on this.

Ah, that was actually what I _thought_ the export command did, and how
I was/am going to implement it for git-remote-hg. Do you think you'll
have time to work on that anytime soon? My git budget should go up
enough to do some serious work after this weekend, so if you have time
we could work on moulding the 'export' feature into something more
generically useful. If not, I'll do the work anyway, and hope you'll
have time to review it at some point :).

-- 
Cheers,

Sverre Rabbelier
