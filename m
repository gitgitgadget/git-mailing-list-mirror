From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major bugs.
Date: Wed, 2 Jan 2013 16:15:31 -0500
Message-ID: <CACPiFCKNkpaf6CgU=5rn1dyUSG2KV43oeTKJgRsSh9-Rhtq3Kw@mail.gmail.com>
References: <20130101172645.GA5506@thyrsus.com> <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com> <20130102080247.GA20002@elie.Belkin>
 <20130102105919.GA14391@thyrsus.com> <20130102153933.GA30813@elie.Belkin>
 <20130102161848.GA18447@thyrsus.com> <CACPiFCKDoAoKxM4YU6uKoOGcDgLbXnCoUMO5iyf-wCWXh3j70A@mail.gmail.com>
 <20130102164107.GA19006@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqVfX-0002gX-9L
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 22:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab3ABVPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 16:15:52 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:48194 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab3ABVPv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 16:15:51 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so8072266pbb.25
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 13:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=INp48WLkQpqpaj/t7JdFzK3zE8A8P6UZiB1mrexixI4=;
        b=m97jzJSjKbjp6ut44dvGhNdUEgHIKKrG+/HZVApRfp7EjFQE4hsdIjPQH3zcbwlrvG
         Uyqo5WS3cfGL4sHMjpm3wZPIq4j7ZwNAG0I+4eJPSp9pKRY09aAt2RP0uZ+COl7b6Zm7
         xE0QyTfPX8Fz7f1oXxsA/kzREHgYeitlcx9nOB6Nr3T5rCJ1Mk962tb1iOif7rh6HTPd
         t0xgTyj7tkGqYZ8zRxSs66xHbpbLtZU0TJYIPeDbHqGF8cK/9QtSykExLR673063aqwT
         KDI0hPJSOluGq++v9WttbhD/D1DKB0ozc4hnL4yFJeOnP8vIKp0ajkxA5A5f+2hM8CuX
         +tHw==
Received: by 10.68.239.232 with SMTP id vv8mr146616966pbc.53.1357161351200;
 Wed, 02 Jan 2013 13:15:51 -0800 (PST)
Received: by 10.66.21.231 with HTTP; Wed, 2 Jan 2013 13:15:31 -0800 (PST)
In-Reply-To: <20130102164107.GA19006@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212543>

On Wed, Jan 2, 2013 at 11:41 AM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Martin Langhoff <martin.langhoff@gmail.com>:
>> Replacement with something more solid is welcome, but until you are
>> extremely confident of its handling of legacy setups... I would still
>> provide the old cvsimport, perhaps in contrib.
>
> I am extremely confident.  I built a test suite so I could be.

This is rather off-putting. Really.

I dealt with enough CVS repos to see that the branch point could be
ambiguous, and that some cases were incurably ugly and ambiguous.

Off the top of my head I can recall

 - Files created on a branch appear on HEAD (if the cvs client was
well behaved, in HEAD's attic, if the cvs client was buggy... )

 - Files tagged with the branch at a much later time. Scenario is a
developer opening/tagging a new branch mindlessly on a partial
checkout; then trying to "fix" the problem later.

My best guess is that you haven't dealt with enough ugly CVS repos. I
used to have the old original X.org repos, but no more. Surely
Mozilla's fugly old CVS repos are up somewhere, and may be
therapeutic.

cheers,



m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
