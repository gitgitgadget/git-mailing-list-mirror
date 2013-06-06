From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 01:59:48 +0530
Message-ID: <CALkWK0mwxfGJdZi6kSaAPr66o550RiT_p8_r_4mDvcd_VAFYQw@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Thu Jun 06 22:30:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkgpO-0005zX-KB
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 22:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab3FFUaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 16:30:30 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:60227 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab3FFUa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 16:30:29 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so8447176ied.14
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nfi1+mdx3l3wqOzU9C5gNXp7OzRttloce0YdS6/El+g=;
        b=HsXf9VrYWDPudh3RF3HtuVSBkp7ShpNQHARtc6aI7iGDDXzFRcp8rm3aBmvpAXjply
         cTDHvpn0pfJzaahRx6ClR4a9Ud8UvMc87S0wpNFnHK2X18QxaIkOjOe++f3Pix6rd9ZE
         wr32CAjk8CI1qsav+QJlMmvwVzNF7bXnW3HsOEKsYAjcGPww7YA6oN+eoefLzKdtB89d
         kyoobffKnvoo3a/EH49PkUq4DXO6d0DzGW3s6DJLos5dkKIiewR11TXnObl4cdvrbGvc
         WygRKhV7oP5ONmaEkmtvczUNOhZMPTlSSZGx817fS2sWmoMHLCpmRqHfhunC+nGA4Gys
         OBZA==
X-Received: by 10.50.107.6 with SMTP id gy6mr6422310igb.57.1370550628988; Thu,
 06 Jun 2013 13:30:28 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Thu, 6 Jun 2013 13:29:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1306060904100.13204@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226554>

David Lang wrote:
> Perl use may or may not be declining (depending on how you measure it), but
> are you really willing to take on the task of re-writing everything that's
> in Perl into another language and force all developers of scripts to learn
> that other language? what's the ROI of this?

Let's not talk hypotheticals.  git-svn.perl (+ perl/SVN/*.pl) is
absolutely massive.  It's an incredibly useful tool in that it
actually works, and that there is nothing replacing it in the
foreseeable future.  This monster was written almost entirely by one
brilliant person, and nobody is going to rewrite it.  We don't start a
huge discussion about what languages are "approved" before accepting
such a contribution: if the contributor wants to write something in a
dominant language (Perl in this case), and it's going to be useful, we
merge it.  End of story.

All this planning is a colossal waste of time, in my opinion.

> Perl isn't going to disappear any time soon. What makes you think that
> whatever language you pick to replace Perl is going to be more stable than
> Perl is?

Why are we discussing something that is indeterminate?  It is
impossible to foresee the future, but that is no reason to freeze
_present_ development.

> and, like the parent poster, by 'stable' I mean from the compatibility point
> of view.

Various programming languages have different philosophies, and have
grown in different ways.  What matters is that some of them have a
large number of users, and we're talking about one such example.

> What are the odds that the 'newer' language that you pick is going to pull a
> "python 3" on you?

This has to be a rhetorical, because I don't imagine you expect anyone
to predict the future.  As Felipe already pointed out Ruby 2.0 is a
good sign.

> There have been a very large number of scripting languages show up, make a
> lot of press, and then fade in favor of other languages while Perl has
> continued. It's not the sexy languange nowdays, but it's there, reliable,
> and used so heavily that there's really no chance of it dissapearing in the
> forseable future.

Nobody claimed that "press coverage" is a good metric.  We can only
talk about facts, and Felipe already showed you a TIOBE index graph.
If you have overwhelming _evidence_ that Ruby is a weak language that
will die soon, share it: otherwise, I see no value in this discussion.
