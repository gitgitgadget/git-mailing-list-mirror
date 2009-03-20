From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Minimum libCurl version for git
Date: Fri, 20 Mar 2009 23:15:12 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0903202308400.2600@yvahk2.pbagnpgbe.fr>
References: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git list <git@vger.kernel.org>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lkn1E-0002Ux-Kh
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 23:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbZCTWPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 18:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbZCTWPT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 18:15:19 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:55615 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbZCTWPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 18:15:18 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n2KMFCH4016483;
	Fri, 20 Mar 2009 23:15:12 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <e2b179460903201059j20e37c1cr7ccfa4b42e45c9d9@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114010>

On Fri, 20 Mar 2009, Mike Ralphson wrote:

> According to Daniel's list [1], CURLOPT_SSLKEY was introduced in 7.9.3, but 
> we enable it in http.c if we see version >= 7.9.2. This could be a typo in 
> the haxx.se list, or the option could have been available in (some) 7.9.2 
> releases, or it could be a git bug. Again, not one which appears to be 
> biting anyone.

I double-checked now against the changelog and it confirms that the info is 
correct in that file: CURLOPT_SSLKEY was introduced in 7.9.3. It was first 
released in a pre-release Jan 8th 2002.

I'd assume that very few git-builders have such an old libcurl installed...

-- 

  / daniel.haxx.se
