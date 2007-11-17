From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Sat, 17 Nov 2007 20:18:46 +0100
Message-ID: <20071117191846.GE5198@efreet.light.src>
References: <11949569992214-git-send-email-msmith@cbnco.com> <fhcb29$ef$2@ger.gmane.org> <20071117164501.GB5198@efreet.light.src> <200711171918.40981.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:19:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItTCA-0007Wb-Tt
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 20:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760497AbXKQTSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 14:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760175AbXKQTSw
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 14:18:52 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:49313 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759498AbXKQTSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 14:18:51 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id EDBB05740A;
	Sat, 17 Nov 2007 20:18:49 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Katr239ZsV3i; Sat, 17 Nov 2007 20:18:47 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5BC2E573BF;
	Sat, 17 Nov 2007 20:18:47 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1ItTBm-0000Wp-QD; Sat, 17 Nov 2007 20:18:46 +0100
Content-Disposition: inline
In-Reply-To: <200711171918.40981.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65297>

On Sat, Nov 17, 2007 at 19:18:40 +0100, Jakub Narebski wrote:
> On Sat, Nov 17, 2007, Jan Hudec wrote:
> > On Tue, Nov 13, 2007 at 15:07:05 +0100, Jakub Narebski wrote:
> >> Michael Smith wrote:
> >> 
> >>> +You can use the gitlink:git-cherry[1] command to display the commit
> >>> +IDs that are only present on your local branch, or only on the remote
> >>> +branch, respectively:
> >> 
> >> I think git-cherry is deprecated in favor of "git log --left-right" (with
> >> appropriate format, for example '--abbrev-commit --pretty=oneline')
> 
> Not true. git-cherry is more than --left-right, as it checks
> if changesets matches, not if commit id matches.
> 
> > git log has such option?
> > 
> > $ man git-log | grep -e --left-right; echo $?
> > 1
> > $ git --version
> > git version 1.5.3.5
> 
> It has, although it is hidden in git-rev-list(1) manpage. It is a bit
> obscure corner...

I hope the new option parsing ifrastructure will take over quickly and start
to be used to generate the short help and probably even option section in the
man pages. It's unfortunately not the only option that is not mentioned in
the manual page of a command that has it.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
