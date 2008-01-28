From: "Sebastian Schuberth" <sschuberth@gmail.com>
Subject: Re: git merge with tkdiff fails (extra operand)
Date: Mon, 28 Jan 2008 15:37:23 +0100
Message-ID: <bdca99240801280637s1e90f182tc02026501c23a4da@mail.gmail.com>
References: <fnk90t$gkq$1@ger.gmane.org>
	 <alpine.LSU.1.00.0801281309240.23907@racer.site>
	 <bdca99240801280605i55f3df00na0eea23488d26e17@mail.gmail.com>
	 <alpine.LSU.1.00.0801281423390.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 28 15:38:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJV7Y-0003Pw-2w
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 15:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605AbYA1Oh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 09:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbYA1Oh0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 09:37:26 -0500
Received: from hs-out-0708.google.com ([64.233.178.250]:43665 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752831AbYA1OhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 09:37:25 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1574878hsz.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=I6HiGblA7cIZI25O05wfYyMzM1uaxafxMJJdp4auuSQ=;
        b=FRYpYDfnYLqyYiaJVvYDVNEtJef8S5/lNUyD9L7w4VlKAjnnzKPWZKtrhJvuLDIn13J+DCvUFCpOKJeuzoUsXXaNnv/U0rO7k8vf9cJPpE4k4sjBmC259jfC3Hp0oRIyYk2effEL/75Do3ou2OtUo9beOzXkJGgpxF8Ca4DMAV4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NkrfHo4r5fGaDg3uJXwNNBFerxnXbTATTyQelQdE08tpXJtmKbBVGJe21eimLeH+HHYuuDwjEt/60WEpBWJSL/0Xk2NtVtAhbfUNJiguCE4weDn5tHmuS7hQkyqZZT+nN6nGJR9UvF9pCSE0aPqaCaU6IbzjiAwn5VmtjoQM9Mo=
Received: by 10.141.132.8 with SMTP id j8mr3489215rvn.7.1201531043339;
        Mon, 28 Jan 2008 06:37:23 -0800 (PST)
Received: by 10.140.134.7 with HTTP; Mon, 28 Jan 2008 06:37:23 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0801281423390.23907@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71890>

> > > It seems that tkdiff calls diff with arguments that diff does not like.
> > > What version of tkdiff do you use?
> >
> > I'm running TkDiff 4.0.2 (and "diff (GNU diffutils) 2.8.7").
> >
> > > P.S.: to make sure that it is tkdiff, I would search for this line in
> > > tkdiff:
> > >
> > >         set g(debug) f
> > >
> > > and change the "f" to "t".
> >
> > I cannot find this line in my version of tkdiff ... in fact, the
> > string "debug" does not occur anywhere in the file.
>
> Ah, I was looking at the latest and greatest: 4.1.3.  You can, too:
>
> http://tkdiff.cvs.sourceforge.net/tkdiff/src/tkdiff?revision=1.48&view=markup

Thanks, with that version it works for me (the link actually downloads
version 4.1.4 currently). Maybe the minimum version of TkDiff should
be listed as a prerequisite, or "git mergetool" should be enhanced to
support older versions, too.

-- 
Sebastian Schuberth
