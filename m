From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 11:27:51 +1300
Message-ID: <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	 <alpine.LSU.1.00.0802081142060.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:28:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNbiG-0002mg-7E
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 23:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760162AbYBHW1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 17:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057AbYBHW1y
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 17:27:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:37619 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759570AbYBHW1x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 17:27:53 -0500
Received: by ug-out-1314.google.com with SMTP id z38so952901ugc.16
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 14:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=G7ZhFgevy8j/jpsvVfmZJCMX6Btea7N+A6vdlXP3tik=;
        b=QuSLd5LZ3d5U+hFo2QxkCsnVnDgj9g0hfmRAlQCFLCx4RsWBTU8Zo+tMzIyneGM34zAwYnbonIj6XDNkFFD02Mr/Z4FK0pf0taBG8jMNFtqNjmZh8APBSQeXJWTv/zqqu4+mATvbyzf1jlj5HoPNMN/NVqosDLnTHJ2V/MRz3M8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AAsAeeYszAIaArPupKQB8SjJkK7yxV9K7U01uOBhT2s/fImIzyoS0CsDCdskkTSTgicTkBNZ2JnrfS5sd0Rswgi+44gZLNwOqfu0wKbwkqB10hJ/1rHHR56G3uqEOr2k3/hJRfM6Fz/O/JJGI2prgj7kHaQOT06e6+9iYNfxzr0=
Received: by 10.66.224.19 with SMTP id w19mr5926387ugg.34.1202509671385;
        Fri, 08 Feb 2008 14:27:51 -0800 (PST)
Received: by 10.66.250.13 with HTTP; Fri, 8 Feb 2008 14:27:51 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802081142060.11591@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73165>

On Feb 9, 2008 12:50 AM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> So you're saying that the local sides' refs are ancestors of the remote
> sides' refs?

Exactly. And we could show a nicer message - rejected is too strong a word ;-)

> The problem is that the local side cannot tell

The local side has the remote refs if the client has fetched recently,
so it might be able to tell in some cases. Not with authority (things
may have changed on the server side...) but the client might be able
to say something less alarming.

> Another way to "solve" this issue, of course, is to use the remote layout.
> I did the switchover myself some time ago; it was hard at first, since I
> was so used to just check out the branches I just fetched.  But in the
> long run the distinction between local and tracking branches made life
> much easier for me.

What do you mean with "the remote layout"? I am using
"remotes"+tracking branches as far as I can tell...

cheers,


m
