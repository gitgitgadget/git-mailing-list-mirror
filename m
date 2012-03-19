From: Philipp Abraham <abrahamp@informatik.uni-luebeck.de>
Subject: GSOC Application [gitweb]
Date: Mon, 19 Mar 2012 23:09:49 +0100
Message-ID: <4F67AEAD.4070401@informatik.uni-luebeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 23:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9kxI-0004Db-NJ
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 23:21:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584Ab2CSWV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 18:21:28 -0400
Received: from ip1.rz.uni-luebeck.de ([141.83.100.71]:44910 "EHLO
	ip1.rz.uni-luebeck.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757273Ab2CSWV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 18:21:27 -0400
X-Greylist: delayed 683 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Mar 2012 18:21:26 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsMGAFauZ0+NU49J/2dsb2JhbABBgw20UYJIQD0WGAMCAQIBWAgBAReHcweWVaAqBI1DgyIEm1WIE4Iogmc
Received: from cs3.informatik.uni-luebeck.de (HELO mail.informatik.uni-luebeck.de) ([141.83.143.73])
  by ip1.rz.uni-luebeck.de with ESMTP; 19 Mar 2012 23:09:50 +0100
Received: from [192.168.2.22] (g224097146.adsl.alicedsl.de [92.224.97.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.informatik.uni-luebeck.de (Postfix) with ESMTPSA id 6106A5A0A6
	for <git@vger.kernel.org>; Mon, 19 Mar 2012 23:09:50 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193467>

Hello together,

I just received my Bachelors degree and am now starting the Masters 
courses at the University of Luebeck in Germany.
I have been playing around with web development for a while now and 
would like to be a Google Summer of Code participant for the git 
project.  Although I used git for quite a time now (maybe 2 years), 
managing an open source project on github recently introduced me to even 
more of it's power.

For my application, I would like to focus on gitweb.
Looking at this year's proposals [1] the point "Use JavaScript library / 
framework in gitweb" caught my interest.
I scanned through the current javascript code used by gitweb and noticed 
that there's not too much going on currently.

There are only 2 components where JS is used: Adjusting the time zone 
and incrementally looking up the data for blame.
Since including a JS library (like prototype.js or jQuery) and 
refactoring the (small) existing code base to use the lib's methods 
doesn't look enough for GSoC, I wanted to ask what would be the best 
idea for a project proposal.
Are there any additional features that you would like to see in gitweb?

I thought about creating a graphical representation of the tree (as 
proposed on last years idea list [2]) additionally or in exchange for 
the first idea.
Though I couldn't think of the perfect solution (from a technology 
point) yet.
Possible technologies would be using SVG, html5 canvas element or 
dynamically manipulated DOM elements (best browser support but harder to 
realize). Using special characters like 'git log --graph' does, seems to 
look a bit too retro in a web application.

What would you advice to maximize the chances of getting accepted to 
work on gitweb?

--
Philipp

[1] https://github.com/peff/git/wiki/SoC-2012-Ideas
[2] https://git.wiki.kernel.org/articles/s/o/c/SoC2011Ideas_49fd.html
