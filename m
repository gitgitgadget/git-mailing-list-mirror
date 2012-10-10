From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] svn test: escape peg revision separator using empty
 peg rev
Date: Wed, 10 Oct 2012 22:16:13 +0000
Message-ID: <20121010221613.GA14466@dcvr.yhbt.net>
References: <1343468872-72133-2-git-send-email-schwern@pobox.com>
 <20120728141652.GA1603@burratino>
 <50143E34.8090802@pobox.com>
 <20121009084145.GA19784@elie.Belkin>
 <5073F2C0.6000504@drmicha.warpmail.net>
 <20121009101953.GB28120@elie.Belkin>
 <20121010203730.GA19115@dcvr.yhbt.net>
 <20121010210218.GB4517@elie.Belkin>
 <20121010213120.GA12935@dcvr.yhbt.net>
 <20121010214205.GD4517@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 00:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM4Zm-0007rV-GW
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 00:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab2JJWQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 18:16:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50938 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab2JJWQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 18:16:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3609D1F70E;
	Wed, 10 Oct 2012 22:16:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20121010214205.GD4517@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207448>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eric Wong wrote:
> > Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> >> -- >8 --
> >> Subject: Git::SVN::Editor::T: pass $deletions to ->A and ->D
> >
> > For future reference, it'd be slightly easier for me to apply if you
> > included the From: (and Date:) headers so I don't have to yank+paste
> > them myself :>
> 
> Ah, I assumed you were using "git am --scissors".  Will do next time.

I missed the addition of --scissors.  Will use it in the future :>
