From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-svn how to catch up with its tracking branches
Date: Thu, 8 May 2008 00:33:12 -0700
Message-ID: <CE2D2A30-CAAF-4903-95EA-B4577932B700@midwinter.com>
References: <20080508013956.GA24956@midwinter.com> <alpine.DEB.1.00.0805072332300.6948@swallowtail>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Thu May 08 09:34:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju0df-0004Rd-Ci
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 09:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756488AbYEHHdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 03:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755862AbYEHHdP
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 03:33:15 -0400
Received: from tater.midwinter.com ([216.32.86.90]:42775 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755818AbYEHHdO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 03:33:14 -0400
Received: (qmail 12501 invoked from network); 8 May 2008 07:33:13 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Q8Fwm99y2uoS6bZdkqFEA7ymOJfAjpIgHxBolPZbrbcVacGR0vkUT9ObCvsIYSxr  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 8 May 2008 07:33:13 -0000
In-Reply-To: <alpine.DEB.1.00.0805072332300.6948@swallowtail>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81510>

On May 7, 2008, at 11:48 PM, Asheesh Laroia wrote:
> The way I handle it is that, hidden somewhere, I have an account  
> with a cron job that does this:
>
> $ git svn fetch
> $ git push origin refs/remotes/*:refs/heads/*
> $ git push origin refs/remotes/trunk:refs/heads/master

That's a reasonable setup, and I think (without having tried it) that  
it will be compatible with my patch -- assuming the clones of your  
origin repository have appropriate svn-remote config entries, they  
should be able to mix and match fetching from your origin and the real  
svn repository, and dcommit stuff back to svn.

Though I'd try that out with a toy svn repo first...

-Steve
