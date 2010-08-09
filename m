From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: wiki "abuse"
Date: Mon, 9 Aug 2010 20:55:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1008092055120.2983@bonsai2>
References: <AANLkTimyyh+MyS6zpJp1_RfCOoj6yr4LHXXM_7ZiWgzf@mail.gmail.com> <AANLkTi=wxre8pEDPQBeA4FvGcFHKS-kBdCqDv11o=x1c@mail.gmail.com> <AANLkTi=GmOokrPoevARoxe16ZLpHKzaBy0tBfycJM5J2@mail.gmail.com> <alpine.DEB.1.00.1008091820320.8314@intel-tinevez-2-302>
 <alpine.DEB.1.00.1008091824080.8314@intel-tinevez-2-302> <AANLkTi=12A8tGTgB+DvxuKT+q0fhnTy87EuCvNMrDkkd@mail.gmail.com> <alpine.DEB.1.00.1008092004450.2983@bonsai2> <AANLkTin3tQHLbsP0qr2tO4KovCY+Sg=DrSvDGt4t1Amy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2029280774-1281380140=:2983"
Cc: Valeo de Vries <valeo@valeo.co.cc>, git <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 20:55:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiXVk-0007JD-EI
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 20:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab0HISzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 14:55:42 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:43127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754348Ab0HISzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 14:55:42 -0400
Received: (qmail invoked by alias); 09 Aug 2010 18:55:40 -0000
Received: from pD9EB25D8.dip0.t-ipconnect.de (EHLO noname) [217.235.37.216]
  by mail.gmx.net (mp067) with SMTP; 09 Aug 2010 20:55:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8VZNS+3G8CQfR4ZwRznrEueWNrByuV0DA0LGmVZ
	PZh00oAbYXMHtT
X-X-Sender: gene099@bonsai2
In-Reply-To: <AANLkTin3tQHLbsP0qr2tO4KovCY+Sg=DrSvDGt4t1Amy@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152998>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2029280774-1281380140=:2983
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 9 Aug 2010, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Aug 9, 2010 at 18:08, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Mon, 9 Aug 2010, Valeo de Vries wrote:
> >
> >> Banning users without letting on what the rules are isn't very polite,
> >> or productive for that matter.
> >
> > When in Rome, do as the Romans do. Going about in Rome, spitting
> > everywhere, is rude, even if it is considered polite in your home country.
> 
> Going to Rome and introducing yourself would probably be more
> analogous in this case, and then being kicked out when you find the
> Romans don't care :)
> 
> Anyway, people are wont to treat things they've seen in the past the
> same, and most wikis have and encourage user pages & associated talk
> pages.
> 
> If the Git wiki doesn't want them that could be advertised more
> prominently, here are some suggestions:
> 
>   * Change this to cite some community rules page or whatever, it's
>     what users see when they sign up:
> 
>         https://git.wiki.kernel.org/index.php/MediaWiki:Welcomecreation
> 
>   * Disable links to talk / user pages, e.g. I have this (incomplete)
>     thing in a LocalSettings.php for a wiki that doesn't want talk
>     pages:
> 
>         // No user/talk for anonymous users
>         $wgShowIPinHeader = false;
> 
>         $wgHooks['SkinTemplateNavigation'][] = 'vfRemoveWikiLikeLinks';
>         function vfRemoveWikiLikeLinks( &$sktemplate, &$links ) {
>             // Remove talk page links
>             unset($links['namespaces']['talk']);
>         }
> 
>     I have some other stuff, but it's mostly specific to the Vector
>     skin (the Git wiki uses monobook). You can also add a page view
>     hook that redirects users visiting User_talk:* or User:* pages to
>     some page explaining that they're not wanted using similar hooks.
> 
>     Having two red links on every page on the wiki saying
> 
>        "There is currently no text in this page. You can search for
>         this page title in other pages, search the related logs, or
>         *edit this page*."
> 
>     Is a pretty big invitation to edit your userpage.
> 
>   * Add something to your user / user talk page (since you're an
>     admin) indicating how to contact you, e.g.:
> 
>         Hi. I'm an admin here. Please don't use this page to message
>         me, but
>         [https://git.wiki.kernel.org/index.php/Special:EmailUser/Dscho
> send me an E-Mail]
>         instead.
> 
> And I'm sorry that I called you an "out of control admin" in an
> earlier mail, that was uncalled for.
> 
> But I do think it's important that we as a project try to project a
> friendly attitude to newbies. Doing thankless admining is hard, but
> how we (people helping on IRC, the list, the wiki etc) talk to and
> interface with new people interested in Git can have a lot of positive
> or negative effect on the reputation of the project.
> 
> In this case it sounds like the problem can be solved in the long term
> with some software modifications to the wiki, I happen to have some
> experience with MediaWiki, and I'd be happy to help with that.

I welcome you warmly to do all that.
--8323329-2029280774-1281380140=:2983--
