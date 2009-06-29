From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: AW: Parallell Development / Switching to GIT
Date: Mon, 29 Jun 2009 12:37:42 -0400
Message-ID: <eaa105840906290937h14868eb8v7928951876f7e8f1@mail.gmail.com>
References: <loom.20090625T095000-90@post.gmane.org> <4A434D6F.2090105@op5.se>
	 <B81058949321C8439B9D742F5F8D8FCA01A75C1D@hpserver.intranet.local>
	 <20090628184714.GA8634@sigio.peff.net>
	 <B81058949321C8439B9D742F5F8D8FCA01A75C33@hpserver.intranet.local>
	 <4A487CCD.1040406@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Patrick Neuner - Futureweb.at" <neuner@futureweb.at>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jun 29 18:38:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLJrr-0007gL-1G
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 18:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbZF2Qhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 12:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753282AbZF2Qhl
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 12:37:41 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:64770 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbZF2Qhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 12:37:40 -0400
Received: by ewy6 with SMTP id 6so5811657ewy.37
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=7Zz/FgFDqkhPiOU+WvdVdakEF27sKx1GvfEVufesQKY=;
        b=Ix/OBqqzquQLfYlCdzl316WwEgqccAEwHgvg8sOwCcNFeNOsCqWi5FX0AliEsDmDGt
         4HGSaU727MXGKBeoZ8DyqLyuZZiUKaoYNJEBoOlNmXaEVGEq5O5A3C8mFmi/Gl6e2OGN
         huQiNrrzyfn8S/xIsmgEVNFASoWZNB/tl0948=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=qZMQ3ZWf0whoc04sMucgizNv8X07aKdN7Atika7/uRogyR1qbiKPhWqdx8E60lURw3
         SdyULG2v8HOKHy6J+8fFMJDvfBykjjuHCDBxxZkOrYQvqGJuftx7aUIgBWMM2AEgJg3r
         XCO8X1VoE886JotPJwzaTfoidfUuV6lzNw07g=
Received: by 10.210.89.7 with SMTP id m7mr2409756ebb.92.1246293462068; Mon, 29 
	Jun 2009 09:37:42 -0700 (PDT)
In-Reply-To: <4A487CCD.1040406@op5.se>
X-Google-Sender-Auth: a779c17fc70ff12f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122449>

On Mon, Jun 29, 2009 at 4:35 AM, Andreas Ericsson wrote:
> Patrick Neuner - Futureweb.at wrote:
>> But having 2 completly different repos would be another solution, but
>> I kinda wonder that mergin would work correctly this way (if both
>> sides have changes).

> I'd advise you to clone the linux kernel and inspecting its history
> using gitk. Every merge-commit you see which has a line saying something
> like "merge foo bar frotz of git://example.com/path/to/repo.git" is a
> merge with branches from different repositories. I wouldn't be the least
> surprised if you find more than 5000 such merges in the linux kernel
> history.

You got me curious, so I looked:

~/linux-2.6$ git log | grep -c "Merge.*git:"
4431

Not quite 5000, but still an average of roughly 2.88 such merges per
day, every single day, since the kernel was moved to git in 2005.

Peter Harris
