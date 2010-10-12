From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Automating svn<->git gateway
Date: Tue, 12 Oct 2010 22:31:59 +0200
Message-ID: <20101012203159.GC30870@efreet.light.src>
References: <20101011193007.GA30870@efreet.light.src>
 <m3eibv6vah.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 12 22:32:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5lW5-0004r6-GA
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 22:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265Ab0JLUcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 16:32:03 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:48885 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab0JLUcC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Oct 2010 16:32:02 -0400
X-ASG-Debug-ID: 1286915518-5efa3bcc0001-QuoKaX
Received: from efreet.light.src (152-31-80-78.praha.adsl.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id D8TTjBjSBAjbxzCe; Tue, 12 Oct 2010 22:31:58 +0200 (CEST)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1P5lVv-0002cG-Oo; Tue, 12 Oct 2010 22:31:59 +0200
X-ASG-Orig-Subj: Re: Automating svn<->git gateway
Content-Disposition: inline
In-Reply-To: <m3eibv6vah.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.praha.adsl.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1286915518
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5020 1.0000 0.7500
X-Barracuda-Spam-Score: 0.85
X-Barracuda-Spam-Status: No, SCORE=0.85 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=BSF_SC0_SA085
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.43498
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.10 BSF_SC0_SA085          Custom Rule SA085
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158877>

On Tue, Oct 12, 2010 at 12:54:54 -0700, Jakub Narebski wrote:
> Jan Hudec <bulb@ucw.cz> writes:
> 
> > I want to set up a gateway between subversion and git, which would keep the
> > master synchonized with subversion trunk, both ways, and allow working with
> > any additional branches independent of subversion. For users it should behave
> > as any other shared git repository accessed by push and pull. And it needs to
> > be automatic.
> > 
> > Did anybody try to set up something like this?
> 
> It is a pity that "Native SVN support in git" project at Google Summer of
> Code 2010 (https://git.wiki.kernel.org/index.php/SoC2010Projects) turned
> out to be too much for one summer; though people are working on it.  It
> would be perfect for this situation.

I am not actually sure it would. What I want is that for people who already
switch to git may immediately stop caring about subversion. From their point
of view, it shouldn't be there.

So while I'm sure the native SVN support will solve the quirks and bugs of
git-svn, it will not do away with need for the gateway repository that will
somehow synchronize itself with subversion.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
