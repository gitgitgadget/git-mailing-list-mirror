From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: how to update origin/<branch> after a push to origin <branch>?
Date: Thu, 14 May 2009 00:58:09 -0400
Message-ID: <32541b130905132158s44cc5b19n974901c05cf025b2@mail.gmail.com>
References: <19640.1242276135@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Thu May 14 06:58:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4T1i-0000JH-Fe
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 06:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbZENE63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 00:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbZENE63
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 00:58:29 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:45298 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbZENE63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 00:58:29 -0400
Received: by yw-out-2324.google.com with SMTP id 5so615662ywb.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 21:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1kVqKQYD6k2hffP1eS8Joi1+zmCcyMDYk5zL+VXGq6c=;
        b=UBDAPXtRK/Uc+vBsyIw1875m0N22Uxjg7Y/lkXr56gCX1edwRyWrHqoe9ocQ7A2M3r
         9yqA6T7B10Kh6Y3LJk9FJzeFfq8DUypclPFrnsrH6MYgK1/EJMiicHMBE5EtbvKv6mrE
         ZwlUqD0RyqE8YJxEtuNJ61tUNiWNWqXc13tsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jBWipsWILTM3Br2aaKcB7G+SX/1iVHUnE9NbftfOQCgSXb1qKEp9ifQKU+EXUH9c8b
         jjl+N6xNIYbT9Vvu8nRz/J0tkRLzEVDzDW/eGjpf59lnbIJewXjT0qMahN/Dt/P/S7nQ
         IhriiKUC9wjtTkWKewKRxVSRb9dfhUDvAjkdo=
Received: by 10.151.123.11 with SMTP id a11mr2741920ybn.75.1242277109093; Wed, 
	13 May 2009 21:58:29 -0700 (PDT)
In-Reply-To: <19640.1242276135@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119134>

On Thu, May 14, 2009 at 12:42 AM, layer <layer@known.net> wrote:
> after the push, I still see the names of the files I pushed because I
> haven't updated origin/master yet, with a fetch. =A0Of course, a "git
> pull" would do it, but I don't want to do that, because I might be
> using something other than `origin' and I don't want anything but the
> single branch.
>
> So, I naively thought that
>
> =A0git fetch origin master
>
> would do the trick, but after that command the git diff above still
> shows the same files.

Short answer:

   git fetch origin

However, 'git push origin master' should update origin/master
automatically, at least in relatively recent git versions.  It's
rather weird if that didn't happen.

Have fun,

Avery
