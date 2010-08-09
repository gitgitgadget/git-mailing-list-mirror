From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: wiki "abuse"
Date: Mon, 9 Aug 2010 18:43:25 +0000
Message-ID: <AANLkTin3tQHLbsP0qr2tO4KovCY+Sg=DrSvDGt4t1Amy@mail.gmail.com>
References: <AANLkTimyyh+MyS6zpJp1_RfCOoj6yr4LHXXM_7ZiWgzf@mail.gmail.com>
	<AANLkTi=wxre8pEDPQBeA4FvGcFHKS-kBdCqDv11o=x1c@mail.gmail.com>
	<AANLkTi=GmOokrPoevARoxe16ZLpHKzaBy0tBfycJM5J2@mail.gmail.com>
	<alpine.DEB.1.00.1008091820320.8314@intel-tinevez-2-302>
	<alpine.DEB.1.00.1008091824080.8314@intel-tinevez-2-302>
	<AANLkTi=12A8tGTgB+DvxuKT+q0fhnTy87EuCvNMrDkkd@mail.gmail.com>
	<alpine.DEB.1.00.1008092004450.2983@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Valeo de Vries <valeo@valeo.co.cc>, git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 09 20:43:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiXJt-0001KJ-Af
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 20:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab0HISn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 14:43:27 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57441 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab0HISn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 14:43:26 -0400
Received: by yxg6 with SMTP id 6so3514767yxg.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 11:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=DrDWzhZGFANxvtqvjVN68S6tma+8uv0poAxLAHk0W1E=;
        b=OZsILpBavI/ZByomeKba8Uhl/FAxxxwAJWXrNR9z24/gvPifd8hPPA67ckJCiU0IXy
         if105rndgfFg3FDOgYmzbCC4tn48xIDHVRMBk/nPfWMw7S5d3UW8co1yLkQnj70HI9Z+
         AoHrpPh/1KPug+q57nmgFIMDi7Fh10ZGI89pI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kOhSzpWJZWkopMGGL+1F5sJIlNd542L1f9zHopIfx7xa7Rj+I139N+PEC6XOwVJolY
         jQL+iqPJvWSK/fgMxk7/3wrV8ueUha5djV1xX8NLk3ScH9+34tIbrsr7+WOh9StKPWEb
         OZC1a0Rx1SQcQTFXras3BIcrtxxleRDbBJzz8=
Received: by 10.231.32.200 with SMTP id e8mr19349261ibd.66.1281379405514; Mon, 
	09 Aug 2010 11:43:25 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Mon, 9 Aug 2010 11:43:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1008092004450.2983@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152997>

On Mon, Aug 9, 2010 at 18:08, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 9 Aug 2010, Valeo de Vries wrote:
>
>> Banning users without letting on what the rules are isn't very polite,
>> or productive for that matter.
>
> When in Rome, do as the Romans do. Going about in Rome, spitting
> everywhere, is rude, even if it is considered polite in your home country.

Going to Rome and introducing yourself would probably be more
analogous in this case, and then being kicked out when you find the
Romans don't care :)

Anyway, people are wont to treat things they've seen in the past the
same, and most wikis have and encourage user pages & associated talk
pages.

If the Git wiki doesn't want them that could be advertised more
prominently, here are some suggestions:

  * Change this to cite some community rules page or whatever, it's
    what users see when they sign up:

        https://git.wiki.kernel.org/index.php/MediaWiki:Welcomecreation

  * Disable links to talk / user pages, e.g. I have this (incomplete)
    thing in a LocalSettings.php for a wiki that doesn't want talk
    pages:

        // No user/talk for anonymous users
        $wgShowIPinHeader = false;

        $wgHooks['SkinTemplateNavigation'][] = 'vfRemoveWikiLikeLinks';
        function vfRemoveWikiLikeLinks( &$sktemplate, &$links ) {
            // Remove talk page links
            unset($links['namespaces']['talk']);
        }

    I have some other stuff, but it's mostly specific to the Vector
    skin (the Git wiki uses monobook). You can also add a page view
    hook that redirects users visiting User_talk:* or User:* pages to
    some page explaining that they're not wanted using similar hooks.

    Having two red links on every page on the wiki saying

       "There is currently no text in this page. You can search for
        this page title in other pages, search the related logs, or
        *edit this page*."

    Is a pretty big invitation to edit your userpage.

  * Add something to your user / user talk page (since you're an
    admin) indicating how to contact you, e.g.:

        Hi. I'm an admin here. Please don't use this page to message
        me, but
        [https://git.wiki.kernel.org/index.php/Special:EmailUser/Dscho
send me an E-Mail]
        instead.

And I'm sorry that I called you an "out of control admin" in an
earlier mail, that was uncalled for.

But I do think it's important that we as a project try to project a
friendly attitude to newbies. Doing thankless admining is hard, but
how we (people helping on IRC, the list, the wiki etc) talk to and
interface with new people interested in Git can have a lot of positive
or negative effect on the reputation of the project.

In this case it sounds like the problem can be solved in the long term
with some software modifications to the wiki, I happen to have some
experience with MediaWiki, and I'd be happy to help with that.
