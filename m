From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: cvsimport error: need a valid pathname
Date: Sun, 28 Aug 2005 03:37:48 +1200
Message-ID: <46a038f905082708371719121c@mail.gmail.com>
References: <874q9bcu6d.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 17:39:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E92lE-0005fn-CA
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 17:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVH0PiT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 11:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVH0PiT
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 11:38:19 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:5445 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751235AbVH0PiS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2005 11:38:18 -0400
Received: by rproxy.gmail.com with SMTP id i8so743713rne
        for <git@vger.kernel.org>; Sat, 27 Aug 2005 08:38:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sUnYVgTReQN3D6YXGr8u21xQ6/VncvOfLgfDCVfN3+5VEFNsHu5T4hmzF913EWL+6C3hfWpLWt1DpAEV80mSDF0UpHohAOb+w9DDRkiVyo/yo2WglFbnY3+NntaPFIIr2qvGTIFy528zCUaMmTqqfjx7fxDxTJnqsEUWsP1qOr8=
Received: by 10.38.11.11 with SMTP id 11mr2317510rnk;
        Sat, 27 Aug 2005 08:38:18 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Sat, 27 Aug 2005 08:37:48 -0700 (PDT)
To: Kalle Valo <Kalle.Valo@iki.fi>
In-Reply-To: <874q9bcu6d.fsf@litku.valo.iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7850>

On 8/28/05, Kalle Valo <Kalle.Valo@iki.fi> wrote:
> The documentation says that it should be possible to update
> incrementally from the CVS repository. Am I doing something wrong or
> is this a bug?

It _should_ work the way you are running it, so consider it a bug. Do
you think you can do some tinkering/debugging to tell us some more?
Otherwise. how large is the cvs repo?

(Debugging this kind of stuff, when it only fails on a specific repo,
is tricky and time-consuming. Any help we get is _really_ appreciated.
I have imported many trees, and several of them I am tracking -
importing new commits on a daily basis - without much trouble, except
for invalid/force-moved tags.)

cheers,


martin
