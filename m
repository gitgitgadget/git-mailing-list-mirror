From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Wed, 29 May 2013 09:01:11 -0500
Message-ID: <CAMP44s3TKCtn8f_zU1geFcmgCFVkKF+ipBFkV+cSa+6CtLX0gA@mail.gmail.com>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
	<1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
	<7vobbv119k.fsf@alter.siamese.dyndns.org>
	<87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
	<51a56bef1b9c2_807b33e1899991@nysa.mail>
	<877giixl4c.fsf@linux-k42r.v.cablecom.net>
	<CAMP44s3vkJCr2f2zsZU++j4Wqxuefmpt8BQ9dJoP=JtTB=rgkQ@mail.gmail.com>
	<87y5ayqivi.fsf@linux-k42r.v.cablecom.net>
	<CALkWK0k5+2nebRLZfWFpxyPmptV_Qo3sKwgpbpvN-bK6_S6W3w@mail.gmail.com>
	<CAMP44s2tvUs813hrheWpWXR2G4kMJL4rscEtynaKYvw5a6HCHA@mail.gmail.com>
	<CALkWK0kK+Mbscsue0wwU5QDKXCrw5Q078MCdOVCoJnMZq7T6UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 16:01:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgwM-0006wS-F5
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 16:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966666Ab3E2OBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 10:01:15 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:64490 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966545Ab3E2OBN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 10:01:13 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so8978951lbd.20
        for <git@vger.kernel.org>; Wed, 29 May 2013 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nFhFUZ7PMjOxNwjad1IJq7zQQHc0wbbORUWEie6aR7k=;
        b=ojsAzKWhWDPhR+tK09/zVLzORXMj3uNJZtykhuegk6cOkuraJlfmNcR6qDLsBqNvKf
         +WpvOzKJL7raDdv7hIhvxdN24l2zLR9800FB8av3b6IWdIXyEywR1Nl6mTv7Jb+T8LX1
         MyryETyx+9KDt+bOhVYd1qaPUYZGNx2DFdKpiK5cpFh/itXJV/zVnd6F7SBvQEZAjvp5
         9grAdSCmaiVcO/MRSg4LpljbeEve+xdDuHXrT1MV2TDKNJ3aC2ltmTmdaQ8dq+IzU5iO
         kG6oxui1A53DVlP4C+mfBNriAM7qFh2fjR+QO3nDSa5hIgagh6snNs7Rfsb7SEdEmWBY
         QMZw==
X-Received: by 10.152.2.233 with SMTP id 9mr1437534lax.34.1369836071848; Wed,
 29 May 2013 07:01:11 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 07:01:11 -0700 (PDT)
In-Reply-To: <CALkWK0kK+Mbscsue0wwU5QDKXCrw5Q078MCdOVCoJnMZq7T6UA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225831>

On Wed, May 29, 2013 at 8:48 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:

>> There's nothing wrong with me choosing how best to spend my time. Really.
>
> Ofcourse you are.  You have arguably spent it very productively
> solving a lot of user issues (especially remote-bzr).
>
> Personally, I try to do the minimum amount of boring work required to
> make sure that a good series gets in.  Sometimes this is a little high
> (for a recent example, see my pickaxe-doc series).  The result being
> that I just won't work on documentation in the future because doing
> iterations is so piss boring: the git community needs to recognize
> this problem and make amends.

I don't mind doing as many iterations as it takes, as long as it's
about meaningful issues.

I don't particularly enjoy, but I'm OK with discussing non-meaningful issues.

What I'm not OK with is disagreements that end up breaking the
communication, specially when a crystal-clear case has been made
(IMO), and the patch goes to limbo for no reason. That I think is a
real problem.

For this particular patch, I don't care if it goes in at the moment. I
have something big on the pipeline, and I would rather drop this than
loose penguin points, although I probably don't have any left.

Cheers.

-- 
Felipe Contreras
