From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Mon, 7 Jun 2010 20:54:39 +0200
Message-ID: <20100607185439.GB17343@localhost>
References: <20100605110930.GA10526@localhost>
 <vpqljas5e33.fsf@bauges.imag.fr>
 <20100606164642.GA10104@localhost>
 <buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 20:55:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLhU3-0006PT-O9
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 20:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab0FGSzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 14:55:33 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35261 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab0FGSzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 14:55:32 -0400
Received: by fxm8 with SMTP id 8so2353839fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 11:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=qH4b2TvrBiyf2yuyO1/ab4/+iMht/4nlUdL6slS6EUA=;
        b=r7dVTx4XK31tZoPSjEXMUwYh5nDNJl6JizF+bU1VJhj6qeNzXdGCehks9NKH5twNbK
         5CnfLyIfi8giZPH39tkuPvgeirTeSTJnPP2iGZ98rwdsMlAO6ZNep1rnPeWHLmzIxuw/
         CD5OYYE6BjQ7Vpr9O5SlvgnK1duWrbElliTQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=dP6lneDutyR88HtspYRryDUXmQKRkF5nxxjp8d4awM/D2p2rfH345RxiRQpvJeasbr
         gwxH4Lay+HHZPddv9MtdsjwAjTunXvrjklfnxAm1XxnKhnTTIAQGSOLrGZrRoQ7Cjxjw
         58RO4ymC6+m3h2xpFISEk7Dc0CzkKnYBIL1ds=
Received: by 10.223.29.156 with SMTP id q28mr74197fac.77.1275936930714;
        Mon, 07 Jun 2010 11:55:30 -0700 (PDT)
Received: from darc.lan (p549A5B93.dip.t-dialin.net [84.154.91.147])
        by mx.google.com with ESMTPS id 2sm21530858faf.3.2010.06.07.11.55.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 11:55:29 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OLhT5-0004y3-4T; Mon, 07 Jun 2010 20:54:39 +0200
Content-Disposition: inline
In-Reply-To: <buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148616>

On Mon, Jun 07, 2010 at 03:41:58PM +0900, Miles Bader wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> > The suggestion above would be perfect. It is an easy and obvious
> > solution, and the user is even educated about their mistake.
> 
> Of course, having been educated as to what's going on, the user would
> then be annoyed that they had to type all those boilerplate args when
> git clearly knew what they wanted to do... and that would be the case
> every time from then on...

Why should the user make the same mistake over and over again?

> I think this DWIM is actually pretty convenient, and very often does
> reflect what the user intuitively is trying to do when giving such args.
> 
> Given that git _does_ tell you what it's doing, and that it's easy
> enough to delete the new branch if it wasn't really wanted, it seems
> pretty harmless as well.  A campaign to delete this feature seems kind
> of silly...

It may be harmless to users who know what's going on. I can
certainly deal with this feature, whether it's there or not.

But this is supposedly a feature which helps users who type "git
checkout <branch>" by mistake, when they really wanted to do "git
checkout -t <remote>/<branch>". I am certain that most new users
who make this mistake will not understand what's going on, even if
they read the output.

I believe that it's because of things like this that many users
still consider git to be complicated and hard to use. That's what
really bothers me.

And it makes me sad that you think it silly to even talk about it.
Even if the feature does not end up getting removed I still hope
that we will exercise more caution in the future and try to solve
the real problem--which appears to be remote branch
handling--rather than introducing more strange behavior.

Regards,
Clemens
