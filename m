From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: State of CVS-to-git conversion tools (Was: Re: cvsps: bad usage:
 invalid argument --norc)
Date: Mon, 15 Apr 2013 22:43:09 +0200
Message-ID: <516C665D.2060204@gmail.com>
References: <323381594.20130414121834@gmail.com> <673219382.20130414124800@gmail.com> <20130414113351.GA1299@thyrsus.com> <1762779000.20130415215818@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 22:43:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URqFD-0000Jv-Mj
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783Ab3DOUnP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 16:43:15 -0400
Received: from mail-ea0-f175.google.com ([209.85.215.175]:44682 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab3DOUnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 16:43:14 -0400
Received: by mail-ea0-f175.google.com with SMTP id r16so2373087ead.20
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=B6NkMu0D9PjUBL4i3pppVmuOLWCco7kpyno67GNnoKQ=;
        b=JXbB6IKBT0Yky8SeQ8y9PIwLQoivdFmyuPqhosofOoIC83BL/iCtweRqi8B8aTI/Z3
         5vMURSQ+EAQ9rERNXoO/8YA81dfNl8CrVf4xEGX/TLraxVKivNfG7tA5RpWhUZd6Lpv8
         nzWHm8DOBMH0+BlBKyOEc40acV3S4coreuu+Nsx5N81CbNyioLF9pSvOmLKIL/WuVQXl
         rAWm6glf9IDvpbrA3RVsXPJIJJvRx/4KQPzP3oXCkSpIrxOIU4NrqI5GhxSkS+Z3t6ME
         ejqXPdHRi9hwpsobC0/Ev9w3H/h0MrVeMwNmgw6coAiP865Jdx4oWjBEFYcOCsPXfzux
         KMXw==
X-Received: by 10.15.36.135 with SMTP id i7mr66273904eev.34.1366058593359;
        Mon, 15 Apr 2013 13:43:13 -0700 (PDT)
Received: from [192.168.1.14] (ept17.neoplus.adsl.tpnet.pl. [83.20.61.17])
        by mx.google.com with ESMTPS id n48sm15226174eeg.12.2013.04.15.13.43.11
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 13:43:12 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1762779000.20130415215818@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221313>

Ilya Basin wrote:

> Does this --fast-export thing support what John mentioned, the
> "incremental import support"? Does 'git fast-import' has it?
> I need it, because full import takes too long.
>
> The central repo of my employer is CVS, other people commit to it and
> I use git internally to be able to tidy my commit history before
> exporting to CVS.

Errr... the need to interact with *live* CVS repository is reason=20
behind wanting incremental import, isn't it?

I wonder how hard would be to create a remote helper for CVS, so that=20
one could treat CVS repository as foreign remote, fetching from it and=20
pushing to it...

BTW. can you convince your employer to move to more modern version=20
control system (be it Subversion, Kiln Harmony, Veracity, Bazaar,=20
Mercurial or Git) rather than rely on system which had last release in=20
2008 i.e. 4 years ago, doesn't support atomic commits, doesn't support=20
versioning of whole repository aka. changesets (beside tags), has slow=20
and complicated branching and even more complicated merging, etc.?

http://stackoverflow.com/questions/802573/difference-between-git-and-cv=
s/824241#824241
--=20
Jakub Nar=C4=99bski
