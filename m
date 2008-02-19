From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] checkout to notice forks (Re: Minor annoyance with git push)
Date: Wed, 20 Feb 2008 06:03:01 +1300
Message-ID: <46a038f90802190903g1a19e38i30198b368a800a89@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	 <20080209030046.GA10470@coredump.intra.peff.net>
	 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
	 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
	 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
	 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:04:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVsd-0006ur-FC
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 18:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840AbYBSRDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 12:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbYBSRDF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 12:03:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:4058 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbYBSRDD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 12:03:03 -0500
Received: by ug-out-1314.google.com with SMTP id z38so576713ugc.16
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7b4c3SmJGJHMafBfE/EOtPt9WXXF3HbmznmvGfUQt7U=;
        b=CnTrmM1+qcMJ9SQ9kD2SeQVRCBkdGZJ5e/28fkr5jNH5Dov2hz8J7LKEirU0hdrvUjZw/Kcog6nSk4HSPxrVQQ6DoiwNJXhORFmLXNegwnYsdFhI46BsyLAYnVCKLH8Xjo7V4INWFDI9kgY+URgUndyU40xR+zgHOe5qNYlieRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HCO5dME/tzhTiAA8c4c7HN5UhUgEsbeApxcSfaSUxMegaQoTiozApvP1y11Z7yc8R9Ob+6cvzuAu4Ea19MYnZz5uImAJMWQfniR4QPVld8+bz7StzZONTB0alXgR9PbPvojfDQRJ7PniZ6oJAW7SvPRUBiR2HdCvVyK4da62OcA=
Received: by 10.66.216.9 with SMTP id o9mr1039368ugg.16.1203440581691;
        Tue, 19 Feb 2008 09:03:01 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Tue, 19 Feb 2008 09:03:01 -0800 (PST)
In-Reply-To: <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74438>

On Feb 17, 2008 2:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Perhaps making "git-checkout" to notice this and offer (or
> > suggest) fast-forwarding at that point may be safer and make
> > more sense.  You cannot grow your local branch unless you check
> > them out, and your remote tracking will keep growing without the
> > auto-ff you are suggesting, so it is not like people will lose
> > anchoring point to compare between branches if we do not
> > auto-ff.
>
> So I did this.

Great - *thanks*. I'm travelling ATM so lousy connectivity and
shattered focus. I did a fetch of git.git and can't spot this in next,
pu or master. Reading further down the thread I see that you're
probably rewriting it to use tree struct. Will give your initial patch
a whirl anyway.

cheers,


martin
