From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Watchman support for git
Date: Sat, 10 May 2014 12:26:36 +0700
Message-ID: <CACsJy8B6AVOHH7HhreqvusQN=UFZzj1mkjqekrOb62Lmq_8VQw@mail.gmail.com>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat May 10 07:27:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wizob-0005up-TX
	for gcvg-git-2@plane.gmane.org; Sat, 10 May 2014 07:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbaEJF1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 01:27:09 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:41963 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbaEJF1I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 01:27:08 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so5516980qga.34
        for <git@vger.kernel.org>; Fri, 09 May 2014 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2qZFlF4B75tbli0XzAXkJEIEOlLsi3sNY8ME4O1+zk0=;
        b=ygzcrC7SmmnL8wlz/jUqzn0QIHyAsAvDTW1xIumeyed8kmbG+nl4fF0wRmCEs9gjjr
         vwlmiCwfI3a0GSUe3qZcYGHq8oJdIPz1nWlk8gyy24cEVdjAEehgvuOb7IJ/aS5oQufz
         oLNUZT07mpb7ZyWNsT4AKh3xHeSYMOpJFHwHZciorpA7zMQm/TSID4Xq7yf9yyIvwcRe
         EluBqTFBc1JzJbwI1AVg9rlc5d7kbBND1y4e/QZtWsKdtgQ1MklNwqiW8L5E8VvFOIc0
         C2p9JhT6LzLL7Ce2rqNzrcrIUULwIvKruDoU8J4w2IO8gGAbt/Zn89QRdjK4aly22I/h
         r46A==
X-Received: by 10.140.80.40 with SMTP id b37mr19547411qgd.98.1399699627727;
 Fri, 09 May 2014 22:27:07 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 9 May 2014 22:26:36 -0700 (PDT)
In-Reply-To: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248651>

On Sat, May 3, 2014 at 6:14 AM,  <dturner@twopensource.com> wrote:
> The most sigificant patch uses Facebook's watchman daemon[1] to monitor
> the repository work tree for changes.  This makes allows git status
> to avoid traversing the entire work tree to find changes.

I got "warning: Watchman watch error: Got bad JSON from watchman
get-sockname: '[' or '{' expected near end of file". Any ideas what I
did wrong? I'm using watchman.git and libwatchman.git. check-0.9.11
and jansson-2.4 were installed by system (gentoo).
-- 
Duy
