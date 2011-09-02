From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: git-checkout silently throws away the dirty status of index
 without a warning?
Date: Fri, 2 Sep 2011 11:52:56 +1000
Message-ID: <CAH5451mU1DOb3T27U4kYCFzhSVRzmP6Z94h+5oq-K5CU71gTBg@mail.gmail.com>
References: <CAEvN+1h+mY+f3dzK7LFOwkqokOZSS-LosCzBqtYGbyjz=Dg7Zw@mail.gmail.com>
	<7v1uw0xk57.fsf@alter.siamese.dyndns.org>
	<CAEvN+1hA1mUjDc0cQidEBOf5LhJ9LrVbTjyV5qPkUKNM6f7urQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tzu-Jung Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 03:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzIwS-0007Ff-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 03:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025Ab1IBBw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 21:52:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49954 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933019Ab1IBBw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 21:52:58 -0400
Received: by fxh19 with SMTP id 19so1216907fxh.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 18:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4XGSYEq8Hbww5yXdV6h8Qxiczd+ppjqy803oqwjNNcQ=;
        b=HhQIXjI2ICWB9mun9wglBAsRcHWCAYHn7LYbYNRhUG795lN8o+Ev2jeRE2279rDWXJ
         NOuzpgwdv3J0WpVQ/DssuCVKHybF4opXiYW5Qc0dhslDb0XSGFf/RhHCJzxCZS5Qaf3q
         XEnDzQlxybfhMN+2k9bZCUJ3g4wioYhWn0XVM=
Received: by 10.223.47.75 with SMTP id m11mr807216faf.55.1314928376467; Thu,
 01 Sep 2011 18:52:56 -0700 (PDT)
Received: by 10.152.42.233 with HTTP; Thu, 1 Sep 2011 18:52:56 -0700 (PDT)
In-Reply-To: <CAEvN+1hA1mUjDc0cQidEBOf5LhJ9LrVbTjyV5qPkUKNM6f7urQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180590>

> I accidentally switch to the switched-to branch without committing the
> intermediate status.
> The 'work' was gone, and I had no idea how to bring it back.

Forgive me if I am missing something here, but can't you use reflog to
go back to the point just before you checked the switched-to branch
out?

I guess the question is in general, how do you revert to a previous
instance of the working index AND previous checked out branch? I don't
know the 'switch branch with modified working index' mapping well
enough to be able to determine if there is a bijection possible, a
concise description of it would probably show us. If not, the only way
to achieve this is to keep the history available.

Regards,

Andrew Ardill
