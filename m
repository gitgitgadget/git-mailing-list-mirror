From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 09:48:08 -0400
Message-ID: <4534DF18.8080302@utoronto.ca>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <45345AEF.6070107@utoronto.ca> <BAYC1-PASMTP08A746E5FA6B87BC65BD37AE0E0@CEZ.ICE> <Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 15:48:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZpIl-0002MD-IA
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 15:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbWJQNsM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWJQNsM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 09:48:12 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:61113 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S1750847AbWJQNsL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 09:48:11 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GZpIf-0006zu-00; Tue, 17 Oct 2006 09:48:10 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610171229160.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29071>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Johannes Schindelin wrote:
> On Tue, 17 Oct 2006, Sean wrote:
>>Aaron Bentley <aaron.bentley@utoronto.ca> wrote:

>>>- - you can have working trees on local systems while having the
>>>  repository on a remote system.  This makes it easy to work on one
>>>  logical branch from multiple locations, without getting out of sync.
>>
>>That is a very nice feature.  Git would be improved if it could
>>support that mode of operation as well.
> 
> 
> It would also make things slow as hell. How do you deal with something 
> like annotate in such a setup?

For the particular case of annotate, bzr is designed to store
annotations at commit time.  So annotate should require remote access to
a small amount of data from two files-- not a great cost.

But our default form of checkout contains a local copy of all history
data, so that readonly operations happen at local speed.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFNN8Y0F+nu1YWqI0RAqXtAJ4qKGQ5ZwlMF795kz3udeuRTcRy6wCghr53
tjw9cNVxzrQ0XSUO2v52ZIo=
=W6q7
-----END PGP SIGNATURE-----
