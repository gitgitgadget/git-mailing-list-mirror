From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 14:27:48 -0700 (PDT)
Message-ID: <412634.67173.qm@web31803.mail.mud.yahoo.com>
References: <200806032229.40447.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:28:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3e3g-0008T2-CC
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 23:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbYFCV1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 17:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbYFCV1u
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 17:27:50 -0400
Received: from web31803.mail.mud.yahoo.com ([68.142.207.66]:21958 "HELO
	web31803.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752436AbYFCV1t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 17:27:49 -0400
Received: (qmail 67702 invoked by uid 60001); 3 Jun 2008 21:27:48 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=QnHT1Zq8Cxbs/CPFIsNUKxq+FQklYiRuv1cqrsUTJ2G/nNX0Oo+asUkxQgdKjlPdOOq+m6bD0PaH+Si6fuKB8Huj7VTM3HGOjhCTK8zuQSeBwb7VYNRb8u+ZYmw4tpxSD3BcI+sBlRTgAp7rj2FmCLXJyYJcIWQZtGrhxe9DdvM=;
Received: from [99.159.44.58] by web31803.mail.mud.yahoo.com via HTTP; Tue, 03 Jun 2008 14:27:48 PDT
X-Mailer: YahooMailWebService/0.7.199
In-Reply-To: <200806032229.40447.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83713>

--- On Tue, 6/3/08, Jakub Narebski <jnareb@gmail.com> wrote:
> > > > +           my $parent_commit =
> <$dd> || '';
> 
> By the way, here you would probably want 
> 
> +           my $parent_commit = <$dd> ||
> '--root';
> 
> (if it works).

AFAIR, I did experiment with the "--root" parameter.  Not sure why,
but my command line ended up without it, and thus git_blame2()
ended up without it.

If you feel that it is, at this time having had changes commited since my
original commit, more correct to include it, then please go ahead.

Thanks!
   Luben
