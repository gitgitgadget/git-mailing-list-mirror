From: Torsten Paul <Torsten.Paul@gmx.de>
Subject: Re: gitk: Author/Committer name with special characters
Date: Thu, 17 Jul 2008 09:34:49 +0200
Message-ID: <487EF619.3000805@gmx.de>
References: <487E7525.7000708@gmx.de> <18558.35423.933860.915622@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 09:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJO29-0008UW-VL
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 09:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760499AbYGQHfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 03:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756428AbYGQHfF
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 03:35:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:47431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760499AbYGQHfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 03:35:01 -0400
Received: (qmail invoked by alias); 17 Jul 2008 07:34:58 -0000
Received: from unknown (EHLO [10.161.241.10]) [92.117.241.10]
  by mail.gmx.net (mp035) with SMTP; 17 Jul 2008 09:34:58 +0200
X-Authenticated: #1774914
X-Provags-ID: V01U2FsdGVkX18jDJZV6SUjVDNLmzv5yr6uC12QR22IYZ3vMnC45g
	SSEKgNYyYAuHfD
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
In-Reply-To: <18558.35423.933860.915622@cargo.ozlabs.ibm.com>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88812>

Paul Mackerras wrote:
 > Something like that, I think, but to be sure I'd like to see the
 > actual author and committer lines that are causing the problem.  Could
 > you send me the output of "git cat-file commit" on one of the
 > problematic commits?
 >
The header of the commits look like this:

tree 2eaf317290917660c03dc977d5eae180b39420e0
parent e99bf1c38540300c501dbe776de28eed6a2250cd
author DOM\paul <DOM\paul@28e39a90-19ad-e645-8baa-5c9ab2323746> 1216216768 +0000
committer DOM\paul <DOM\paul@28e39a90-19ad-e645-8baa-5c9ab2323746> 1216216768 +0000

With my name it's just not displaying the backslash, but with names
starting with a 't' or even better 'n' it get's more interresting
as they are shown as tab or newline. And that looks very funny in
the commit list view.

ciao,
   Torsten.
