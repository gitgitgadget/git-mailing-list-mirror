From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] user-manual: Talk about tracking third-party snapshots
Date: Sat, 17 Nov 2007 17:45:01 +0100
Message-ID: <20071117164501.GB5198@efreet.light.src>
References: <11949569992214-git-send-email-msmith@cbnco.com> <fhcb29$ef$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 17:45:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItQnS-0004ps-0W
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 17:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbXKQQpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 11:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755018AbXKQQpM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 11:45:12 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:37680 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377AbXKQQpK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 11:45:10 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 9712757475;
	Sat, 17 Nov 2007 17:45:08 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 47L3i6+ViKyR; Sat, 17 Nov 2007 17:45:06 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 9BD6357463;
	Sat, 17 Nov 2007 17:45:05 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1ItQmz-0006hq-Sm; Sat, 17 Nov 2007 17:45:01 +0100
Content-Disposition: inline
In-Reply-To: <fhcb29$ef$2@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65287>

On Tue, Nov 13, 2007 at 15:07:05 +0100, Jakub Narebski wrote:
> Michael Smith wrote:
> 
> > +You can use the gitlink:git-cherry[1] command to display the commit
> > +IDs that are only present on your local branch, or only on the remote
> > +branch, respectively:
> 
> I think git-cherry is deprecated in favor of "git log --left-right" (with
> appropriate format, for example '--abbrev-commit --pretty=oneline')

git log has such option?

$ man git-log | grep -e --left-right; echo $?
1
$ git --version
git version 1.5.3.5

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
