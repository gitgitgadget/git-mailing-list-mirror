From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Equivalent of "fixup" for git filter-branch
Date: Fri, 11 May 2012 14:51:15 +0200
Message-ID: <CAGK7Mr43Mxn-oJBDt11u0RMnxT1tv9OfbH9qNufb9X05mKh22Q@mail.gmail.com>
References: <CAGK7Mr5D0WQn-Tc1B5=F7+3OgZd1uy54Be-ZrbyFv0CP8JY5bw@mail.gmail.com>
 <m21umsylz8.fsf@igel.home> <CAGK7Mr7qdTwfha8aUdXE4FeXjA0rW3JL0q=a9kHArirjv5bygg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri May 11 14:51:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSpK4-0007b0-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 14:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab2EKMvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 08:51:48 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:43918 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321Ab2EKMvr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 08:51:47 -0400
Received: by qcro28 with SMTP id o28so1900553qcr.19
        for <git@vger.kernel.org>; Fri, 11 May 2012 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ri9rl43K82GiR5d2HsbRwI4quj6dPG5s6uYkAx5qdoU=;
        b=gCFZQLPXfMyFauVjrhbspfeyNu79vU4+xmGWeC5ofZ9uJKWr5g8dgdMiTHzgoTmECF
         YDC365aVSIUTGTDH1nK2yKnedgWXvfkXaQ3/IisASzcpFUZhlvnHBvDPvZwSxUqmplv5
         howitqyLENFl3J8GfKOtbL5sdS/sl0EdoGQNZJhuwY3YI38ueil4aVEranKfZ5D4962X
         sKJdYlu7LH6ODPLrcPPrSX8qY0XtxBVveymlnxX/Xkxwz2RwLdSVcvpUi09DZMWZEDqB
         a6kakT0cV2Or60yQ3TZHoiEPcUpwygDCH9AMqviZRxyfDIGbQtiODqT3rRpyGhs9GiJ/
         lamA==
Received: by 10.50.191.200 with SMTP id ha8mr1616317igc.45.1336740706135; Fri,
 11 May 2012 05:51:46 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Fri, 11 May 2012 05:51:15 -0700 (PDT)
In-Reply-To: <CAGK7Mr7qdTwfha8aUdXE4FeXjA0rW3JL0q=a9kHArirjv5bygg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197672>

> > I know there is `skip_commit` for git filter branch with
> > --commit-filter which squash the current commit with the next one,
> > however I have trouble finding a "fixup" equivalent that'd squash the
> > commit with the previous one (just like git rebase -i allows).
>
> Probably doable with an index filter that updates the index for the
> parent commit with the contents of the fixup commit and a commit filter
> that skips the fixup commit.


Hum, I'm unsure about how this would look... can I use "git commit
--amend" inside a commit-filter?

Also, how can I know in advance that the next commit will be a fixup commit?

Thanks,
Philippe
