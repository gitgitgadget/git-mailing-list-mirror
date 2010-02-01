From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Mon, 1 Feb 2010 17:44:25 -0500
Message-ID: <76c5b8581002011444t4f955fcdrd1f582f5c043f705@mail.gmail.com>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org>
	 <4B674E36.40708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eugene Sajine <euguess@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 23:44:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc50W-0001Tm-Ty
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 23:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab0BAWo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 17:44:27 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:37598 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0BAWo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 17:44:26 -0500
Received: by iwn16 with SMTP id 16so355467iwn.5
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=OP579lycU9kskMacqFBKPTzjCr8KaxXv18snKfiEPMA=;
        b=gIzT69fUJzz6FVhu4xodK4qYk8HjOdJbUeQjS/QxyndIVj16qb7FYLMZ0jB2vnfQuP
         jFsGolRS1J6F86ys34Vmz3zZO4XI1q3J2Jt1DfyTqHHKV3YK87+/M1s78RX7Ot3XsO9O
         02MyR+hSNz26djrT3j8Nh4vRNROLtKdQs8TdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wHzRYZAFfK2kp87+xunwwaxrBfvjAC8leGvBZD4Im53YVpMuuDULrx6gF+QBDJLMoG
         b21B4P2haU/Pjel/Ll9BIXDCeOzLWvt3KbUyIXTfzcAPFvFMp8SeX6ZeuEHYDygN39Wt
         jC/r7lhARiU05PbNYJo4dryZlS8NagR5o9w0s=
Received: by 10.231.166.68 with SMTP id l4mr8513961iby.40.1265064265505; Mon, 
	01 Feb 2010 14:44:25 -0800 (PST)
In-Reply-To: <4B674E36.40708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138653>

>
> I imagine that this case is useful because of usual work interruptions
>
> in software development. A developer tries to bring various tasks
>
> forward in parallel. Branches will be switched often with unfinished
>
> work that needs to be kept before the reactivation of another task.
>

Aren't this and similar statements based on a general problem of
people being afraid to commit, because CVS/SVN taught them to be
affraid? We are in progress of migrating from CVS to GIT and this is
one of the things i'm desperately fighting with.
In Git Commit doesn't equal Share (it does in CVS), so why not to
commit and save your work in progress and switch branches painlessly?

Thanks,
Eugene
