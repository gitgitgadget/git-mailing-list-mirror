From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Commit signing
Date: Tue, 16 Jan 2007 07:36:14 +1300
Message-ID: <46a038f90701151036k7b9ee5e2sdd3bbf6d69f9a27c@mail.gmail.com>
References: <200701151000.58609.andyparkins@gmail.com>
	 <200701151042.12753.andyparkins@gmail.com>
	 <20070115105616.GE12257@spearce.org>
	 <200701151141.51659.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 21:09:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Wgt-0006ae-Ry
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 19:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbXAOSgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 13:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbXAOSgQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 13:36:16 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:24629 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbXAOSgP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 13:36:15 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1846548wxd
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 10:36:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mMgLMUSWc7YRApBVKk4DQfQP3SQfGRXS2cA9KJylnTIoTzYvp2ztIWzh2N5DxEHdqxXGS/egFFfwvrkzqv022NxdlEYexjF2qLycf7o0nKxkD+jxVmqU0vnuS3rN1lvq8/Rzss3nHmW8DLp8ot7Xv7ZibOMUjzypVGWqMUMPI/Y=
Received: by 10.90.25.3 with SMTP id 3mr3233500agy.1168886174406;
        Mon, 15 Jan 2007 10:36:14 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Mon, 15 Jan 2007 10:36:14 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
In-Reply-To: <200701151141.51659.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36875>

On 1/16/07, Andy Parkins <andyparkins@gmail.com> wrote:

> What about this set of repositories
>
>  Central - Maintainer - Lieutenant - Subsystem Maintainer - Idiot - Vandal
...
>  * Vandal spends one year developing reasonable relationship with Idiot, all
>    patches are good.  Occasional big patches are pulled by Idiot.

If you are using signatures, the trojan horse would make sure he gets
his patches signed. What is the advantage again?

>  * Vandal prepares extra big series of commits, with ostensibly good
>    functionality.  In the middle of large series adds one small commit with
>    the committer set to someone other than himself.  In fact, he sets it to be
>    someone he doesn't like.

How about
 - not pulling without review
 - pulling only "own" patches from peripheral developers

> Well yes.  I personally wouldn't bother, but I'm casting myself in the role
> of "paranoid" maintainer for this discussion.

And if you are so paranoid, then you review, and mandate that all
patches get a lot of reading ;-) because bugs slip in due to idiocy a
whole lot more than because of trojans. Maybe you force patches to be
sent to a mailing list, discussed and merged in only if they survive
the hard-assed review. Like it happens with git or linux.

> The answer is: no, you can't put your 100+X commits in my repository because I
> don't trust the person who wrote X of them.  It is paranoid, and it is
> overkill, but it is also /my/ repository.  It might also be that you are my
> employee and you will do as you are damn well told.
>
> I'm arguing that git should cater for the borderline sociopath as well as the
> well adjusted developer as well.  After all, PHB's need version control
> too :-)

Architecturally, you can't rewrite history just like that -- merge
skipping patches isn't possible. You _can_, however, cancel a merge
because something looks fishy.

> In the case above, it is the distributed nature of git that causes the
> problem, the original comitter is Idiot, but the repository that the changes
> use to get into central is Maintainer's.

IIRC Linus discussed this early on, and his view was that authorship
only gives you false security. The only security is in reviewing code.
And that the code-signed patches are dog-slow too.

cheers,



martin
