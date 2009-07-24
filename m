From: Allen Johnson <akjohnson78@gmail.com>
Subject: Re: cloning to remote
Date: Fri, 24 Jul 2009 09:58:27 -0400
Message-ID: <6786ed4f0907240658s5c22cb6bs32d59e95e1bb3468@mail.gmail.com>
References: <EF165A6E-7E91-4EB6-B078-48BEB5F61448@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Fri Jul 24 15:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MULID-00022A-VY
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 15:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbZGXN63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 09:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbZGXN63
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 09:58:29 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:38268 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbZGXN62 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 09:58:28 -0400
Received: by fxm18 with SMTP id 18so1450394fxm.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NkARF70rXg629ySzNzyFIw71VZ3JerwZjN73ycGo7ig=;
        b=SmmZkKVoYckAkJmHiPobCGS4jJq+EQ4Cx/0IzOlYx/HprUIEenVLln1xBWYulWcoNa
         Fh1ZK+hifwyI/JK9paCYOfL3H3mhVgiTZJHtNTogzivGIwusJVlr8gODepj8hYUrPGue
         H0wvJTvgMAXbTAxCP8YvApL2hDvAKkfTR0BuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oitSsEdjZCOKchAZEZwQk/KGrVT0QJ1pKSbVNgmvSmavQ4knk5wLid2H89ESYikgWg
         gYAa0bcZnsHtbYpR7zaYSQE9QuZsKx0ZYFb6qH8rn2OUKo72EIoeVEZxAnABJ1/66pzs
         2nfQAnKUNdxPqvEQgmy2MoLZexM96CkMoesTQ=
Received: by 10.223.126.145 with SMTP id c17mr1700330fas.102.1248443907888; 
	Fri, 24 Jul 2009 06:58:27 -0700 (PDT)
In-Reply-To: <EF165A6E-7E91-4EB6-B078-48BEB5F61448@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123917>

I'm not sure about cloning to a remote url but you could do the clone
locally then secure copy it to your server.

$ git clone --bare project1 project1.git
$ scp -r project1.git username@server:/path/to/repo

Then, optionally, update your local project1/.git/config and setup
default rules for pushing to the server repo.

Allen

On Fri, Jul 24, 2009 at 6:10 AM, Roald de Vries<rdv@roalddevries.nl> wr=
ote:
> Hi all,
>
> Ik normally init my repositories on my laptop, and later would like t=
o clone
> them to my server. This seems to require that I login to my server an=
d clone
> from my laptop, which again requires me to run an sshd on my laptop, =
and -
> because it's always behind a router - to 'ssh -R' (remote port forwar=
ding)
> to access it.
>
> Did I miss something, and can I do something like 'git clone localdir
> ssh://server/path'?=A0Or otherwise, wouldn't that be something to add=
?
>
> Kind regards, Roald
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
