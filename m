From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Git branching & pulling
Date: Fri, 18 May 2007 23:22:28 -0700
Message-ID: <464E97A4.4050702@midwinter.com>
References: <d4cf37a60705182240s414243a6wae69d26f70f64dd5@mail.gmail.com>	<7v8xblz71o.fsf@assigned-by-dhcp.cox.net> <7vzm41xsa2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wink Saville <wink@saville.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 08:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpIKp-000429-7X
	for gcvg-git@gmane.org; Sat, 19 May 2007 08:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbXESGVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 02:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758105AbXESGVs
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 02:21:48 -0400
Received: from tater.midwinter.com ([216.32.86.90]:48343 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753152AbXESGVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 02:21:47 -0400
Received: (qmail 11511 invoked from network); 19 May 2007 06:21:46 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO pinklady.local) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 19 May 2007 06:21:46 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <7vzm41xsa2.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47724>

Junio C Hamano wrote:
> I personally never understood why people would just want to say
> "git pull" without saying anything else, but what described in
> the DEFAULT BEHAVIOUR section is how it works.
>   

I do that all the time, e.g. when I'm syncing the satellite repo on my 
laptop with the mothership repo in my account on my company's server. 
The satellite only ever talks to the mothership and I am always 
interested in pulling down all the changes I've committed to the 
mothership during the day. So there's really no need to specify 
anything; I always want to keep the two fully in sync, and there's never 
any question about where I'm pulling from.

I do a plain "git pull" in my clone of git.git too. I want all the 
latest updates and I'm only ever fetching them from the official git repo.

I can certainly imagine that if I were an integrator in charge of a 
master repo, I'd always want to explicitly pull from particular places.

-Steve
