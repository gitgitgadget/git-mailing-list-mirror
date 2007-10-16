From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: cogito and remote#branch, was Re: [PATCH] Git homepage: remove all the references to Cogito
Date: Wed, 17 Oct 2007 00:16:25 +0200
Message-ID: <2c6b72b30710161516j5c029847r1acb3ce2d88344a1@mail.gmail.com>
References: <20071015233800.6306e414@paolo-desktop>
	 <20071016021933.GH12156@machine.or.cz>
	 <Pine.LNX.4.64.0710161139530.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 17 00:16:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhuiN-0008SP-DX
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964958AbXJPWQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933875AbXJPWQ2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:16:28 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:38775 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933848AbXJPWQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 18:16:27 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1556490rvb
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ADztXV1ytmeyUPyuZNC30gy6S89dIxL1qbP8uT9Ch4w=;
        b=qk4antcePaEGE1cj3Hod5fE6KK2Y61zBweEqd5kGzelgw9H2RcrDvKHH7c3VMHRAxgHsBDrE6yFB95PCsAxroZkvMKdVWhkGP3FAn9Ahf6pzR+VPBQ5JQ84ZRRco5ij5ssoUbHSTcihSRZcw3owB9HMlRlhYvrNig1UN0zCZ1nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LQdPdglzfHgpk7LtTzz+dqZUHeI9ugMe6U2xV5XBEGQbtuplFxwAOvcrMT22Mdd4i5xpmGApIIBfdVJBN5+EuP30z2me+S4WuHnPEqR1eE5k1bq4rT6Y4d2idVL5vL9CrhU8wZQA4CaPxrSjOqbR8Wm+9nKaZXbGv0cO7vKr/Cw=
Received: by 10.141.41.12 with SMTP id t12mr3829712rvj.1192572985607;
        Tue, 16 Oct 2007 15:16:25 -0700 (PDT)
Received: by 10.141.13.18 with HTTP; Tue, 16 Oct 2007 15:16:25 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710161139530.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61265>

On 10/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 16 Oct 2007, Petr Baudis wrote:
> > I'm not sure this is good idea, Cogito is still quite frequently used
> > and it should be documented that it exists.
>
> I agree.  But maybe it could be marked as unmaintained?  Maybe someone
> steps up to maintain it.  Or, even better, comes up with a list of "this
> is what I like do regularly with cogito, but there's no easy way with core
> git" issues.

One thing that I occasionally miss is

  cg-export /path/to/directory/

And yes, I know it can be accomplished via "obscurities" like
git-archive+tar (or worse git-checkout-index) but I think having
an easy way to checkout to a directory could be great (and possibly
with the ability to apply substitutions with the recent discussion).

Else, I am really looking forward for the option parser work to provide
an easy way to list options. I found it very useful with Cogito.
Also, most of the "status" commands in Cogito seemd to provide a richer
default output geared towards human consumption. For example stuff like
git-branch -v and git remote -v flags would have been the default for
Cogito ... I think.

-- 
Jonas Fonseca
