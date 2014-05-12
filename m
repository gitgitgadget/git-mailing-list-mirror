From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 05:37:47 -0500
Message-ID: <5370a47bee98c_139611a92fc29@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <53709788.2050201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1cw==?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, git-fc@googlegroups.com
X-From: git-owner@vger.kernel.org Mon May 12 12:48:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjnmp-0001yD-Hw
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 12:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbaELKsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 06:48:43 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:48197 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755553AbaELKsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 06:48:42 -0400
Received: by mail-ob0-f172.google.com with SMTP id wp18so7956690obc.31
        for <git@vger.kernel.org>; Mon, 12 May 2014 03:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=hsnTINqsqB8ICBp4lFWsIStLrNKGreLZH1q+wWBWupw=;
        b=HEJhuWKtZJlc1HQTkkxQAzQsv4Hcozf51fzebCBUnUnug/yreMAuNNu84m7tEO9zOK
         Tm0XRrVbeIE7/kpIEGOaRvJLqwi3KuKRjahfB+EOC2Vs/ox1vQ077BjDjko63ClRfTXj
         1vO/NqEotFFC3XfO8PpzgrZNu95BATbTSFOxt5FxDrO65Vc68OXkAanxTCpv6Vk6TA+5
         oyuJMyA+fE7xdOXCK1jW41DQf8F6hVxQoWQ+9xPnusTXD2rbBxwReJNV7KL1Wh2qWfHi
         vaStj2fSHh8asbzg6mQGoGl1uHUOKPOnm1fngMVlHx/he5TLapQaY21SHALMolC9kBy7
         qpzg==
X-Received: by 10.60.45.35 with SMTP id j3mr2298308oem.68.1399891722251;
        Mon, 12 May 2014 03:48:42 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e16sm19630105obs.26.2014.05.12.03.48.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 03:48:41 -0700 (PDT)
In-Reply-To: <53709788.2050201@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248697>

Michael Haggerty wrote:
> On 05/12/2014 01:34 AM, Felipe Contreras wrote:
> > Recently Junio said he was willing to hear the opinion of other people
> > regarding the move from contrib to the core[1]. This move is already
> > under way, but suddenly Junio changed his mind.
> 
> I agree with Junio.  There are good technical arguments for and against
> moving git-remote-hg out of contrib.

Saying you agree with Junio is content-free. You have to say *why* you
agree.

You mention there are good technical arguments against the graduation of
the tools. Surely if you have analyzed those arguments enough to form an
opinion aligned with Junio's, it should be easy to provide a short
summary of those "good technical arguments". Can you do that?

> 1. That subproject has not been maintained to the standards of the Git
> project;

The quality of the subjproject has not been called into question, stop
taiting the discussion with red herrings.

> 2. Moving git-remote-hg into the core would require even *more* of your
> presence on the Git mailing list.

That's not true. I sent my patches at my own pace, it doesn't matter if
they are in contrib or in the core, I would have kept sending them at
the same pace. I have addressed all issues and responded to all
questions as if they were already part of the core, which is why they
have more quality than other tools already in the core. I only stopped
doing that when Junio changed the direction we had since day one.

Also a red herring.

> > [...] Does it make sense to you that
> > you get thrown in jail for a crime you haven't committed merely because
> > someone thinks it's likely you will?
> 
> Being the leader of your own valuable open-source project is nothing
> like jail.  It is an opportunity for you to shine in an environment that
> is more suited to your personality.

Don't be ridiculous. There is no out-of-tree tool that could possibly
compete in popularity against core tools.

If you think being out-of-tree is not a negative, lets throw out
git-archimport, git-quiltimport, git-p4, git-cvs, git-svn. Let us give
them an "opportunity to shine".

You know that those tools do better in the core, and you know
git-remote-hg/bzr would do better in the core. Don't act as if you
didn't.

> This email is written in sorrow, not in anger.  Felipe, you seem to have
> so much potential.  If you would put as much effort in conducting social
> interactions as you do in coding, the whole balance would change
> entirely, and any software project would be happy to have you.  With all
> my heart I truly wish you the best in your future endeavors.

Let's see how sincere you are in your sentiment. I'll reply to you
personally about the points that I consider to be red herrings and ad
hominem attacks so we don't taint the dicussion. If you don't reply I'll
know you were not being sincere.

Cheers.

-- 
Felipe Contreras
