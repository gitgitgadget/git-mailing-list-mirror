From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: RFC: Subprojects
Date: Thu, 12 Jan 2006 17:46:09 +1300
Message-ID: <46a038f90601112046u13d7075dsc2108111e2462152@mail.gmail.com>
References: <43C52B1F.8020706@hogyros.de> <200601120919.08354.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 05:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwuLt-0008PL-WA
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 05:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWALEqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 23:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWALEqM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 23:46:12 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:15018 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964999AbWALEqK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 23:46:10 -0500
Received: by wproxy.gmail.com with SMTP id i34so304570wra
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 20:46:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UhvUMqWL/5dMJ8JEr4DdReGVGu3fWMXVxcw/fHsGeG25cyNVNQRolTcI1GQxthgj0G6HeuwUgr4oY0hSztlFqLOdEErUra+0xNgKY40fW1k05PxsoWU8gdBynUbu+eaKEvyoWXPOVASyuzKXCuUWlBOBSpFT9cePDmfpnZHnjkk=
Received: by 10.54.76.3 with SMTP id y3mr2095306wra;
        Wed, 11 Jan 2006 20:46:09 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 11 Jan 2006 20:46:09 -0800 (PST)
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200601120919.08354.lan@ac-sw.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14544>

On 1/12/06, Alexander Litvinov <lan@ac-sw.com> wrote:
> On Wednesday 11 January 2006 21:58, Simon Richter wrote:
> > Hello,
> >
> > one thing that I have been missing so far in all SCM systems apart from
> > CVS (and there it's just coincidence) is the ability to include a
> > project as part of a bigger project.
>
> I really miss this feature. This is the last stopper for moving from CVS to
> git for out project.

What about using nested checkouts? They work great with git as-is,
just add an .gitignore file.

As Linus points out, there are many good reasons why a top-level
commit should _not_ commit the nested subproject. And once you are
observing that rule, what's left then? git status and git diff <HEAD>
can show an aggregate of top-level and nested subprojects, but that's
ease-of-use -- not something only.

What is your show stopper?

cheers,


martin
