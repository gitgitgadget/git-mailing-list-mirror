From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: checkout extra files
Date: Tue, 4 Sep 2012 15:24:28 +0200
Message-ID: <CAB9Jk9D0DHBJEpVq=Z=12TV=+Av0oFVZ0yO1svLh1wyuP+9r1Q@mail.gmail.com>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
	<CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
	<7vsjayew50.fsf@alter.siamese.dyndns.org>
	<CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
	<7vd322ebsz.fsf@alter.siamese.dyndns.org>
	<CACsJy8C36eghwEOYqbnd2z5C5KnynWsvwMDa4e2hns3uW243EQ@mail.gmail.com>
	<CAB9Jk9CNYr6LfWvyVqXvHjh7dzhUAuzkufqO9YMeOXg08D2cJw@mail.gmail.com>
	<CACsJy8AUYigHVKjzE-0NT0hnOrQWdufN+COmkk=2Q8L1Rimytw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 15:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8t7N-0005ab-UN
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 15:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079Ab2IDNYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 09:24:31 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:57242 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab2IDNYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 09:24:30 -0400
Received: by vbbff1 with SMTP id ff1so6591178vbb.19
        for <git@vger.kernel.org>; Tue, 04 Sep 2012 06:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y6vPrdE9C5r8lU11/pmktDyEJIy3JAqisl0/Ev6lM3Y=;
        b=01s8vnQUMvVrjFbnRI/VUAk2nie7LZB66x9FQkTLzR6wVTDC96lakfxaZRfvktwy8F
         e/OnJ+U8jMFJ0MZaMoeDehzsDLqk09Ea4gqWOym82yVVyW73yufkw2SPVAKECNb6TLOY
         77yCRq994sDRKNYRPgFFgksgytHP3MQ0H9F8kHOgvg4TxwdjYwQ8aZbKCnav6JwaLpXm
         83JFu09mWroOfAxGHy9nBz9RJbDcmrc+VJhe93DhBqwUJblPW+7Zg57O35WyPhxqiay7
         k0yOc49EJq0YeZW3ntxHH+AWEt/xfXJWLlKxiyZL0U3L8QlWYhldKD4HatpMUmVU/3sX
         BouA==
Received: by 10.52.26.111 with SMTP id k15mr11163883vdg.23.1346765068639; Tue,
 04 Sep 2012 06:24:28 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 4 Sep 2012 06:24:28 -0700 (PDT)
In-Reply-To: <CACsJy8AUYigHVKjzE-0NT0hnOrQWdufN+COmkk=2Q8L1Rimytw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204745>

Hi Duy,

the semantics of "git checkout -- '*'" is quite clear because there is
no expansion done by the shell. The wildcard is passed to git checkout,
that interprets is properly.

That of "git checkout -- *" is the problem when the directory is empty.
Note that this happens with the shell that is shipped with git (in the
windows distro). A note in the documentation could help the user
to understand this.

-Angelo
