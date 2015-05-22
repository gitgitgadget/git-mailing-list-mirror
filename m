From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule does not yield complete logs")
Date: Fri, 22 May 2015 07:17:15 -0700
Message-ID: <xmqq8ucghf2s.fsf@gitster.dls.corp.google.com>
References: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	emma@gitforteams.com
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 16:17:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvnlc-00078n-1x
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 16:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbbEVORV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 10:17:21 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38477 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835AbbEVORS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 10:17:18 -0400
Received: by igcau1 with SMTP id au1so33660556igc.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 07:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2ij7sxtSEcVxHBWXkQzFjkMZzx5Y8fTZyBI3EEnz/kM=;
        b=A0zdDxCe20QXDSRuVwsbMSOummAi5bGgYAWeYxXUndrRAm9WA3oFZb/jiIaD9tZ4sw
         LtbUum3Rbkrm2p4b7y6l8XuGJuFM3+xvRxerXylb8YM/q/nvV3EEFhpQx78vANQyLhak
         sWGj3QUp8oLGpHR/I+n05IV6tANp26DuqMPSdoZm/6JduxKUYkI4EW+YFuoPPITAr2hF
         cFYgeUrN/cy2xiLQekzy+kP/5aY3ZPCA7tVt3qimqbWIBCH1G1n+8h2f7oQXhFppmqFF
         LHt5cocKx13Sp/6VP3rcWeZogYzu9VOsrvDP4j9TcfttwxN+6X6HThGkV+yrCrsDVj8N
         KGkA==
X-Received: by 10.50.61.234 with SMTP id t10mr5881289igr.19.1432304238006;
        Fri, 22 May 2015 07:17:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id f7sm4062430igq.7.2015.05.22.07.17.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 07:17:17 -0700 (PDT)
In-Reply-To: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
	(Roberto Tyley's message of "Fri, 22 May 2015 09:33:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269719>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> Hello, I'm stepping up to do that work :) Or at least, I'm implementing a
> one-way GitHub PR -> Mailing list tool, called submitGit:
>
> https://submitgit.herokuapp.com/

Yay ;-)

> Here's what a user does:
>
> * create a PR on https://github.com/git/git
> * logs into https://submitgit.herokuapp.com/ with GitHub auth
> * selects their PR on https://submitgit.herokuapp.com/git/git/pulls

Reasonable.

> * gets submitGit to email the PR as patches to themselves, in order to
> check it looks ok

I can see you are trying to be careful by doing this, but I am not
sure if this step would actually help. Those who are not familiar
with Git development are not expected to know what is "ok" in their
original commit, and if they find bad formatting done by submitGit
(e.g. adds their PR message before the three-dash line instead of
after it), they cannot do much about it anyway.

> * when they're ready, get submitGit to send it to the mailing list on
> their behalf

Nice.

> All discussion of the patch *stays* on the mailing list

Can you identify a reroll of an earlier submission?  If you can use
the in-reply-to and make it a follow-up to the previous round, that
would be great.
