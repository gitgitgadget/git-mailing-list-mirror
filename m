From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] svn test: escape peg revision separator using
 empty peg rev
Date: Wed, 10 Oct 2012 20:37:30 +0000
Message-ID: <20121010203730.GA19115@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-2-git-send-email-schwern@pobox.com>
 <20120728141652.GA1603@burratino>
 <50143E34.8090802@pobox.com>
 <20121009084145.GA19784@elie.Belkin>
 <5073F2C0.6000504@drmicha.warpmail.net>
 <20121009101953.GB28120@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 22:37:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM32G-0005Vv-P8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 22:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757324Ab2JJUhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 16:37:34 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50128 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757180Ab2JJUhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 16:37:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33AEA1F70C;
	Wed, 10 Oct 2012 20:37:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20121009101953.GB28120@elie.Belkin>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207438>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Michael J Gruber wrote:
> > Jonathan Nieder venit, vidit, dixit 09.10.2012 10:41:
> 
> >> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> >
> > Tested with Subversion 1.6.18.

Thanks both.  Also pushed to "master" on git://bogomips.org/git-svn.git
(commit 44bc5ac71fd99f195bf1a3bea63c11139d2d535f)

Jonathan Nieder (2):
      git svn: work around SVN 1.7 mishandling of svn:special changes
      svn test: escape peg revision separator using empty peg rev
