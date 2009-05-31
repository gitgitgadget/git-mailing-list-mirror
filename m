From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] refuse to merge during a merge
Date: Sun, 31 May 2009 12:05:31 +0100
Message-ID: <43d8ce650905310405k4fa17240se7701e5fab2b22a7@mail.gmail.com>
References: <20090527210410.GA14742@localhost>
	 <43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com>
	 <20090530083721.GA12963@localhost> <20090531104359.GA19094@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dave Olszewski <cxreg@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun May 31 13:09:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAiuz-0008Hg-JQ
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 13:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543AbZEaLFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 07:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbZEaLFa
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 07:05:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:61949 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527AbZEaLF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 07:05:29 -0400
Received: by yx-out-2324.google.com with SMTP id 3so3882410yxj.1
        for <git@vger.kernel.org>; Sun, 31 May 2009 04:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bcU8jtegnGxedSz4jwTvb6XPQEakl/GNSmeaxqetDUE=;
        b=HnWh32SBtH/Xz783MtaGaW/kfKYBtSCNzYXHX5NLGrjqLN0dl24C3H7EkvjrH/2h3Z
         q2SsbZXjZwhr+nDImO32HZ3hpgtS10I44VYWa9bz09mkDoFV8jPFzg3JdqpsxrCv1ODv
         PNWFSHXjMzsUb4luNckoJXzWQS1AuuZYVYMek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cFKCtIka1ysjRs/EWL4c1FfzDUnuOWfVrCtc9WTmdWKF/vvAPCIfbYM9aUwrkjxOlW
         xhKOnOOXNscUWYUUNoRUU3QbDDFeHZo0bQ3QcdUKSTxVy9o9lI1zfhoup09X9pnMxQeN
         B1tU369HG/YEyfmxzl5LK2WrwjotKlYoTRopQ=
Received: by 10.151.75.7 with SMTP id c7mr9081080ybl.236.1243767931232; Sun, 
	31 May 2009 04:05:31 -0700 (PDT)
In-Reply-To: <20090531104359.GA19094@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120397>

> "git reset --hard" is not suggested, because it potentially removes
> changes unrelated to the merge (if the work tree was dirty prior to
> the merge).

Sorry could you just clarify...  if the user does "git reset HEAD"
will that sometimes always or never fail?

If it sometimes or always fails, then doesn't it seem kinda confusing
if the user is told to run that command, but then when they do they
get an error?

John
