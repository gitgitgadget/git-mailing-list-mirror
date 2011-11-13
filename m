From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Mon, 14 Nov 2011 01:14:35 +0300
Message-ID: <CAHkcothpwYHK7qtmCE-XR8kVKb9bqfbSiWjLPW82SOEhohXR1g@mail.gmail.com>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: vinassa vinassa <vinassa.vinassa@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 23:14:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPiKA-0002UM-32
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 23:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab1KMWOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 17:14:37 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44479 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab1KMWOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 17:14:36 -0500
Received: by qadc14 with SMTP id c14so974040qad.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c9VvBEZGV0ohH/7KUB1BkbUi/4UPqXrIG79cgwby38k=;
        b=IuZwMHpOZpAeeh7OLdWjhis3APcnN1mwK7Z3ZMyahKp66M6oLljm3q4AdvEed7mWes
         VccYSCk1Td74zzZem4OpynSu8E3v7+iVRfJyL3ejWbWfOz39krUI3xp9awKnwlM3b12P
         peYedLaBHZi7FKZuzlbKSK0YQSeFt6+KWd0+4=
Received: by 10.224.212.10 with SMTP id gq10mr12695784qab.75.1321222475909;
 Sun, 13 Nov 2011 14:14:35 -0800 (PST)
Received: by 10.229.236.18 with HTTP; Sun, 13 Nov 2011 14:14:35 -0800 (PST)
In-Reply-To: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185351>

On Sun, Nov 13, 2011 at 9:04 PM, vinassa vinassa
<vinassa.vinassa@gmail.com> wrote:
>
> I found some mention of this in the archive, more about SHA-1 security
> implications, that were dismissed, but here I am looking at just a
> random, very unfortunate case, and just wondering if in this case I
> would end up in a FUBAR situation.

I do not see how such an event would be very unfortunate considering
that it would make you instantaneously famous, so you could write a
lot of articles about what happened and make a fortunate of it... but
if we consider a _far_ much more likely event like some object from
the sky falling directly on your head at the moment when you are doing
a commit, that I would be really very unfortunate... So, maybe, you
should rent space in a bunker first just to work safely...

Seriously, it is so ridiculous to worry so much about so improbable
event, while in practice a lot of repository corruptions comes from
unreliable DRAM, disk storage, or some other reasons. The mean time
between failures for high quality components is only a few hundred
years while doing a commit every second will take dozen million
times more than the age of our universe to generate a collision. So,
those probabilities are so different that there is nothing in our
every day experiences that has the same scale difference. It is like
a hair width and the distance to the closest star.


Dmitry
