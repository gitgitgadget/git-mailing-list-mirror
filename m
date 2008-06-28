From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 10:12:14 -0700 (PDT)
Message-ID: <m3d4m1iivq.fsf@localhost.localdomain>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
	<9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	<7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
	<9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
	<9b3e2dc20806280734i6ca17cc8i447c2e2db67e8051@mail.gmail.com>
	<9af502e50806280930u788f81e2j77adf147a0e4d135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen Sinclair" <radarsat1@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 19:13:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCdzA-0003HM-Sl
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 19:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbYF1RMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 13:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753167AbYF1RMT
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 13:12:19 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:62137 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbYF1RMS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 13:12:18 -0400
Received: by fk-out-0910.google.com with SMTP id 18so865823fkq.5
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=eOLqrBEj2S1Hch0SibwE1zcEA3f9uKtpqyOLArkXL5I=;
        b=SfgR2lZv82FkzxMMjqtZ8QGiSItW5vtM+ILo3Znz2Aj+dztAHO2uspEWHokMIo3hfX
         1e+54iY03F6nlamsM+9mFfbgpcTp6gTowUufJzAqvenpW1sf/Ym0zISLAaJJjGBw1veq
         HfjpwKgzAt4j5YyAXNsLwoOUX/rXfxTa6T5Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=saalwg31+FByRA8fjR5dn7GxW4GJ2FRRAD0qWpI0QMF5oUNmIItI7JnfRcJbmUA/9m
         6UiIza2F1LvMOpXA9DPvmSoTo0vBSjCLmon5zPcHeBIfiogD2p1Moc8cN0OAVg345I0E
         vLUtv4arjghwbCm0UBgN3elUIH5VEwhwI05ao=
Received: by 10.78.161.4 with SMTP id j4mr817668hue.74.1214673136149;
        Sat, 28 Jun 2008 10:12:16 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.220.206])
        by mx.google.com with ESMTPS id 33sm2663985hue.28.2008.06.28.10.12.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Jun 2008 10:12:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5SHCBE9004776;
	Sat, 28 Jun 2008 19:12:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5SHCAEM004773;
	Sat, 28 Jun 2008 19:12:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9af502e50806280930u788f81e2j77adf147a0e4d135@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86730>

"Robert Anderson" <rwa000@gmail.com> writes:

> On Sat, Jun 28, 2008 at 7:34 AM, Stephen Sinclair <radarsat1@gmail.com> wrote:
> > The answer is simple: you should not be making partial commits to a
> > repo that has been cloned.  You should instead be working somewhere
> > else and then pushing to it.  So this whole sentence is just a moot
> > point itself.
> 
> Let me amplify my objection to this.
> 
> Who has 100% foresight that what they are doing is going to end up in
> a state where they'd like to make partial commits?  To take a quote
> from a blog post, 'Git means never having to say, "you should have"'.
> And mostly it doesn't, and that's big improvement over other systems.
> But, that is what you are saying here.  I "should have" realized that
> I should have pulled and fiddled with my changes there, and then
> pushed.
> 
> Well, Dmitri and others will now say, why not just always pull and
> work somewhere else?  And the reason is that because this creates
> extra, unnecessary steps the vast majority of the time when I do
> create a commit that I like and want to keep as-is in the first try.
> Why should I have to pull, commit, hack, and push, when hack and
> commit is all I need to do the vast majority of the time?  It is
> redundant, unnecessary work and complexity that I should not have to
> pay for when I don't need it.

I think that in most cases the setup looks like the following: there
is private non-bare repository, ehere you can use topic branches,
and change and rewrite those changes at will, be it using plain rebase,
rebase --interactive, or some patch management interface like StGit
or Guilt.  That is where you clean up your commits till they all fill
some standards / convention, like compiling (at least), or pass the
testsuite.

Then you merge it into one of long-lived "development" branches, and
push to your public (usually bare) publishing repository, which can
be for example on repo.or.cz, or on kernel.org.


That said "git stash (save|apply) --interactive" would be good
improvement for the situation where you have realized that you have
several unrelated changes in working directory, and want to decouple
them.  One solution would be to commit, then split using interactive
rebase (or patch management tool), but with stash I guess it could be
simpler.

You should avoid such situation by stashing and changing the branch,
or refrshing current patch (to return to it later) and generating new
one if you use StGit or Guilt...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
