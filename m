From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: Retroactively change email signature?
Date: Wed, 2 Jan 2008 17:06:37 -0500
Message-ID: <9b3e2dc20801021406h46a73ef3ye0c4613d6472a4b3@mail.gmail.com>
References: <9b3e2dc20801021237v4d5d236fn3d2643502b9bb78f@mail.gmail.com>
	 <alpine.LFD.1.00.0801021316080.3010@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 23:07:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JABjx-0003Qw-8k
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 23:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbYABWGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 17:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYABWGl
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 17:06:41 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:31628 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbYABWGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 17:06:40 -0500
Received: by py-out-1112.google.com with SMTP id u52so10115727pyb.10
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 14:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RNN9huhMEGuajj3FB2BllcBaO/JJJVHg+hjL3asYkVQ=;
        b=cmGlGngV31Lfz68ou+8SPXWEsSOSKJAqpLM6A3rGsSnnG8I1gF7dVRPe6wlL2JpDGWpYr31Y0MEX1a/U63Z5Yfo7oAhf1q+austcX/6Fkjg9CQCMvXqJyJLi6IBb1LJrmDu256oV60VqueqSnCjhvQyNvdgmINZJoqgAfrYjkKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BKbwOEsqweJv83dQw79S3RiiYy8BSwSrRo2+87jHQbWvIN6i6187UF+VDMnOk5zyhFn9Dg06JtkNWdNZeJ9dngaNdm5C67/0501eTJxVjZbh7VLR2UC1B1zkt2jHKzRrPLUTlS8CuBLXR9qWqi3kg6AAsCt+sCOWIg8eehOc+4c=
Received: by 10.141.15.19 with SMTP id s19mr7219533rvi.205.1199311597992;
        Wed, 02 Jan 2008 14:06:37 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Wed, 2 Jan 2008 14:06:37 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0801021316080.3010@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69495>

Thanks, I was able to use git-filter-branch to accomplish what I wanted.
I should have mentioned in the original email that it is not a widely
distributed repo, so I'm not too worried about breaking things at this
point.  I guess for a larger project it might be a problem, so I
probably just wouldn't do it.

> BUT! See also the big bold-face warning: using "filter-branch" will not
> change old commits, it will create a series of *new* commits that bear a
> striking resemblance to the old ones, but are not the same. So you'll have
> a totally new history.

Got it, thanks.
I'll just have to remember to git-config properly next time I do this.

One thing that's a bit odd for me is that I use a different email
address for this particular project..
Conveniently I'm able to use git-config to set an email address
locally for this repo, however I have to remember to do this every
time I clone it somewhere.  Not a problem, necessarily, but perhaps
just a matter of training myself.

For example, I have a clone of this repo on a Linux, Windows, and OS X
machine, and also another clone for each on my laptop..  git is
actually turning out to be great for doing all this swapping between
machines, but it does take a little training to remember to set the
configuration, since there's no central repo to ask me for my username
and password before I can commit.


cheers,
Steve
