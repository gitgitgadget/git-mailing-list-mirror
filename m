From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 18:41:16 -0400
Message-ID: <z2t3abd05a91004211541y1c2c5467k5731819da7fe625@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com> 
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com> 
	<vpqsk6omppf.fsf@bauges.imag.fr> <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com> 
	<vpq8w8gjvhn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 22 00:41:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4ic5-0006FQ-Hk
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 00:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab0DUWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 18:41:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49490 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab0DUWlh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 18:41:37 -0400
Received: by wyb39 with SMTP id 39so4402720wyb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=C9ejqhaNVjil7Awwv4JTyeC9VmOwXcZaNMVpAozCk2o=;
        b=blLMOQ2Z7gZaN2Pix+oFzU8apOpHdif6EkW4pGwMkFtIOfGrMQqyJp7LMk9D6ZTzWb
         trxb7kR9eUoD6exa8y+V0jV48KzpUTAM+6lrXmR69x4VFopxyXOzt3HETveUAcE0i5sq
         WxtUgAkIKtb++iDDylVqwexyggSPRuQMJ5vNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BXE4J8gdpx1eGqiWCGY4TU9QDI7EgZXB8W5GjfXfMOK2iLodjqMFkkTS4ptQTJoXDS
         HJgQghRwvZFGtuVqdtR6iWFh4oCjNwXbTUtWZwndkHtV8zb+u5KnF525ef5dznm+qbqU
         FqrpIGaS0KO9GSjY85t6/bufEBZ2GWTH7qs2c=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 15:41:16 -0700 (PDT)
In-Reply-To: <vpq8w8gjvhn.fsf@bauges.imag.fr>
Received: by 10.216.156.203 with SMTP id m53mr178763wek.209.1271889696211; 
	Wed, 21 Apr 2010 15:41:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145474>

> Otherwise, --set-upstream may help. But neither will help untill you
> RTFM.

Matthieu, I spend my days reading the git manual and also the source
code, which is not normal IMHO. I always look for examples but in the
case of 'git branch' there is not many that are really useful!

I suggest to add this as an example since it is probably the most common
case (one would expect that a new branch simply mimics the characteristics
of the starting branch, no ?)

  git branch --track small_fixes origin

And it does what I want.

Again, the behavior changed: just upgraded to 1.7.0.3, before then I was
doing branches like this:

  git checkout -b small_fixes
  git pull

>From my point of view, that was neat!

The --track and <start-point>=origin seemed to be implied. I find that this
is a better better default (OR 'git pull' was defaulting to 'git pull
origin HEAD').

As of now, 'git branch x' seem to be of little use without more configuration.

  -- aghiles
