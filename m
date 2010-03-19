From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Fri, 19 Mar 2010 15:12:12 +0000
Message-ID: <3f4fd2641003190812p7625f2a6l4678d9a01fcdbd6a@mail.gmail.com>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>
	 <m3tyscjt7h.fsf@localhost.localdomain>
	 <b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 16:17:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsdwz-0001x9-L3
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 16:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153Ab0CSPMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 11:12:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49571 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0CSPMP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 11:12:15 -0400
Received: by wyb38 with SMTP id 38so1561830wyb.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=OGg8U6IB7Bizi0ZDTF018jgQ+y7pD0YYhJxcDKF6BL0=;
        b=q/V9AS6PViaphHuWjPRrIQkxU8UHQ6VzbRrEJlFxUJ6vubSgqgD6K2xjea97KSVJha
         KxqxtsoxPMTXLoT+hE6inCL7KrWTOlPn5ZFoQWWfXaRHz0nVgWY0SMogFllXQERQGx1D
         hm/mJ011ZeBn7d4bHwwWENbHOIzbBw+k5iE1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Y/jLCA9uAQrKJvdphT5YnkezdX9IPiumphyM6cZnJ25jN9XuLw5h7pGWMth0kAshkQ
         ayBvPBkDuw2ihrD9kxP0lCYUuPvbEKS0P+XIaPCboKXe3oDmoY8umuHIbXn3tFz9e9ws
         klkq9N7kreEiuYLJyEeNginaVZVAMKHz2RSPM=
Received: by 10.216.163.133 with SMTP id a5mr1866969wel.82.1269011533794; Fri, 
	19 Mar 2010 08:12:13 -0700 (PDT)
In-Reply-To: <b4087cc51003190740h680b5dech4edd7a5000f180ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142613>

On 19 March 2010 14:40, Michael Witten <mfwitten@gmail.com> wrote:
> Strictness about names and emails is difficult, and keeping something
> like the current .mailmap file up-to-date is a centralized process.
> The uuid field would distribute the responsibility of maintaining
> identity and make that responsibility easy because the user-chosen
> string is easy for that user to remember and is typed only very
> occasionally and under very specific circumstances.

I don't get this - it is the other way around.

For the mailmap file, you check that file into the git repository
itself. Therefore, by implication, mailmap *is* distributed. It is
therefore kept locally and accessed locally. It also does not suffer
from configuration issues, as you don't need to re-enter it if you
change your computer.

For a uuid to work the way you intend it, there would need to be some
universal central server that would be queried to look up and resolve
the uuid so you can get consistent user identification information for
every git command by every person/script from every git repository.
This is never going to fly for all the reasons distributed VCSs were
created in the first place.

Unless by distributed you mean in the .git/config file, which is
always local and never distributed to others. However, the uuid data
in the repository will be distributed in the repositories, so how is
this any better than what git has now?

- Reece
