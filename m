From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] better git-submodule status output
Date: Mon, 7 Jul 2008 11:36:12 -0400
Message-ID: <32541b130807070836n5c6efadu184114f7ed1476e0@mail.gmail.com>
References: <20080701150119.GE5852@joyeux>
	 <7vhcb3o7q3.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0807061456100.3486@wbgn129.biozentrum.uni-wuerzburg.de>
	 <20080706160758.GA23385@jhaampe.org>
	 <alpine.DEB.1.00.0807061821340.7342@eeepc-johanness>
	 <20080707062142.GA5506@jhaampe.org>
	 <32541b130807070725p6fa4d0dfne9f04bc857920dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807071533240.18205@racer>
	 <32541b130807070757s4ba03e28tf4701f479e27b687@mail.gmail.com>
	 <alpine.DEB.1.00.0807071621300.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sylvain Joyeux" <sylvain.joyeux@dfki.de>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Lars Hjemli" <hjemli@gmail.com>, "Ping Yin" <pkufranky@gmail.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 17:37:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFsm8-0001dz-HY
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 17:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbYGGPgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 11:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbYGGPgO
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 11:36:14 -0400
Received: from rn-out-0910.google.com ([64.233.170.188]:34188 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbYGGPgN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 11:36:13 -0400
Received: by rn-out-0910.google.com with SMTP id k40so367494rnd.17
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0ukTGDdkd6/JklgbmE9xUGR8PGh1yoH6IBwSQnsn9f4=;
        b=vabT32kl9PRuWFUqrB+/Sj3aI+jAaKIYmW/tDCiwnh1RL6GE7t6eMW/zxQHTSivnjc
         qR1rKOteOw2hq5+VXO6cJwKp4g0KEK4KFKPH6zvHjWFwW1bnRrXz+Y3Ss6ijmeqAvBkl
         Cnx+AcjS5XKudzsJr9IkIvRlUOcFuf0W+qRFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FZashpuYEehf45V2nhdRLB1eA5shNaFzQGr0Tm2JBUcdSqkqxwSl/6FNQ5BKR1T8OY
         QiJBjyZxCxWPpZG0mlBKrjBU/mHy78bZpaK/4SaFillWEP/7GcZEPHq2Jbn4GAWs6aIj
         albuAvl+KktRt7t8duwEE2RtBawGVEdr6nBdI=
Received: by 10.151.144.4 with SMTP id w4mr8350260ybn.234.1215444972683;
        Mon, 07 Jul 2008 08:36:12 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Mon, 7 Jul 2008 08:36:12 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807071621300.18205@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87627>

On 7/7/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Mon, 7 Jul 2008, Avery Pennarun wrote:
>  > Hmm... how does doing a fetch wreck your state?
>
> It updates the tracking branches.  And guess what I use the tracking
>  branches for?  Yes, to track other people's changes.
>
>  It would wreck my state.
>
>  Anyway, fetch is wrong, wrong, wrong, if all you want to do is see the
>  _state_ of your submodule.
>
>  If that state is that the superproject has a commit that the submodule
>  knows nothing about, then that is _exactly_ what needs to be reported.
>
>  Don't play cute games,

Hmm, somehow we're not understanding each other here.

I think we have already agreed that "git status" and/or "git submodule
status" are obviously not good times to be fetching things.  And a
perfectly valid "submodule status" is that your submodule can't be
updated because you're missing some objects and should fetch.

What I suggested was to recursively do "git fetch" in submodules at
the time of doing fetch or pull operations on the supermodule, in
order to help ensure that all necessary objects have been fetched.  To
reference an earlier email of yours, this would *improve* git's
usability for people who try to use it on a plane, by reducing the
number of cases where they have forgotten to fetch.

(1) Do you think fetching missing submodule objects when fetching the
supermodule is a bad idea, or a good one?  (2) On top of that, do you
think updating the submodule's refs when I do "git fetch" in the
supermodule is a good one (it seems you think it don't)?  (3) And on
top of that, if either of those is a good idea, should it be a config
option?  (4) And should that option default on or off?

In case anyone cares about my preferences, I think (1) makes sense,
(2) is probably too dangerous, (3) should be yes, or perhaps people
should be taught to run "git submodule fetch" to fetch submodules and
leave "git fetch" alone, and (4) if it's configurable, it should do it
by default, because in 99% of situations I can imagine, fetching a
supermodule and not fetching its referenced submodule commit will not
be useful behaviour.

Thanks,

Avery
