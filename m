From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Towards a useable git-branch
Date: Fri, 24 May 2013 23:31:08 +0530
Message-ID: <CALkWK0kut8xVx1Q8dFrrjCSufJtJc=tvLKStf0tiWHzpfksG1g@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CaCv4eO2YH_bUKKKZWTxSu9zd3qaDQ5kdZQaKg64ggyQ@mail.gmail.com> <7vobc09sf6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 24 20:01:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfwJN-0007pB-38
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 20:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374Ab3EXSBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 14:01:49 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37642 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3EXSBs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 14:01:48 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so13284303iec.1
        for <git@vger.kernel.org>; Fri, 24 May 2013 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rQkX3dClE2bd3be5VrZ8d8dwulJFCSxeoLVf46k1M4s=;
        b=xc9FwHwj81HhkAzCnIooLIYEqrYVhtcwY6Bl2froO3nFTAUGrahxJCoMN1Drw6Vubw
         PSZGPOtTyO8WCv9Xnvr9W1HEILZVfPJDYTye2rR8NYWTWkbJXIqI1GeatFYg4qmdyn+M
         a4Nz1eRBlhRwWFfYJOSBYHnZ9rC0cCmtQbIyJ4BN2rofKNl2W4iOWRq6HH6PZvmWAiqY
         Mt8vNz8mknZT7BdudkrTPMfwH+WwZGArE/Tr/fvIynFp8RXPiSNy7T+ILK4f1NCOSUxU
         KTrpPyYBUbRAVNKCa6LBhI0Dt5jD8pfIUMl8Dn2rRjmLgdCp4Rou7p19/ODbBpvs/YMy
         osEg==
X-Received: by 10.50.66.140 with SMTP id f12mr154328igt.63.1369418508501; Fri,
 24 May 2013 11:01:48 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 11:01:08 -0700 (PDT)
In-Reply-To: <7vobc09sf6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225391>

Junio C Hamano wrote:
> I am having this feeling that we see more and more of this line of
> bad behaviours from some on the list recently to call something that
> is working in which they find itch using unnecessarily derogatory
> terms, and it makes people simply avoid any discussion that starts
> with such an attitude.
>
> Unnecessary negativity is not productive and it has to stop.

My apologies.  After all, we have all been using 'git branch' for so
many years without complaining.  I only noticed the itch recently:
it's a burning itch that I want it to be fixed very badly (hence the
series).  If anything I intended to convey the importance of the patch
to me personally, not about some "general truth" on the broken-ness of
git-branch.

Ofcourse I will take your suggestion and tone down, because I don't
want the git community to feel bad about the software they're
developing.
