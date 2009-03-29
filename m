From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/4] Documentation: enhance branch.<name>.{remote,merge}
Date: Sat, 28 Mar 2009 21:38:42 -0400
Message-ID: <76718490903281838s1bc7e908l4702cf9ab020189@mail.gmail.com>
References: <1238281804-30290-1-git-send-email-santi@agolina.net>
	 <1238281804-30290-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sun Mar 29 03:40:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnk0e-0004aH-9f
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 03:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529AbZC2Biq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 21:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753038AbZC2Biq
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 21:38:46 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:63828 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZC2Bip convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 21:38:45 -0400
Received: by gxk4 with SMTP id 4so3359699gxk.13
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 18:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=20CV53400FzKH62zkcatTiQCNZeeDq+lu4LvUbm4fvE=;
        b=oZY8la/dbHdT283bB346oDULDL6aySgbMFjU21k44urfExxcf1VTGKauuzK5Uoajmy
         u3uKm3tOqR48Dot8NwUsXPZDYt/xTowe4sorIMS9JRczwJbqt52NpbkNXEOC4HLiNaPe
         2Gkqo1WTqAcaznGGe4rZglGBY1Z/aewbO6TgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=siEAp2pNbuQ7RqvvmqEPvd7KDTktKpl5YgutA2vgk3PudwAnZXP8j3zInzxy/i8mKA
         WsSVgWXKnNuWhbJdBzP48omcRNy3CzxjmntTZ4wMgLQOZ15QJYxH/IppPcCCu0pB1czl
         C4Aeroh4JZlZ3++uiFXxfRKFtStrDCW+WAd6E=
Received: by 10.150.186.21 with SMTP id j21mr7366445ybf.171.1238290722223; 
	Sat, 28 Mar 2009 18:38:42 -0700 (PDT)
In-Reply-To: <1238281804-30290-2-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114993>

On Sat, Mar 28, 2009 at 7:10 PM, Santi B=C3=A9jar <santi@agolina.net> w=
rote:
> =C2=A0branch.<name>.merge::
> + =C2=A0 =C2=A0 =C2=A0 It defines, together with branch.<name>.remote=
, the tracking branch
> + =C2=A0 =C2=A0 =C2=A0 for the current branch. It tells 'git-fetch'/'=
git-pull' which
> + =C2=A0 =C2=A0 =C2=A0 branch to merge.

I think it would be clearer to say "the upstream branch for the
current branch", since
it could very well be a local branch, not necessarily a remote tracking=
 branch.

j.
