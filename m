From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 07:06:02 -0400
Message-ID: <BANLkTikHkTHP7eJ=_wPosi7yj4BX=c1gaA@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<201106100004.58040.jnareb@gmail.com>
	<4DF150FB.9070304@alum.mit.edu>
	<201106101219.18497.jnareb@gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 13:06:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUzXX-00005M-9b
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 13:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab1FJLGH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2011 07:06:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39995 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755498Ab1FJLGE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2011 07:06:04 -0400
Received: by bwz15 with SMTP id 15so2082601bwz.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 04:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=G5UP1wAylisZTVWTTGQetpFTUH10ZBdQrvY8DY1ukVo=;
        b=Y23qWNdrrbTDqmZ4MLOC5lQ2RJNfNYn7zRMcmu8B3zDhEeuaHk15M9CHUCq0Fkr+Pk
         Q1um9S6Xvpay7bs1Q0ZXFFnutVuWGP5NGWvGnNwVrA/X8GSiw16GSX93LHeU5Osg42N5
         +JRqx5SMjQXPwqrSXBkAQDUZi85Qj8KplsQF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=m0OMf3gQGnpKsWmT6S5UVWQlXLLXdi0JdwfOx3YrDxvehUCkNfs7GQ9SE55MJAAkdT
         Ic5KL26dvB8ztwjnwnnODdoRQPrJ4qStZ9T1bhFaZ+kCTPwVE0SP6inuSx1QP4AzyBl6
         DT4cTZMyohWWBBic0EwaWd7trixXuCnXs0dwY=
Received: by 10.204.82.149 with SMTP id b21mr1690567bkl.196.1307703962687;
 Fri, 10 Jun 2011 04:06:02 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Fri, 10 Jun 2011 04:06:02 -0700 (PDT)
In-Reply-To: <201106101219.18497.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175603>

> 'git diff' / 'git diff --cached' / 'git diff HEAD' is about use cases
> (or "user stories"). =A0'git diff NEXT WTREE' / 'git diff HEAD NEXT' =
/
> / 'git diff HEAD WTREE' are about mechanism.

Would you say that the UNIX commands "find", "grep", and "xargs" are
about use cases?  I rarely use them by themselves.  They clearly
manipulate concepts: files and lines.  So, it's easy for me to think
what this does:

find . | grep "\.h" | xargs grep MyClass | grep public

I'm trying to find concepts the concepts that git manipulates and I
think NEXT and WTREE are part of those concepts.

It is my opinion that if we focus on concepts, we'll be able to create
general commands and that the user will be able to combine the
commands in new and interesting ways, like I combined the UNIX
commands above.

I believe in "common" use cases.  The common case should be fast.  I
have always recommended still allowing "git diff" by itself.


BUT if we focus only on use cases, we'll create tools that are
specific to ONE thing and are NOT general.  They will be harder for
users to conceptualize and harder to combine in new and interesting
ways.
