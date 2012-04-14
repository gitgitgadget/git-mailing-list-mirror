From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: [PATCH] Explain how svn-fe parses filenames in SVN dumps
Date: Sat, 14 Apr 2012 22:56:11 +0100
Message-ID: <4F89F27B.5050706@pileofstuff.org>
References: <4F89ADCD.6000109@pileofstuff.org> <20120414171431.GA4161@burratino> <4F89B5C5.3030606@pileofstuff.org> <20120414181823.GB4560@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 23:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJAxE-0000EQ-Ht
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 23:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab2DNV4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 17:56:16 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:30962 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756232Ab2DNV4P (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 17:56:15 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120414215613.URCE23305.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Sat, 14 Apr 2012 22:56:13 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120414215613.RXOY23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 14 Apr 2012 22:56:13 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120414181823.GB4560@burratino>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=hBuI5vrYS2AA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=s6mO6Rzm0HRxLlmupsoA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195524>

On 14/04/12 19:18, Jonathan Nieder wrote:
> So as far as I can tell the story really is only about newlines.  (If
> svn-fe tried to push history back to Subversion, life would presumably
> be more complicated.)

I think I've been trying to balance two incompatible use cases -
ordinary users that just need a heads-up about a bug that might bite
them, and authors of related tools (i.e. me) that need technical
information about svn-fe.

I think your text serves ordinary users better, so I'll investigate
pushing history back to Subversion tomorrow and think how to write
something more technical.  I'm afraid my patch etiquette fails me here
though - is it better for me to roll your text into a new patch, or let
you do that and submit my text separately?

	- Andrew
