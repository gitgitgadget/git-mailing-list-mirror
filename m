From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 21:48:39 +0200
Message-ID: <CAEcj5uXHxvo90bP8GC5hDLBz4HZhg1JV4jHUSWnbSNhnjtCH=g@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<51AEBAEF.6090402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 06 21:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkgAw-0004LA-9S
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 21:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab3FFTsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 15:48:42 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:40036 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656Ab3FFTsk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 15:48:40 -0400
Received: by mail-qa0-f47.google.com with SMTP id i13so413550qae.13
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 12:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GAQiKSDMShqRWFQjVEFaK0aabof2tzR0S1FhAchx/AY=;
        b=kJL0ciCb/eMU29Tjngy7A43Eh8Ark1eX9E9wBOL7FBGECshwOoVy7Cu2jJnXmHhuaw
         czg7TG7cH9K2280t8+H9363ROs6T+/ekd1Scx2hXiH3593QOmJu0nxipF3SwclmErHRw
         6TqF87+ldrmhqOJ2mMHyrin2She6ywl5KvvXU9aC+9Vfnku/Y4JSn/5Bmq0TVyIKlT5o
         AzZTpjiKBqonR2F1jFyc+dyxPGOKRC3UOze0Aurk+1YlERMPIy4P4Woz79LqnerH+wRZ
         Xi3jYluQHGgZFtvvbv1pKDQMSlFGeLlWgR8faBSteD/wQCRDvvyU5MvDTUOgAYvd80/k
         xcYQ==
X-Received: by 10.229.105.84 with SMTP id s20mr1961603qco.111.1370548119553;
 Thu, 06 Jun 2013 12:48:39 -0700 (PDT)
Received: by 10.49.95.233 with HTTP; Thu, 6 Jun 2013 12:48:39 -0700 (PDT)
In-Reply-To: <51AEBAEF.6090402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226553>

On Wed, Jun 5, 2013 at 6:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> But my main point is that I think it would be easier to phase out
> contrib/ if there were a good alternate way of providing visibility to
> "satellite" projects.  The relevant Git wiki page [1] is the most likely
> candidate, but it is a bit overwhelming due to its size, it has fallen
> into disuse because it was broken for such a long time, and it is not
> prominently linked to from git-scm.com.  If it were curated a bit, it
> would help users find the best ancillary tools quickly.  Perhaps ranking
> the tools based on the results of the Git user surveys would help bring
> the most popular to the top of each category.
>

One idea here could be to mirror what the libgit2 project [1] (and many
others) are doing on GitHub. Use the organization unit [2] as an umbrella
for the contrib projects. If necessary, put a pretty web-page on top [3].

Of course you don't have to tie it to GitHub, but they do have some nice
mechanisms for showing off popularity (stars and forks).

I heard that clojure/contrib [4] went through a big clean-up recently,
although I'm not sure if there was an equivalent reasoning behind it. But
their guide-lines on what should go into contrib may have some good
ideas [5].

[1] https://github.com/libgit2
[2] https://github.com/git
[3] http://libgit2.github.com/
[4] http://dev.clojure.org/display/design/Where+Did+Clojure.Contrib+Go
[5] http://dev.clojure.org/pages/viewpage.action?pageId=5767464
