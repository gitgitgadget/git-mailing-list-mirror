From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: GSoC 2008 - Mentors Wanted!
Date: Thu, 6 Mar 2008 11:19:19 +0600
Message-ID: <7bfdc29a0803052119s75613e05qe2ab57d4c454e763@mail.gmail.com>
References: <20080304051149.GS8410@spearce.org>
	 <20080305053612.GA8410@spearce.org>
	 <7bfdc29a0803042358n6126286dr7a17f3b4dadbabe5@mail.gmail.com>
	 <200803052213.20501.robin.rosenberg@dewire.com>
	 <20080306050846.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>,
	"Carlos Rica" <jasampler@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 06:20:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX8WO-0004M7-8G
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 06:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbYCFFTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 00:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbYCFFTW
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 00:19:22 -0500
Received: from hu-out-0506.google.com ([72.14.214.228]:47133 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbYCFFTV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 00:19:21 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1204737hue.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 21:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=99xJQ53TaGIhvkRtHe68zNwdHA9EKqCTP0ql9M7eawA=;
        b=Y8L2jjLGq+BtMXUh9EYfv7TeECMbUYM//SBnaCRCvNyUgwsm2Ip920+SxkhWi6wdRcVd4HT35b4Q3ObHTbuas+b+qQ8FgK1kI/m1JJbkGAppHbwc2iuehQBT2BG3Yec7QjOJVbkMtMRo8BAJn7x5dsyt7hZPED0SzMXquNUuBJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JpzbiLdJ2OLybnSfI0cMckxjIAmJKG+RVO4EbFcLhP3xaNjCosAx5Vf7JfUfdwQdq8udUtCml5+Vy55R5zZDfJO5oD1z1zwGR/wyse3hQM/gtRJzai3F/TmzkcovPlUTMReaKjSbHlkZZRetekeOV88ZC0yNu/jWEo8fjsBIqa8=
Received: by 10.78.195.10 with SMTP id s10mr9129999huf.10.1204780759427;
        Wed, 05 Mar 2008 21:19:19 -0800 (PST)
Received: by 10.78.75.8 with HTTP; Wed, 5 Mar 2008 21:19:19 -0800 (PST)
In-Reply-To: <20080306050846.GQ8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76333>

On Thu, Mar 6, 2008 at 11:08 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
>  >
>  > You will find support in jgit for this today. Cloning over git and ssh real
>  > soon. I'm clensing the oopses from the history right now. (bless rebase -i
>  > and git-gui).
>
>  I'm sort of waiting to see this fetch history soon.  :-)
>
>  The reason is I just got index v2 support (runtime read side) completed
>  and I want to add index v2 generation to IndexPack.  I also want to start
>  building a PackWriter so we can work on native transport push over SSH.
>
>  If we get fetch/push running I think we are heading into the area
>  where it is of some real use to people.
>

It is great to hear this news :).

>
>  > There might be some operations that might be harder to do well in Java. For
>  > those exec'ing might be the solution, I'm thinking repack, but then I haven't
>  > tried it yet.
>
>  I'm determined to even get "proper" packfile generation in Java.
>  But it may be time consuming to build.  There may be license issues
>  around doing a direct cribbed port of the delta generation.  :-\
>
>
>  > In general jgit is almost as fast as git and probably
>  > outperforms git on windows as git there doesn't use  memory mapped I/O for
>  > packs (something I'd expect someone or even me to fix soon). For JNI'ed
>  > operations the complexity is just horrible and even when possible, there is
>  > a lot of overhead for JNI itselt, conversion from UTF-16 to somehing
>  > eightbitish and back. On windows there's even yet another layer of
>  > eight-bitish to UTF-16 and back in the Win32 API. Jgit also uses memory
>  > mapped I/O on all platforms that support it for pack reading.
>  >
>  > If someone *did* make a fully reentrant libgit, I'd be inclined to balance my
>  > opinions differently.
>
>  Really?  If jgit is basically as fast as C git, but doesn't have
>  the overheads of dropping in and out of JNI or fork/exec then you
>  can actually get pretty good performance out of a Java application.
>
>  I've never really liked doing JNI.  I try to avoid it whenever
>  I possibly can.  JVMs just don't seem to be all that happy about
>  loading other native code into them, but yet they can do some very
>  good optimizations when everything is 100% pure Java and the JIT
>  has free reign to do what it pleases.

I personally too avoid JNI whenever possible; the only reason I was
even thinking of JNI in the first place is just to keep in touch with
the latest developments of jGit. But seeing the enthusiasm of the
community to contribute in developing a 100% Pure Java Git, I will
also participate in development of jGit; I think if we can get it to
do the regular operations we can generate enough interest to get a
community to regular keep it in sync with git.

>
>  --
>  Shawn.
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557
