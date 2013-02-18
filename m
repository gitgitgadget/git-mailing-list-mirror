From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/9] user-manual: Use 'remote add' to setup push URLs
Date: Sun, 17 Feb 2013 18:15:43 -0800
Message-ID: <20130218021543.GA4626@elie.Belkin>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
 <0016ba69f4157996dfbe66938056c4192bed62c1.1361146398.git.wking@tremily.us>
 <7vbobie62v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 03:16:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7GHC-0002Jj-9U
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 03:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799Ab3BRCPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 21:15:52 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45706 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755872Ab3BRCPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 21:15:52 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so2536869pab.8
        for <git@vger.kernel.org>; Sun, 17 Feb 2013 18:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FtWJyLierw3n9Tk2QiRnU7qKpqSq/UgUtqA77jviz+g=;
        b=LEhH0peYCloc7jvyMOZSeuFefMApNt/HWXeMg+uPkKQP/tKUtjME06yaZBWpwgv6A5
         Q1BwwcSsOjfGNxB0CsQncFcrNqoBtRqElcKr4eRA7vFTeATGn0IcUSgoElwI0NRANmQd
         8RrB3E2W1zerq0XQxOmG4OraKmjPYqzxT4rm5RSiOjxd5pqdO5HtbX46BZInHzedlSZ7
         CGES6JQ+2DTNc+LZw59zoDh9eP5Yb5CdgYVFVi7rrhgLTnXvadFYpBKrpodMDtyiHVPq
         bKKLPAj2qVr4HA4g0u7xA8QKNXEuq96ot23KQjZ9PdUnk4eGQYgDdFBXU6Qk/CW7T/6/
         noxA==
X-Received: by 10.68.135.3 with SMTP id po3mr25920300pbb.33.1361153751565;
        Sun, 17 Feb 2013 18:15:51 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id mw8sm12713316pbc.21.2013.02.17.18.15.49
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Feb 2013 18:15:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vbobie62v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216428>

Junio C Hamano wrote:
> "W. Trevor King" <wking@tremily.us> writes:

>> There is no need to use here documents to setup this configuration.
>> It is easier, less confusing, and more robust to use `git remote add`
>> directly.
[...]
> This looks like a good 'maint' material that can be applied straight
> away there in preparation for 1.8.1.4 to me; reviewers watching from
> the sideline, please stop me if you see issues.

Agreed --- this looks good.

[...]
> As the additional "remote.public-repo.fetch" line hints, this does
> more than "lets you do the same push with just [lazily]"; it also
> starts pretending to have run a fetch from there immediately after
> you pushed and update the remote tracking branches.  I couldn't
> decide if it is a good idea to point it out in this point of the
> flow as well, or it is too much detail that is not exactly relevant
> while teaching "git push".  I tend to think it would be the latter.

I think it's possible to improve the text here to hint that there's
more to learn (maybe a forward-reference to a section about the
remotes/* hierarchy) without getting lost in the details.  But that
problem was already there, and I don't think it should block this
improvement.

Thanks.
Jonathan
