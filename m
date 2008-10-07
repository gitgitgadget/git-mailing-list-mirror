From: "Adam Mercer" <ramercer@gmail.com>
Subject: Re: files missing after converting a cvs repository to git
Date: Tue, 7 Oct 2008 10:55:38 -0500
Message-ID: <799406d60810070855y53cf5191m111ce8f5380f96c6@mail.gmail.com>
References: <799406d60810061502y417ec53o1a1f5cef800dfe45@mail.gmail.com>
	 <48EAFCEF.8030907@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?B?R0lU77u/77u/77u/77u/?=" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 07 18:00:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnEva-0001ND-LC
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 17:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbYJGPzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYJGPzk
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 11:55:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:1429 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbYJGPzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 11:55:39 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3468451wfd.4
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 08:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=sr+R8TaJ8RxtU9S1/Tnv2Dm7KU3Iso9h2p1vyzAKtvg=;
        b=m3B3fEJcxq5NrhhdbNVUTlZvLlHyYNtd0RdoHFp6RLiS32/Z+3+wOhK88FKYCQjtV1
         ZIUAdevHou9e6ZfktWy9WXpc93DBz2mWuUm5qNsciqi3GoEEUX21Kbz3ophCSAZ6LVRU
         UTwVp7dfMxwPZBGPI/ElGMMz2vXQBJEBFzPLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SzIibFjSuiFBNoNQWbsz0++g4ZavhK19nF9l39SvOTKhQZ1uStIJYNajsJHGaZBeqR
         Sd2xls9Wac+WFTijhR5Vt0coRMq5tiIoQWzY5Ipe39KS2RhWfSUEwaNEVAkry1Umezdk
         Q1gBg7w/bHfsjZ5WEWPNyYnQAkUsmpswkLLlE=
Received: by 10.141.44.13 with SMTP id w13mr4024844rvj.181.1223394938604;
        Tue, 07 Oct 2008 08:55:38 -0700 (PDT)
Received: by 10.141.28.18 with HTTP; Tue, 7 Oct 2008 08:55:38 -0700 (PDT)
In-Reply-To: <48EAFCEF.8030907@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97720>

On Tue, Oct 7, 2008 at 01:08, Andreas Ericsson <ae@op5.se> wrote:

> Has the CVS repo been tampered with in the past? If so, it's entirely
> possible that checking out and working with CVS works just fine, but
> getting history into coherent changesets is impossible.

Unfortunately yes. Thats what I thought, and was afraid, was going on.
I've managed to get things working by restoring some of the missing
files ,v files from a backup and regenerating the tracking
repositories. Then I had to remove the files in question from cvs and
readd them, git cvsimport then saw these files.

> cvs2svn is apparently quite good at getting even the weirdest history
> right. Perhaps you can try that and then running "git svn" on the
> resulting svn repo?

Thanks, I'll give cvs2svn a go.

> Good luck. You'll probably need it :-/

Cheers

Adam
