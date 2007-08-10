From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Documentation/git-svn: Instructions for cloning a git-svn-created
 repository
Date: Fri, 10 Aug 2007 08:13:47 +0800
Message-ID: <46BBADBB.6070502@midwinter.com>
References: <1186388203181-git-send-email-aroben@apple.com> <20070809193759.GA4545@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 02:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJI8c-0005UG-3C
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 02:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946AbXHJANy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 20:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbXHJANy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 20:13:54 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:42627 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754946AbXHJANx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 20:13:53 -0400
Received: (qmail 22794 invoked from network); 10 Aug 2007 00:13:52 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=ve4lblEkUCOCVsyItCAJ9Cf5oswkFnnJeLPFAl2koj33M77k2VZqSAt5m8LmdnE0  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 10 Aug 2007 00:13:52 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20070809193759.GA4545@untitled>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55489>

Eric Wong wrote:
> I personally believe using rsync to clone repositories created with
> git-svn is the simplest and best method for now.

But then you don't get to use alternates -- one of the things I like 
about the idea of doing a "git clone" of a git-svn repository is that 
you could do "git clone -s" and get the full svn history with a tiny 
.git directory.

-Steve
