From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: git log --since --until
Date: Wed, 4 Jan 2012 14:32:49 -0800
Message-ID: <CAE1pOi2vi8WHFNg2+NJCWnQ_atnCTRKXyBDJJpA8GM6nHmj6HQ@mail.gmail.com>
References: <CAE1pOi30FL+hRSqr3XRNgvOr4yBcTsbTpiNXpxJ=CN1Q=JVo3w@mail.gmail.com>
	<7v62grp0z4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 23:32:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiZOB-0001p9-Nq
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 23:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab2ADWcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 17:32:52 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:64212 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757115Ab2ADWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 17:32:50 -0500
Received: by qadb15 with SMTP id b15so11859334qad.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 14:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=J+LKtwY2ITD0MKkck2+Z/ts2RBMsNCkYg51x0XNFXCw=;
        b=CQ40mP2BR6CrspBoOKD2AoozDeIL1tXhb9EjmKyZvbF/Tr75nKrwMc2pUz55qqXLxp
         23ze3hqW21DbVpKH4mYMXlkRslz06cF+b4IXfZ5UbGwcVPxyghgKREY3rKkf0RRcpZ3A
         09mg93C+UirUfo6ut6q14FehiEEP/oQJcWFs4=
Received: by 10.224.205.134 with SMTP id fq6mr69893791qab.99.1325716369937;
 Wed, 04 Jan 2012 14:32:49 -0800 (PST)
Received: by 10.229.191.140 with HTTP; Wed, 4 Jan 2012 14:32:49 -0800 (PST)
In-Reply-To: <7v62grp0z4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187952>

On 4 January 2012 14:16, Junio C Hamano <gitster@pobox.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> git log --since="01-Dec-2011" --until="31-Dec-2011"
>>
>> The returned list of commits also included a few from November.
>
> These limits act on committer dates. Are you by any chance looking at
> author dates instead?

I had to look that up. :-) Yes, I'm apparently looking at (and for)
author dates. I don't really care when the commit was merged into
master (that's the committer date, right?), I want to know when the
work was done.

I didn't really see any useful switches for git log in this regard but
then the author date seems to be additional data without special
meaning to Git.
