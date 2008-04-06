From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] alias.c: use git_config_string() to get alias_val
Date: Sun, 6 Apr 2008 15:29:23 +0200
Message-ID: <200804061529.24083.chriscool@tuxfamily.org>
References: <20080405121834.GB14565@leksak.fem-net> <200804060749.34109.chriscool@tuxfamily.org> <20080406110232.GA6965@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Apr 06 15:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiUra-0005ra-A6
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 15:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbYDFNYD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2008 09:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbYDFNYB
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 09:24:01 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:60526 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbYDFNYB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2008 09:24:01 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 89FD31AB2EF;
	Sun,  6 Apr 2008 15:23:59 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6D4681AB2CC;
	Sun,  6 Apr 2008 15:23:59 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <20080406110232.GA6965@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78890>

Le dimanche 6 avril 2008, Stephan Beyer a =E9crit :
> Hi,
>
> > So you should say in the commit message that you decided to cast to
> > "const char **" despite what is on the Janitor page, and most
> > importantly explain why in the commit message.
>
> Ah, ok.
> Didn't knew that such reasoning goes into the commit message,
> but, yes, it makes sense.
>
> > > But instead of doing that, the original should be kept, because i=
t is
> > > better in code beauty, performance and memory usage. ;-)
> >
> > Yes, so perhaps it's not a good idea to convert the original file t=
o
> > git_config_string.
>
> Or to use the cast. ;-)
>
> [...]
>
> > But I don't think it's worth the trouble.
>
> I agree ;-)
>
> So what to do?
> Keep it?

No, I think its better to do nothing on "alias.c".

> And there are still some easy `Janitor tasks', like in builtin-apply.=
c:

Yes. And thanks, your patch looks good, but please send a proper patch =
for=20
it latter if you really care about it.

(By proper I mean in its own email and not attached. And I know my patc=
h=20
included in my previous email was bad (corrupted tab, sorry about that,=
 =20
and not in its own email), but it was only for discussion, yours too=20
granted.)

Now I think that you should focus on your GSoC application as you don't=
 have=20
much time left to improve it and I just asked you for more information.

Thanks,
Christian.
