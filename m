From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Mon, 22 Mar 2010 09:19:54 +0530
Message-ID: <f3271551003212049r1139d6b4x279c6803cc4c7fe2@mail.gmail.com>
References: <f3271551003191018j67aa133es2fee4e3dda519ce0@mail.gmail.com> 
	<f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com> 
	<alpine.LNX.2.00.1003212011280.14365@iabervon.org> <201003220341.38918.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 04:50:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtYem-0000ma-PO
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 04:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab0CVDuU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 23:50:20 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:46576 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0CVDuS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 23:50:18 -0400
Received: by ywh2 with SMTP id 2so1622807ywh.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 20:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=U+v3ShUtJiw06MTKKKWuh3u8oOgQsnf3kYe+CgoEV7M=;
        b=Y85Kwwtna5yZrKXAXPPZJBF7kgyxgsnJtC5/hkpa0vSJA/KcXTZ98++Mxw2Gi10car
         CscVWuSjc375QxsAoEsKkwv8C2J9Qu6Tp5b1OlvXK0/fQ8iLDtyQ2FGC9URnbIN/ErcC
         vg0fwq45NeqPCKZnv4fYnm8lYfYfG2rdAvLrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=LdLvW10wkUMPNoTZ4ShZAlsXFgMALeQSq+J9z5eopA1p1AzsaYUr37FG3tvtjlvICH
         Wl8R0XCNVzBRt/vDmwOdaFb7rLX9d9IO/6yHB2FrAdjA1MW6i2DLiYe+uNezdASFvDq7
         nZifWk+CHdWC5wHa5wg7d1008rSTKeGJm3gNE=
Received: by 10.91.51.19 with SMTP id d19mr3683527agk.101.1269229814448; Sun, 
	21 Mar 2010 20:50:14 -0700 (PDT)
In-Reply-To: <201003220341.38918.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142892>

> Don't know about importer modes, but in native connection mode it is
> possible to avoid calling or linking to git in any way (been there, d=
one
> that).

> Mostly, except that I think it should be possible to avoid having
> git-remote-svn actually link to the git core, because the git core sh=
ould
> be taking care of everything git-specific for you. Of course, the git=
 core
> also provides a bunch of useful C library code that you may want to u=
se,
> such as a nice string buffer implementation, so you may want to link =
to
> git even if you don't actually need it, if licenses are suitable and =
it
> would be convenient.

As of this point, I'm undecided about which parts of Git Core to link
to, if at all. I'll try to avoid linking, but I'll do whatever is most
convenient within the bounds of the license as I write the remote
helper.

> I solved this problem you mention by rebasing in both directions onto
> detached HEADs and exporting the result, meaning that the history is
> permanently diverged from a DAG standpoint. =A0Of course, over time, =
the
> rebase would become increasingly messy and horrible, so I created a
> couple of placeholder refs which are updated after the import/export =
is
> finished. =A0These mark the last time it was done, and allow you only=
 to
> attempt to apply the commits which are new on each side.

Ah. Could you please post a link to your code?

> Because it's much better for everyone at the end of the GSoC if only =
half of
> the project is finished but merged, rather than if all the project is=
 "finished"
> but nothing can be merged.

Right. I'll merge the whole thing in 3-4 phases then.

-- Ram
