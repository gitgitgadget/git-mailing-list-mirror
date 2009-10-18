From: demerphq <demerphq@gmail.com>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 17:37:38 +0200
Message-ID: <9b18b3110910180837h18e15f74g74626847b6ce4da3@mail.gmail.com>
References: <20091018144158.GA9789@gandalf.dynalias.org>
	 <4ADB3452.6030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Norbert Preining <preining@logic.at>, git@vger.kernel.org
To: alexandrul <alexandrul.ct@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 18 17:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzXpJ-0000xN-Cx
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 17:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbZJRPhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 11:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754647AbZJRPhf
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 11:37:35 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:52656 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754627AbZJRPhe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 11:37:34 -0400
Received: by ey-out-2122.google.com with SMTP id 9so760026eyd.19
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=jQ4Sp1iLuA30LAeqbvLqi3FSBFOBOUKgt5zfoi44DvI=;
        b=xJosW8Mnp1WPQPoUnzo/520UhUQXClWg2aDv5n+3lYOfh54PvmqtBIHd9UAbYagjEV
         pKo6rTtFmAc9srgDSGo+eJTsmXZN1qGpR658VAx5WkR6r1r/H7pMj6a+son3FDgrRQFI
         UvJJ544qcrvd3rNK56I0qhg4QpGaJnrCTeXDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=l4Hhzjccfnw0ATyCgLOXRHGpLOKW8MWLLwx8sETynqF7eBYtOGnyzprSdwDHN/cPwN
         jqAu95Zn48hjCr4HJn/W8P6fs6nQJVeq+SEDVFwVf5idxIk0mwHa0PPLyiQQJprIbKIE
         DrDhzXln7XqCLqvfR/XB7fwotTLhdTYRATxPQ=
Received: by 10.216.93.70 with SMTP id k48mr1372168wef.134.1255880258593; Sun, 
	18 Oct 2009 08:37:38 -0700 (PDT)
In-Reply-To: <4ADB3452.6030508@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130600>

2009/10/18 alexandrul <alexandrul.ct@gmail.com>:
> Norbert Preining wrote:
>> My idea is that git - like subversion - could (if asked to) count each
>> commit (global to the repository, irrelevant of the branch) and give it
>> a version number. Since we all will use a bare repository on a server
>> and pull/push from/to there, I think that something similar could be possible.
>
> I was thinking to set a post-commit hook that reads the current version
> from a file, increment and save it, and also set a tag with that value.
>
> Being a DVCS, this kind of versioning can only be trusted on a single repo,
> but if you set it on the "main" repo, it should work.
>
> The only drawback could be the ever growing number of tags,
> I don't know how it will work with thousands of tags or more.

I think the other drawback is that the number would essentially be
meaningless and more or less would just be a substitute sha1.

Consider when a remote adds commits and then merges and pushes. What
number should those commits have?

Yves



-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
