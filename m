From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: How to recover a lost commit...
Date: Thu, 11 Nov 2010 12:39:20 -0500
Message-ID: <AANLkTi=9bu1nwjFgxbXGN+4scMAgrCgmb95H8E3Nfj1x@mail.gmail.com>
References: <AANLkTinfYTMKicr3V=T=scVpOte_XrmaDgVA_oMj2fYU@mail.gmail.com> <20101111165023.GB16972@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 18:39:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGb7j-0003Jh-6U
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 18:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755164Ab0KKRjm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Nov 2010 12:39:42 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52366 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755117Ab0KKRjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Nov 2010 12:39:42 -0500
Received: by gwb20 with SMTP id 20so12069gwb.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 09:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NU/NXK38LsHE1LCHWPrEKw2XcViQpVVZAwGwM4cq4l8=;
        b=BuqsULEY7AlpNM0psOkY6nCRM7fRjYOjF4sQGXBweji85qbJta051izp+WY3qYMyJG
         AxaHcqaZ6LEWH383ajcJWpr+6z47a7XzsWXKbLe2ZUJQAHTUTLAnsXYTGsSuqXps0VMp
         KDBSmn1hhsxuGefkom84USp3yK1FgXPp82CnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Dy67KyiFslYv7uT5FYJ1F19iPCFE6LVqAlCAVA0tZoxXIZScHo3tWhndatjJMyyWV2
         UiGFwJMBwfUW4abGSni9La1GcDE7x4DP483NT46siwgbSCinBoeO4fhZnpv4DD0tiLka
         4kU/gjwKDFtDSX3TI7cXa2lVDxg7eyvbDx3ns=
Received: by 10.223.118.132 with SMTP id v4mr429764faq.87.1289497180661; Thu,
 11 Nov 2010 09:39:40 -0800 (PST)
Received: by 10.223.115.17 with HTTP; Thu, 11 Nov 2010 09:39:20 -0800 (PST)
In-Reply-To: <20101111165023.GB16972@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161276>

On Thu, Nov 11, 2010 at 11:50 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Couldn't
>
> =A0 =A0 =A0 =A0$ git merge --no-commit svn_to_git_wip
> =A0 =A0 =A0 =A0$ git reset
>
> have worked?

Hi Jonathan,
Thanks.  That's where I started (although I also added the --no-ff
flag to the git-merge command) , but then I decided to get fancy and
switched to the svn_to_git_wip branch and rebase it on master first.
In hindsight, I was trying to be to clever for my own good.  But I
figured I could always undo any mistakes.  I was just surprised to
find that my work-in-progress had disappeared despite the fact that I
hadn't done a commit.  (It's possible/likely that I did an implicit
commit when I was playing with rebase.)

Anyway, next time I'll use git-stash, and in the future, I'll be much
more paranoid about using git-reset.

--wpd
