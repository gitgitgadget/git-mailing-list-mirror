From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 07:41:43 -0800
Message-ID: <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
 <20110112182150.GC31747@sigill.intra.peff.net> <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
 <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com> <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tor Arntsen <tor@spacetec.no>, JT Olds <jtolds@xnet5.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 14 16:42:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdlnJ-0001mk-GU
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 16:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582Ab1ANPmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 10:42:25 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42804 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751539Ab1ANPmX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 10:42:23 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0EFg48Z012377
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 14 Jan 2011 07:42:04 -0800
Received: by iyj18 with SMTP id 18so2608141iyj.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 07:42:04 -0800 (PST)
Received: by 10.231.35.204 with SMTP id q12mr800114ibd.191.1295019724227; Fri,
 14 Jan 2011 07:42:04 -0800 (PST)
Received: by 10.231.31.72 with HTTP; Fri, 14 Jan 2011 07:41:43 -0800 (PST)
In-Reply-To: <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
X-Spam-Status: No, hits=-2.194 required=5 tests=AWL,BAYES_20
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165107>

On Fri, Jan 14, 2011 at 1:53 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>
> Linus, you wrote sanity_check (from 2744b23). Do you remember if there
> were any specific reason for the minimum length of 3 of an
> author-name? It seems that in Sweden, legal names can be even a single
> letter (see Tor's comment)...

Even if the legal name would be a single letter, you'd still need to
have a surname.

The three-letter minimum is just a sanity check. If your name really
is even just three letters, I suspect you're just lying. I don't know
of anybody named "A B".

That thing is supposed to be a *NAME*. Not shorthand. Not your first
name. Not your nickname. If you have a nickname, put it in quotes
inside the real name.

I've seen too many broken source control systems that just take your
login as a name *cough*CVS*cough*, and then people think it's
"convenient" and "cool" to have a short name.

It's not convenient. It's not cool. It's just shorthand where
shorthand doesn't help. Then you end up using it in a public setting,
and suddenly your cool shorthand or nickname isn't even remotely
unique.

No, there is no uniquness "requirements" for the name, but come on.
Look at shortlog output some day. We try to use just the name because
it looks better. But if people don't use their full name, it just
looks _stupid_

                                    Linus
