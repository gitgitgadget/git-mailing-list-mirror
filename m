From: "Alexander E Genaud" <alex@genaud.net>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 10:57:28 +0200
Message-ID: <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
	 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
	 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
	 <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com>
	 <48AA7BE9.4040108@sneakemail.com>
	 <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Peter_Valdemar_M=C3=B8rch_(Lists)?=" 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVN2x-0000w6-1b
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbYHSI5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 04:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYHSI5c
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:57:32 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:52199 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYHSI5a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 04:57:30 -0400
Received: by gv-out-0910.google.com with SMTP id e6so630253gvc.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=1sP6o1kENbG7ML1OXlXj0Bz4pVDb/hI5Swus9Q7Hp/k=;
        b=Z9zmEFNR3YXNN4f26XdUB8tskY8iC/hoAWdFu1Qhkmb92w8kmyy54/orzmbx91IQVI
         wxmY8NOdngKo8AZEbnEY+PQJjxCL6NVEe/4O9QjlUPxHoqnnlFx2EcravKycw0FFRY8O
         zaEMlI/U/KYDQZMa33uqHB8wBMuPAxzZwcj8E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=c0KW3iy08r3r0DuU5VYIfUlGTrpmXEBuhioPoVooWiv9XuwT3xN3vH7sZ2m2g4Iv7p
         F99sXx4/ND2OWPd77C3kIP8fCjIIzEVIGkLLAxD9rD7YgPxziU4DVXGp/iR4zvNHKivC
         uItaBfeIIpuh67J6iTzM5MtwYhISaVMz6cPEE=
Received: by 10.102.247.4 with SMTP id u4mr4619470muh.94.1219136249018;
        Tue, 19 Aug 2008 01:57:29 -0700 (PDT)
Received: by 10.103.8.1 with HTTP; Tue, 19 Aug 2008 01:57:28 -0700 (PDT)
In-Reply-To: <7vk5edfn6g.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 4aada847cb102fd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92837>

Hi Junio,

I would volunteer as the documentation git-virgin. To prove the hymen
intact, here are some of my thoughts and stumbling blocks over the
past two weeks:

There is no indication in the documentation distinguishing porcelain
from plumbing. Perhaps there is a grey scale, but operations that do
not move the HEAD to the latest should indicate that fact (for
example, pull vs. push, fetch).

Remote never seems to do what I expect, so I manually edit the
.git/refs!! Nor is git-reset what I expect and use git checkout (which
does make sense only after a few backup trials). Git-add adds to the
index but does not create, however git-rm removes from the index and
does delete (an --index-only or --keep flag might be nice).

A single term for cache and index should be decided upon. git diff
--cached is not intuitive when 'index' is used throughout the
documentation. Generally the index is a simple and powerful concept
that should be more thoroughly explained. Likewise for moving the
HEAD, though I don't yet grok it (git-reset HEAD^, git push, git
fetch).

Squashing commits into one is something I do often, and carefully read
the manual every time, whether it's merge, rebase -i, etc. I would
expect all merge-like functions to have an option to squash all new
commits into a new single commit (rather than upon the latest commit).
I'd also expect an abort option at all times during the git rebase -i.
For example, when asked to create a single squash commit message, I
might get cold feet.

I'd expect most commands to accept a branch argument without having to
check it out first, such as git-log and git-status. Git diff might
allow flags before branch, directories, etc to avoid ambiguity (such
as when a branch and directory have the same name)

Cheers,
Alex

-- 
[ alex@genaud.net ][ http://genaud.net ]
[ B068 ED90 F47B 0965 2953 9FC3 EE9C C4D5 3E51 A207 ]
