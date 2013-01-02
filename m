From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major bugs.
Date: Wed, 2 Jan 2013 18:44:24 -0500
Message-ID: <CACPiFCLz0wuG1qC4UmQ4tj4s9ftXoh4q=PUBkxtKh05bnu3coA@mail.gmail.com>
References: <20130101172645.GA5506@thyrsus.com> <7vfw2k8t7k.fsf@alter.siamese.dyndns.org>
 <20130102003344.GA9651@thyrsus.com> <20130102080247.GA20002@elie.Belkin>
 <20130102105919.GA14391@thyrsus.com> <20130102153933.GA30813@elie.Belkin>
 <20130102161848.GA18447@thyrsus.com> <CACPiFCKDoAoKxM4YU6uKoOGcDgLbXnCoUMO5iyf-wCWXh3j70A@mail.gmail.com>
 <20130102164107.GA19006@thyrsus.com> <CACPiFCKNkpaf6CgU=5rn1dyUSG2KV43oeTKJgRsSh9-Rhtq3Kw@mail.gmail.com>
 <20130102222849.GA21105@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 00:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqY5v-0005Vm-2j
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 00:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab3ABXvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 18:51:07 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50928 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab3ABXvD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 18:51:03 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so8234962pad.5
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 15:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BkO0OY9hOUMZW61Dv0ReFE0fktd37gHB8fLE8h6R1aY=;
        b=dMWwlV5wm469wtKSOIw/YNXMb9TRgmfGfHiOKEnVF9Z7wsHrZLmSZ9ghmRPhhBvjLB
         BYRY7EndFWQqYXrVIwBcwaDKJaYqZJy3aO+KD+mbIUatECMMbw4t6QCm61AscXFpxVcu
         U9DMZkPtyygSoZLhzZYiPrihiSHCJdgcoPqw4J9ZAl9D4Iz03keVAc+shXzUhaBUwFzn
         W+vKTJmAe00x3jUfF+tZuj3iqEubZbHnY/w+JRCvOtIc/n/vMyeAfh/U0E7BrzZ691w2
         idviJYjn51d3jycDxXOrBmP6qSqghdYiwf0VPYsttzHpYgzybt+8oJr5ywdh85yPTteQ
         s/Jw==
Received: by 10.66.74.2 with SMTP id p2mr141664308pav.55.1357170284287; Wed,
 02 Jan 2013 15:44:44 -0800 (PST)
Received: by 10.66.21.231 with HTTP; Wed, 2 Jan 2013 15:44:24 -0800 (PST)
In-Reply-To: <20130102222849.GA21105@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212558>

On Wed, Jan 2, 2013 at 5:28 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Martin Langhoff <martin.langhoff@gmail.com>:
>> I dealt with enough CVS repos to see that the branch point could be
>> ambiguous, and that some cases were incurably ugly and ambiguous.
>
> You are quite right, but you have misintepreted the subject of my
> confidence.  I am under no illusion that the new cvsimport/cvsps
> pair is a perfect solution to the CVS-lifting problem, nor even that
> such a solution is possible.

Thanks. That is a much more reassuring stance.



m
--
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
