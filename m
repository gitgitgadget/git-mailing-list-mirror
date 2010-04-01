From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCHv5 4/6] instaweb: add minification awareness
Date: Thu, 1 Apr 2010 13:50:06 -0700
Message-ID: <20100401205006.GA13580@dcvr.yhbt.net>
References: <4BB430F1.60002@mailservices.uwaterloo.ca> <201004011310.01068.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 22:50:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxRLC-00016Q-Fv
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 22:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab0DAUuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 16:50:09 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41851 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968Ab0DAUuH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 16:50:07 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DCE1F4E5;
	Thu,  1 Apr 2010 20:50:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <201004011310.01068.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143748>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 1 Apr 2010, Mark Rada wrote:
> 
> > This patch will cause git-instaweb to use the minified version of gitweb
> > support files (e.g. CSS and JavaScript) if they were generated.
> 
> I was not sure if git-instaweb should use minified files or not, and
> that is why I didn't add support for this to git-instaweb generation.
> But I forgot that git-instaweb uses gitweb.cgi... which in turn can
> use minified versions of gitweb support files.

It can make distro installation footprints smaller, which would
be appreciated.

> > Without minification awareness, generating the minified version of
> > gitweb's support files will generate a broken instaweb script since the
> > copy of gitweb.cgi will look for gitweb.min.* which will not exist.
> 
> Good catch!
> > 
> > Signed-off-by: Mark Rada <marada@uwaterloo.ca>

Thanks Jakub and Mark,

Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
