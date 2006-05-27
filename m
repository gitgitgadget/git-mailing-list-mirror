From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: t8001-annotate.sh fails on Mac OS X
Date: Sat, 27 May 2006 20:13:47 +0200
Message-ID: <447896DB.4040001@iaglans.de>
References: <f3d7535d0605251653m15db34f3j46403f4ed0c4c69f@mail.gmail.com> <20060526011153.GA27720@spearce.org> <Pine.LNX.4.63.0605261534270.27610@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 27 20:14:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk3J7-0006gv-4S
	for gcvg-git@gmane.org; Sat, 27 May 2006 20:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWE0SOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 14:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWE0SOd
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 14:14:33 -0400
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:55058 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1751060AbWE0SOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 14:14:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 112103FEC;
	Sat, 27 May 2006 20:14:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at vsectoor.geht-ab-wie-schnitzel.de
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ci4GZ83Kqj5I; Sat, 27 May 2006 20:14:03 +0200 (CEST)
Received: from [192.168.100.27] (fry.lan.home.vilz.de [192.168.100.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 8CD163FEB;
	Sat, 27 May 2006 20:13:57 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.2 (Macintosh/20060308)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0605261534270.27610@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20865>

Johannes Schindelin schrieb:
> Hi,
> 
> On Thu, 25 May 2006, Shawn Pearce wrote:
> 
>> Stefan Pfetzing <stefan.pfetzing@gmail.com> wrote:
>>> for some reason I could not yet figure out, t8001-annotate.sh fails at test 
>>> 18.
>> I've been seeing the same failed test case for a long time now on
>> my own Mac OS X system.
> 
> ... which is sort of funny, because I don't see it on my system. Running 
> an iBook G3 with Mac OS X 10.2.8. "make test" runs through, and no, AFAICT 
> I do not have any local modifications which could be responsible for that.

I just tried it on my Powerbook G4 running MacOSX 10.4.6 and failed on 
test 18, too.

I am just doing a complete test with make test...

same situation:

* FAIL 18: some edit
         check_count A 1 B 1 B1 1 B2 1 "A U Thor" 1 C 1 D 1
* failed 1 among 18 test(s)
make[1]: *** [t8001-annotate.sh] Error 1
make: *** [test] Error 2


I am using the master tree for this test.

Any suggestions?
