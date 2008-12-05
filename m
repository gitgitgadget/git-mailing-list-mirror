From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: git-gui: Warn when username and e-mail address is unconfigured?
Date: Fri, 5 Dec 2008 14:01:48 +0300
Message-ID: <bb6f213e0812050301t2f18061epfeff7bc74ee6f28a@mail.gmail.com>
References: <Pine.LNX.4.64.0812041141160.9969@ds9.cixit.se>
	 <b9fd99020812040805j1143c029yf0cc4c1c4a835759@mail.gmail.com>
	 <bd6139dc0812041104s26ae149foeafa489e65aeb584@mail.gmail.com>
	 <b9fd99020812041254l5d1fa383m4fcc3b40f6fabacb@mail.gmail.com>
	 <7vskp3d3q9.fsf@gitster.siamese.dyndns.org>
	 <b9fd99020812041558w204e5f48gbed73fdbd289ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, spearce@spearce.org,
	sverre@rabbelier.nl, "Peter Krefting" <peter@softwolves.pp.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jeremy Ramer" <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 12:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8YSi-0000w0-OQ
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 12:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbYLELBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 06:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbYLELBv
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 06:01:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:41112 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYLELBu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 06:01:50 -0500
Received: by ug-out-1314.google.com with SMTP id 39so4060682ugf.37
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 03:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WqcylqwNuGpntPihDn2oIzB/SEfwdneIy+mHtnpBM+I=;
        b=JFMyxVV2Ikpk8jDizxajpvbYltPNTxNPH0kJJSkNvg0nXUPxuOHhAONu0LdQBk2Bc4
         3bF4KEv8c5mQZD9xC6GPhUe2ENTGezUDs/eWDMRSozNm/YTqxiqeJloAdlVMb6N7Egte
         LSlkc3eaZYYAah1ffJ935yxN7Rk8a+ghxucHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rHQL0kRhNvAaW68TjbVOwlLuxczGQi7ESY88ElgGFYRUMgIMOjN7sBDK7FdfiCxACL
         mxeG48EGkuvbS+FpzJj7A705CJwoPjgRCsrkCqzpkVf00ne4SwuX4358llh1hQL1fklo
         BiOI/Ex8aSLe9ljjPrAqE3RJfsl4KVEL2fJWw=
Received: by 10.67.106.13 with SMTP id i13mr513852ugm.7.1228474908923;
        Fri, 05 Dec 2008 03:01:48 -0800 (PST)
Received: by 10.67.103.2 with HTTP; Fri, 5 Dec 2008 03:01:48 -0800 (PST)
In-Reply-To: <b9fd99020812041558w204e5f48gbed73fdbd289ad@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102398>

On Fri, Dec 5, 2008 at 2:58 AM, Jeremy Ramer <jdramer@gmail.com> wrote:
> Yes, that does appear to be the message I get, with the following
> environment variables:
> - GIT_AUTHOR_EMAIL
> - GIT_COMMITTER_NAME
> - GIT_COMMITER_EMAIL
> - GIT_AUTHOR_NAME
>
> Now that I look closer I see that I am setting these in my .bashrc
> file.  When I first started using git a year ago I was given the
> impression that these were needed. But I see that that is no longer
> the case since I use the config:
>
> git config --global user.name "Your Name"
> git config --global user.email "you@example.com"
>
> Removing them from my .bashrc removes the warning.  In hindsight the
> warning should have clued me in, but I've been seeing that message
> since I first started using git on Cygwin so I figured it was a cygwin
> issue that I couldn't do anything about.
>

I wonder if what the warning says is still true. It's 2 years since
it was added, so the issue might have been fixed.

If you run "GIT_AUTHOR_NAME=foobar git gui", and make a commit,
does it set the author name to 'foobar'?

Alexander
