From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Wed, 8 Jun 2011 07:39:16 -0400
Message-ID: <BANLkTinoQCZhyhgw61u7c3eF4e5MEf+eFA@mail.gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com>
	<7vd3ir9btd.fsf@alter.siamese.dyndns.org>
	<4DEDC124.3060302@drmicha.warpmail.net>
	<201106081312.46377.jnareb@gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 13:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUH6Z-0002I4-LM
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 13:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053Ab1FHLjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 07:39:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35768 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab1FHLjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 07:39:17 -0400
Received: by bwz15 with SMTP id 15so334377bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 04:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=FGG90g3LJSF3+pn4GA4Kyf6db7hkymIKlWNWcJXwpv8=;
        b=bvZuQOcoyJ1CWagxjseqyGyyaG6gQu1WL18ilD+taP1CAAdfpIRCi3Jq1zn14Qa3NU
         O8QFtaCZ/dsnqb6tDuVvLMtrlHNN5LVh5FSsPJqjIcqFPJNZmTaTNNDW96NQdYk2qysW
         QEc0TQdSwWzNz0MUiqgnd8tnzYUvXQ3LMaCYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=gb1fGxDkg5Icmznb1gO+k0shNUHfH79gGizwYOsdpLGir/AmDal7eYUjiVWc5iWm6q
         Pyqc3d0mTO7nbM+5sAK4srjVXgrnrEii1d+cm7ja6ZroqWxmTyN9gDK228mTe5nAvVxt
         QiqcmnXXG5Wf53dYNPzdb8y4RqvFalE4WTeDI=
Received: by 10.204.62.4 with SMTP id v4mr700173bkh.169.1307533156456; Wed, 08
 Jun 2011 04:39:16 -0700 (PDT)
Received: by 10.204.100.80 with HTTP; Wed, 8 Jun 2011 04:39:16 -0700 (PDT)
In-Reply-To: <201106081312.46377.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175358>

On Wed, Jun 8, 2011 at 7:12 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> I don't quite think that we need "git diff NEXT WTREE"; the short
> and sweet "git diff" is short for a reason,

To be clear, I'm not advocating and have never advocated getting rid
of zero-argument "git diff".  I've advocated that every (whole
project) diff command should be expressible by a "git diff TREE1
TREE2".  I'm fine with defaults if one or zero trees are specified.
So "git diff" would default to "git diff NEXT WTREE".


> It is not obvious that "git reset" can be used for files, and it requires
> bit of analysis that it resets index from HEAD:
...
> 4. "git reset -- <file>" must set index version of file from HEAD.
>
> Truth to be told I really just follow what "git status" tells me ;-)

I love those messages but if a user is relying on just copying a
warning message, then they are learning anything.  They're parroting.
I believe a user interface should have concepts and commands that make
sense, so that user will learn them and be able to apply them in other
areas.

> --
> Jakub Narebski
> Poland
>
