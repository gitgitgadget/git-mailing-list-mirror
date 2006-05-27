From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: ~/.git/config ?
Date: Sat, 27 May 2006 10:50:13 +0200
Message-ID: <dbfc82860605270150s5c43e32fja2e7ef934bc1ef0@mail.gmail.com>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
	 <20060526193325.d2a530a4.tihirvon@gmail.com>
	 <20060526163829.GB10488@pasky.or.cz> <1148697382.5599.1.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Timo Hirvonen" <tihirvon@gmail.com>,
	"Anand Kumria" <wildfire@progsoc.uts.edu.au>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 10:50:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjuV5-000549-Mj
	for gcvg-git@gmane.org; Sat, 27 May 2006 10:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWE0IuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 04:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWE0IuP
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 04:50:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:39625 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750711AbWE0IuO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 04:50:14 -0400
Received: by wr-out-0506.google.com with SMTP id i21so206501wra
        for <git@vger.kernel.org>; Sat, 27 May 2006 01:50:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=gqgNMYxomLkqAmB55JmnGQdCLBS99XFQJr0nWlg8LCNGsuYlvFlQzb+eb47OLJkZWrUvin1Wws+QIz/7torDWbFMuNTma3auUu5c5PRPpFZUl63Dbc3g5gY6ifXpTpTwlRZ+B6a/lP7r6ezECzwkvkEIzW73ndAXD4BhmukD1SU=
Received: by 10.65.72.19 with SMTP id z19mr96305qbk;
        Sat, 27 May 2006 01:50:13 -0700 (PDT)
Received: by 10.64.142.12 with HTTP; Sat, 27 May 2006 01:50:13 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1148697382.5599.1.camel@dv>
Content-Disposition: inline
X-Google-Sender-Auth: 8dcca068e43fe48d
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20837>

On 5/27/06, Pavel Roskin <proski@gnu.org> wrote:
> On Fri, 2006-05-26 at 18:38 +0200, Petr Baudis wrote:
> > Dear diary, on Fri, May 26, 2006 at 06:33:25PM CEST, I got a letter
> > where Timo Hirvonen <tihirvon@gmail.com> said that...
> > > I backup my $HOME using git, so there's a .git directory in ~.
> >
> > Then it should be called ~/.gitconfig. :-)
>
> No, make it .gitrc for compatibility with .cvsrc, .lynxrc and others.
>
> I know, it's becoming a bikeshed issue :-)

I want to paint part of it as well!

Wouldn't we be futureproofing ourselves by stuffing it in a
subdirectory instead?  What if we want to add more files later?

Also, can we please make sure to make the location of the file (or
directory) configurable through an environment variable, e.g.,
GIT_CONFIG, GIT_USER_CONFIG, GIT_HOME, or GIT_USER_HOME?

Peace.

  nikolai
