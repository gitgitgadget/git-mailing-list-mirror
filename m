From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Add USER environment variable to executed git commands 
	when serving
Date: Wed, 3 Jun 2009 11:54:50 +0530
Message-ID: <2e24e5b90906022324pe6769d5vfa5e3eec44daeaf3@mail.gmail.com>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
	 <20090602135659.GA4320@macbook.lan>
	 <2e24e5b90906021804tf3db263qc41a6f8b171111e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tv@eagain.net
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBjuF-0001H9-7H
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 08:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbZFCGYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 02:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbZFCGYt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 02:24:49 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:30864 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754313AbZFCGYs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 02:24:48 -0400
Received: by an-out-0708.google.com with SMTP id d40so17895032and.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 23:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fqHamhfGJYI3HZSgP3iIQsTdXkBFsVEHRl+PDbJaF60=;
        b=ZGliTIITWfy4GBQiHiGHbXGtxtmtEHNyZdluOqOyBCJfarByAGOjuFi8MldICtzT4B
         fIzr4wqtm8QXFgNaA66eSw37YNwwhWM0WllSm0bxdy0/tsKvxi6oc3cI4nWsHWlTi414
         q7segCzwP5kuMa1v2meNB0bhfb3p7koxaPf2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t282lnt8IEPgv4QpaAPEoGJ6VOs/5FFSGbqI7lgGghJ8pZeMkk2SWBfhpvhgobwhGj
         MW2G7eM9CbC1UUoxPXVA4kHhDY3r71MlEwway+dCP1QBzxlQB6ONta38XkB6CTnmkMDO
         PEzfFDWmorhsh3SHAmKVnqklQK52YQtTtVUqk=
Received: by 10.231.36.6 with SMTP id r6mr166988ibd.0.1244010290243; Tue, 02 
	Jun 2009 23:24:50 -0700 (PDT)
In-Reply-To: <2e24e5b90906021804tf3db263qc41a6f8b171111e1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120582>

On Wed, Jun 3, 2009 at 6:34 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:

> I will test it out today at work and report back but it should work; I
> don't see why it wouldn't, unless somewhere else there's a
> sanitisation of env vars going on for security.

works beautifully!  Thanks again.
