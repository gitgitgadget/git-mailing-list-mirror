From: Kasra Khosoussi <kasra.mail@gmail.com>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 14:00:36 +0430
Message-ID: <BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
	<4E005404.5010901@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 11:30:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYxIC-0005zC-6n
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 11:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab1FUJai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 05:30:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33510 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314Ab1FUJah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 05:30:37 -0400
Received: by pvg12 with SMTP id 12so1337798pvg.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9Oi4ZJ9AqoHk7uOU2+V4pbFDlWmUHJZXy4jgrqXkT6A=;
        b=rUjah+p4UuxRuVrGKBCyee9OMTeGXu81bY2NAmRuur0vcZ6YuVoyG7GRfLI9LO/bgd
         rj66UgV6dmyc6S1MppeVq8HJgiuF3REqYXdTpk62BY6WTDYdWAW0fgCuwVBZMeLHxOlq
         ys4ywyDaoIu0gF7WnrEoHDuj/MWPpUJo+vvj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fKjsDeF2kqfLcI3pLJQ/BgfTTEe8Wqe1U1ny6JjVPcqRbkoqW/MSqvaXVZitu0L//u
         LSavij9gIG96CJyXqC2+0eaqYumu+EGPnwCuu4cNEfZjdNM2444wpbqzIzG8QAha4ESx
         VAlVAicPfixutxUzLUGJkIGrRiYhFyK/EI2Pk=
Received: by 10.68.19.131 with SMTP id f3mr2535583pbe.379.1308648636727; Tue,
 21 Jun 2011 02:30:36 -0700 (PDT)
Received: by 10.68.55.132 with HTTP; Tue, 21 Jun 2011 02:30:36 -0700 (PDT)
In-Reply-To: <4E005404.5010901@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176133>

> Backup now!
> I guess you've done that meanwhile anyways, but it's important before
> any recovery attempts.

Yes, I've done that.

> Is your reflog OK, i.e. do you get proper output from "git reflog" or
> "git log -g"?

No. Before moving the corrupted object git reflog would return:
fatal: object 0a83757505387aacc2fd36b3c996729e6bf9d6e5 is corrupted

and after moving the file it would say:
fatal: bad object HEAD

> .git/objects/0a83... probably

Yes, it was a typo.

> The reflog will give you the previous value of HEAD. You can set
> refs/heads/master to that (git update-ref) and then rebuild the lost
> commit on top of that (assuming only one commit is lost). The dangling
> trees are not necessarily due to the corrupt commit object. Have you
> changed any files since the corrupt commit?

Yes, I've changed two files after the last commit (I knew about the
corruption when I was just about to commit the changes).

> Do you remember which files
> you changed in that commit?
>
> Michael

If the the corrupt commit is the last one, yes.

Thanks.

-- Kasra
