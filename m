From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 17 Apr 2012 15:25:30 -0700
Message-ID: <CAJsNXTmfRZvpO=ooB8yKUqGqbU4g5A78=dzt2vPPrs1q+J4ZrA@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
	<CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: dag@cray.com, Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 00:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGqZ-0000Mb-7K
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 00:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab2DQWZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 18:25:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:40688 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab2DQWZc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 18:25:32 -0400
Received: by wibhq7 with SMTP id hq7so31910wib.1
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=tDF8qc1HVeqA9HdChLOjWRZNlGiOIDqvD+u6qp/mU+M=;
        b=KO3xzFTCz6outDBuBXk2qyW0ngDC8zVcxeuDx7Fj21nW8xmAaoi9HQM6M61SG27jrz
         ZrlGsZY1MTkyHd2oXUvMIGxRHy9QmrlRvkxyfyO5ubh449zfzWpI/qZLGS29ZJ+nr7g2
         e3TX2cGnGtriMFx3QLf9Essn8lgtQq8LOvceRAm42CXTELtGMFWovVMFBTK9zXSlXaw2
         X7C+fUOK472ZuaDZvXAIy267Pjj6ck4WAgE0Zi8m5IE79MEqquWRx1twZVh3hNmOIIb1
         ItksCoIRFibBcm+Iet+6ZlCegwuSkhbfYCnbLGFb127EUb8Xs5KNcM5UIqBlsi6YsvvO
         CXkg==
Received: by 10.180.93.196 with SMTP id cw4mr373512wib.19.1334701530893; Tue,
 17 Apr 2012 15:25:30 -0700 (PDT)
Received: by 10.223.116.200 with HTTP; Tue, 17 Apr 2012 15:25:30 -0700 (PDT)
In-Reply-To: <CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
X-Google-Sender-Auth: q_X1687QLjQtE-qzOmjmoLk3krU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195821>

On Tue, Apr 17, 2012 at 2:43 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:

> I'm assuming that if you have subproject S in umbrella project U and a
> branch "topic" in U then that same branch should exist in S. Any
> changes in S's topic should show up in U's topic (probably after some
> sort of update command like git fetch/pull). This should be unusual,
> though, you should be working in U, not S. If you want to work on
> something in S that you don't want to see in U, then you should not be
> working in S's topic.

This paragraph makes me wonder why you want to use submodules at all.
Wouldn't a sparse checkout be a better fit for what you're trying to
accomplish?

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
