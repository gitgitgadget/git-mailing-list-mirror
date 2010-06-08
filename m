From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Tue, 8 Jun 2010 20:13:53 +0200
Message-ID: <20100608181353.GA3083@localhost>
References: <20100605110930.GA10526@localhost>
 <vpqljas5e33.fsf@bauges.imag.fr>
 <20100606164642.GA10104@localhost>
 <buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
 <20100607185439.GB17343@localhost>
 <AANLkTilccgKxO7YCTJYc5rTzhov5Tku2z8jSfWU_B4ui@mail.gmail.com>
 <20100608072958.GA24302@localhost>
 <20100608075241.GA3166@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Peter Rabbitson <ribasushi@cpan.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 08 20:14:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM3JP-0005gW-DV
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 20:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755698Ab0FHSOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 14:14:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34177 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab0FHSN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 14:13:59 -0400
Received: by fxm8 with SMTP id 8so3119140fxm.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 11:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=JxbJF79ZYh/sB7bCSPoZDzzqwBhRD21zUZwa4aZLgNE=;
        b=YOPVl0ZgjvFPJhdMeoZaeF7r7ASvDtnEu2ZbVOKibERAgpytH+ts8H2imQyAWF81YK
         nvSKBirKHzg1/OHER21LN2LtfxruH2zb2AER+x2/rSpSqLQR2+cjdVplEcQrCnv3sfmD
         L7EBkzAGd51JzjHFuCXRCpsL50YW89ec8zkuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=aWULKqjVBDRr2IG59QqMVTyvG++yQI4ySuRqgco82lYk9L+uIJbypDUUJ+esOl+Aiy
         uTMfJKVO1iDoIqTP6blReXsykUxGut9IEL/QcnQ4u8PJ82jda2SN57npO1PTWqVQ8vj9
         l7HlI9c4x3G0he8gIMjbTxeWOGwcEQSavFZc0=
Received: by 10.223.100.141 with SMTP id y13mr1736585fan.15.1276020838431;
        Tue, 08 Jun 2010 11:13:58 -0700 (PDT)
Received: from darc.lan (p549A3632.dip.t-dialin.net [84.154.54.50])
        by mx.google.com with ESMTPS id 15sm26583995fad.10.2010.06.08.11.13.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jun 2010 11:13:57 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OM3JB-0000sc-C6; Tue, 08 Jun 2010 20:13:53 +0200
Content-Disposition: inline
In-Reply-To: <20100608075241.GA3166@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148698>

On Tue, Jun 08, 2010 at 03:52:42AM -0400, Jeff King wrote:
>
>   $ git checkout foo
>   Branch private set up to track remote branch foo from origin.
>   Switched to a new branch 'foo'
> 
>   ... time passes ...
> 
>   $ git checkout foo
>   Switched to branch 'foo'
>   Your branch is behind 'origin/foo' by 5 commits, and can be fast-forwarded.

I see. That really is somewhat reassuring. I still do not like it,
but considering the fact that I could not come up with a scenario
worse than that, I suppose the feature is not as bad as I made it
out to be.

Thanks all for discussing it with me anyways.

Regards,
Clemens
