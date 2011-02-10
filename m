From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Wed, 9 Feb 2011 21:46:14 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102092136580.20937@debian>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297302842-11296-1-git-send-email-martin.von.zweigbergk@gmail.com> <7voc6k62xq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Yann Dirson <ydirson@altern.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 03:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnMY6-0002Kh-UP
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 03:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab1BJCqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 21:46:20 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60370 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754319Ab1BJCqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 21:46:19 -0500
Received: by vxb37 with SMTP id 37so441143vxb.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 18:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=4TbrenNXUahpcmw30NIu7fc5hs+hOWj6IFcGOhS5AUk=;
        b=xoNFimOMzGmF/CipKWAFKHk1VNxZWxQHnVKas6Ln+dH2Un7wHJ+v4OuIaETBQtO1zK
         l/GXtemjamcuYmuvb95iGkooQ7SHnNCIXLU6U0Lxo6qByvxU01wGtVPrYRlnDd07w5Fg
         2WIvWpYtDc2vdUKzKo+8Mol8It9j1m53YeCXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=rM4f/M0TUNRd96YtYX9fIHX/6N8KnEe6sZ2N4iU1StGX+AO9XyM8QHgTl/TVVrzDp5
         YkATAmw/mAKB1jzc4vTU1clAroQrxQejHnqYA7+skRU64LyQ+WpKvS7htqoY7TtBpYQN
         w6aW3fZHE32uv0d7YmL6GkYQuwiwx3oIS6fqg=
Received: by 10.220.181.135 with SMTP id by7mr5305563vcb.258.1297305977147;
        Wed, 09 Feb 2011 18:46:17 -0800 (PST)
Received: from [192.168.1.104] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id v26sm406490vcr.13.2011.02.09.18.46.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 18:46:16 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7voc6k62xq.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166469>

On Wed, 9 Feb 2011, Junio C Hamano wrote:

> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> 
> > 'git rebase' without arguments is currently not supported. Make it
> > default to 'git rebase @{upstream}'. That is also what 'git pull
> > [--rebase]' defaults to, so it only makes sense that 'git rebase'
> > defaults to the same thing.
> 
> Not that I am fundamentally opposed to the proposed change, but the above is
> not a very convincing argument, when the corresponding change to "git merge"
> is just started getting discussed.

There was a little more motivation later in the commit message, like
using it with 'git rebase -i'. I have been using it for a few months
now, and I also find it quite useful e.g. when rebasing all my
branches on top of your master.

> 
> On top of what commit does this patch apply, by the way?

On top of the rebase refactoring series I posted a few days ago. See
http://thread.gmane.org/gmane.comp.version-control.git/166161/.


/Martin
