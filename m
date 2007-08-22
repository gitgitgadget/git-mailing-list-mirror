From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: git-svn: commit author x commit committer issue
Date: Wed, 22 Aug 2007 12:17:43 +0200
Message-ID: <8b65902a0708220317t2b3dd01csef460a943ed2ef37@mail.gmail.com>
References: <46B9C92B.3000000@st.com> <20070816092002.GD16849@muzzle>
	 <8b65902a0708220307g2cb4b290s9bbf4603af7489fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Richard MUSIL" <richard.musil@st.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 22 12:18:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INnHy-0007BW-0N
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 12:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756891AbXHVKRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 06:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757403AbXHVKRs
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 06:17:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:19713 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794AbXHVKRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 06:17:47 -0400
Received: by wr-out-0506.google.com with SMTP id 36so95135wra
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 03:17:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r/jFNS2vD/smcgvCY7K4/o/zwQ45kbT7wnANzO2063hPRY8YFASrps30TWZxZUhv6q3SeLAl8dJXY8XWl8BiSfjZ1cWDJni46xwAGjPbkyqE9anOh9wCR4zi579Tg02yMDhGA1RihACW4IUJtyF+n8LpOp6FJ8IGwmwXH8HArcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XF/jFJICSVzuY9BEn1lQ3PcacB/gkNJvX/OKcKekCFkPwNu23D79EcbgTCJZvuu7/gl+c8m9o5BSQ5LRy9Cs9vvBvoRA9Vc+SYzfRVxcEEOc8AuvuWEZjHhVeGk8gaAi19+QuFna+26gQ4ZjzuRePdPLczhKClS42Qje5IBWVmE=
Received: by 10.90.88.13 with SMTP id l13mr4151666agb.1187777863760;
        Wed, 22 Aug 2007 03:17:43 -0700 (PDT)
Received: by 10.100.46.11 with HTTP; Wed, 22 Aug 2007 03:17:43 -0700 (PDT)
In-Reply-To: <8b65902a0708220307g2cb4b290s9bbf4603af7489fa@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56366>

Oops, sory, I'm completly wrong: the git-svn-id is put on the commit
log in the Git repo, not on the SVN repo.
Please, ignore me.

On 8/22/07, Guilhem Bonnefille <guilhem.bonnefille@gmail.com> wrote:
> On 8/16/07, Eric Wong <normalperson@yhbt.net> wrote:
> > Richard MUSIL <richard.musil@st.com> wrote:
> > > Normally, when patch is applied, git distinguishes commit author and
> > > commit committer (relying on info from patch).
> > > However, after the patches are committed to svn repository using:
> > > git-svn dcommit
> > > author and committer data are set to same values (or at least time and
> > > date, I cannot verify it for names).
> > > I wonder if there is any reason for this behavior, because I would
> > > definitely like to keep original commit info (which came from patch) in
> > > my git repository.
> >
> > I try to keep commits made to SVN using git-svn as much like commits
> > made using other SVN clients as much as possible.
> >
> > Two people using git-svn (in its recommended fashion and maintaining
> > linear history) can have identical SHA1s in their repository even if
> > those two repositories had never seen each other before.  Consistency
> > is good.
> >
> > I also want to avoid creating extra junk on the SVN repository which I
> > don't personally consider very important.  SVK does stuff like that with
> > merges, and only SVK understands the metadata it uses.  I prefer
> > transparency.
>
> Instead of using SVN metadata, why not store the missing information
> like git-svn store the SVN rev id. (in the commit log as I know).
>
> --
> Guilhem BONNEFILLE
> -=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
> -=- mailto:guilhem.bonnefille@gmail.com
> -=- http://nathguil.free.fr/
>


-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
