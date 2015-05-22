From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Announce] submitGit for patch submission (was "Diffing submodule does not yield complete logs")
Date: Fri, 22 May 2015 09:27:57 -0700
Message-ID: <xmqq4mn4fugi.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Fri May 22 18:28:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvpnp-000319-JZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 18:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945953AbbEVQ2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 12:28:01 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34524 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945937AbbEVQ17 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 12:27:59 -0400
Received: by ieczm2 with SMTP id zm2so35079803iec.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1Pwn29nyKV2S3ClnFWj+0+XwgXrDuhnDUbihicTI6bc=;
        b=IOF7n9AtvUocq5jENXZOhLeLta+VB2iDaDx8yWGdgKXpuFdO1l1w/AmBkrPoN6skPI
         Abas+x3OeaBiSUvaeLrF3/Lo+XrTvUhj+MEiekDwuagWxK0OFQy1wRqWeoRYd7J80aAf
         OrmzOeNkg0p+24qlh7OwGBTPdx3aufySWX1/Z7Cs1Tor0az2NS86tlMJFJd4SxzGpA80
         BEVNuDl+SO0tyJZEb0iK1V0tvSEynPotEXKlM9ocqDBsPNNpwQZJI6EZMMTYFav5JRMP
         3fPieWiLnHKklL22O4mUAhD30+oP9vS4ZJD/kaMPCSjEwgDYpV0G+osVapk8X9vLwGTI
         wj9w==
X-Received: by 10.50.79.196 with SMTP id l4mr6791586igx.48.1432312078822;
        Fri, 22 May 2015 09:27:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id i4sm4271765igm.2.2015.05.22.09.27.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 May 2015 09:27:58 -0700 (PDT)
In-Reply-To: <CAFY1edY3+Wt-p2iQ5k64Fg-nMk2PmRSvhVkQSVNw94R18uPV2Q@mail.gmail.com>
	(Roberto Tyley's message of "Fri, 22 May 2015 09:33:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269733>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> Here's what a user does:
>
> * create a PR on https://github.com/git/git
> * logs into https://submitgit.herokuapp.com/ with GitHub auth

Hmm, this seems to request too much authorization, though.

    Repositories
    Public only
    This application will be able to read and write all public repo
    data. This includes the following:

    Code
    Issues
    Pull requests
    Wikis
    Settings
    Webhooks and services
    Deploy keys

I really wanted to try this out, but I do not think, as the owner of
a reasonably important repository, it would be irresponsible for me
to grant write access to Code or Settings for my primary GitHub
account.  Also I think you reject an account that is too young (I
found out about submitGit via your comment on a pull request to
git/git and read its source before reading your message I am
responding to, and that was the impression I got from the recent log
messages there), so I cannot create and try with a throw-away
account, either.

That would mean that I cannot join the fun X-<.
