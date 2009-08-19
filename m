From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Simple commit mechanism for non-technical users
Date: Wed, 19 Aug 2009 18:09:32 +1200
Message-ID: <a038bef50908182309i2c4a9cd8leac7d1136726247e@mail.gmail.com>
References: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: D Sundstrom <sunds@peapod.net>
X-From: git-owner@vger.kernel.org Wed Aug 19 08:09:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdeMf-0007MN-0f
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 08:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbZHSGJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Aug 2009 02:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbZHSGJc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 02:09:32 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:47588 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbZHSGJb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Aug 2009 02:09:31 -0400
Received: by vws2 with SMTP id 2so3576814vws.4
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 23:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AvckZ8y2riwL29N7FRj7KqUSCSpxK54qeTcD5XROCac=;
        b=xt8BFzeLuP+CpzebdFwcfGJwH6QmtogUOfHZeKoMIl4p5bWC+RoA4MBGJWowgLvAL2
         2uGOlWIC4YoS0vt8+zbPPCt9UkGoXrwJSsLvWLcGoII+WEKycD9A0zwg5Bnx7cBbVvgD
         GWwhAOYw9Zu5HAtnqGOQqz8igAFaqBBmn7bsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aOAOVL//S6ugi2qiz8z3Ax5S9W5WIKfQTXZGO7QQ4wL51S9Fcr4oTR+S03sB2JexDu
         voqRtgb06WvsxJHPIjxI+TPoGhyGBNtsp3gZhO+nJ58A3rtasD/XcTFtdkgLkoSxj0Pv
         tIwy4nIlxBZ1uwVHHEPQVo/gXUVVy1cYbl+To=
Received: by 10.220.17.90 with SMTP id r26mr8298160vca.38.1250662172690; Tue, 
	18 Aug 2009 23:09:32 -0700 (PDT)
In-Reply-To: <ef72456d0908180905u18593b63tdc850b8552db30b9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126505>

On Wed, Aug 19, 2009 at 4:05 AM, D Sundstrom<sunds@peapod.net> wrote:
> I use git to manage all project artifacts, including documentation,
> proposals, presentations, and so on.
>
> However, I have a hard time convincing non-technical staff to learn
> enough about git or to take the time to go through the effort of
> committing changes to a repository. =C2=A0So the steady stream of ema=
il
> attachments with "Acme Specification v3" or "final final spemco
> proprosal" continues.
>
> I'd hoped there was a simple web interface that would allow a user to
> upload and commit a file to a repository, but I've had no luck findin=
g
> one. =C2=A0(I've used cgit for browsing, but it is read-only).
>
> Is anyone aware of a simple way I can have my non-technical users
> manage their documents against a git repository? =C2=A0Ideally this w=
ould
> involve no installation of software on their machine (unless it were
> compelling, for example, the Finder plugin for SVN on the mac was a
> great tool for these users; or at least those on a mac...)
>
> -David
> --

Actually this is one situation that I'd say there are better solutions
than git _ducks_.

The solution I've been trying to push people toward at my day job is
using a wiki (we chose mediawiki but all the extra markup might still
scare non-techies). Wiki's are version controlled (in a simple,
centralized fashion) and allow editing from multiple authors and can
be updated quickly. The only client software you need is a web
browser. Plenty of open source projects use wikis for their living
specifications.

You may also want to look around for other content management systems
but the only one I've used kinda sucked. Not sure if there are any
good open source ones (but then again I haven't really looked).

If you still want to use git as your version control system for these
kinds of documents it shouldn't actually be too hard to implement and
simple uploader to complement a viewer like cgit or gitweb.
Unfortunately I don't know of any that exist but maybe someone else on
the list does.
