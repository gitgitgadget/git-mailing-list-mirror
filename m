From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: git blame for a commit
Date: Mon, 23 Jun 2008 11:55:59 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806231149470.27742@sys-0.hiltweb.site>
References: <485ED2E5.3070906@mircea.bardac.net> <alpine.LFD.1.10.0806222300410.23258@sys-0.hiltweb.site> <485F6710.1080300@mircea.bardac.net> <m3ve00lbby.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mircea Bardac <dev@bardac.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 17:57:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAoPh-0000u0-84
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbYFWP4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbYFWP4H
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:56:07 -0400
Received: from mail.gmx.com ([74.208.5.67]:45888 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753461AbYFWP4G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:56:06 -0400
Received: (qmail invoked by alias); 23 Jun 2008 15:56:03 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us001) with SMTP; 23 Jun 2008 11:56:03 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX18T5IhkzjYTHE3T50+JLWebqhVi7aNbuEYGhNACA6
	26WvM5w+rtOWxQ
In-Reply-To: <m3ve00lbby.fsf@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85877>

On Mon, 23 Jun 2008 at 3:01am -0700, Jakub Narebski wrote:

> I think you could script it using "git diff", and "git blame -L m,n",
> where line ranges would be calculated from git diff header for
> post-image, or both pre-image and post-image (in the case of deletions).

Maybe I'm missing something, but I thought git-blame only worked with
the files in the Git working directory.  Therefore, if a file had been
deleted it would not be reachable with git-blame, whether you diff'ed
the pre- and post-image or not.


--
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3
