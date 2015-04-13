From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: When and how to to contact the Git developers (gist)
Date: Mon, 13 Apr 2015 14:10:02 -0700
Message-ID: <20150413211002.GD5467@google.com>
References: <CAEcj5uW2Shh4QvtmenW2h6KXYUCoEe5bHYNv_HVFQgUit=cJ0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 23:10:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhlcc-00077c-WA
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 23:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbbDMVKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2015 17:10:06 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34532 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbbDMVKF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 17:10:05 -0400
Received: by iedfl3 with SMTP id fl3so86509481ied.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Q8d42jsGfU0arXq5AHWXB0CPGEXNmwQ6HmICYPlB/Ac=;
        b=Zxj+vBoAHiqg4ZFbjHkdllqKP+LtIVFx2GB5GaSxe6c9GJ8SS6C+oXxq9HabwMLbLH
         cPen6QkjD7UahJrAAmlFzdxucrCMb43hEpv1OV2AhqO4wbg94CTXvywsOD++wSUGAZbb
         riCvK4aYX156sU0YY9YpTPcfqp38kqyb5YXgEFPGx6aqjJ+lgWe5bA+AefQLUZzeXWc+
         wK+c1mJxrqrBVBOQoieWN2noNuzY+IM+KDh20LkHbf6tG0MuHts/MZIaSDqm4XWF9fo6
         ygaDanjvaLpA9tskNJKGO2X2ZAgSlfExCexYY8UlD799uR5lg2Ut+Wq/+kS36hrxusjZ
         deTQ==
X-Received: by 10.107.31.206 with SMTP id f197mr24313454iof.19.1428959405140;
        Mon, 13 Apr 2015 14:10:05 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:ed10:7b5c:963e:5b26])
        by mx.google.com with ESMTPSA id ig15sm5722726igb.10.2015.04.13.14.10.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Apr 2015 14:10:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEcj5uW2Shh4QvtmenW2h6KXYUCoEe5bHYNv_HVFQgUit=cJ0w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267100>

Hi,

Thomas Ferris Nicolaisen wrote:

>              Perhaps someone here would prefer to use my gist when
> redirecting people with "user questions" away from this list, or
> inspire them to write better bug reports.

This won't come as a surprise given what I said at Git Merge: I'd
rather we don't redirect people with user questions away from this
list.  The current volume has been pleasant and manageable.

I especially disagree with

	Generally speaking, Git has very few bugs, and if you're not
	sure what you are doing, it's probably a user-issue, and not
	an issue for the Git developers.

User issues are an issue for git developers.  The hardest part of
making git work well is getting it to match how humans work, not
getting it to be technically correct or theoretically bug free.

So if I were writing it, I'd drop everything up to "If you believe
you've found a bug in Git for Windows".

Another alternate forum to point people to is #git on freenode.  It is
reachable from https://webchat.freenode.net, so a person seeking quick
help doesn't even have to set up an IRC client.

It might be nice to add a note to the "If you can find no existing
discussions" paragraph: if there's been a previous discussion, it's
fine to raise the subject again.  A good practice is to link to and
summarize the previous discussion so people can learn from what has
happened before.

On the other hand inspiring people about how to tell stories better or
write bug reports in a more useful way is always welcome.

Thanks,
Jonathan
