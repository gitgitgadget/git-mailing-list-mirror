From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Windows support
Date: Wed, 25 Jul 2007 19:12:21 +0800
Message-ID: <46A73015.7020306@midwinter.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 13:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDen7-0007Oj-7G
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 13:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756314AbXGYLM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 07:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757748AbXGYLM0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 07:12:26 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:50374
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1754969AbXGYLMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 07:12:25 -0400
Received: (qmail 15365 invoked from network); 25 Jul 2007 11:12:25 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Vfe37ItY8iIu6/onRNoA/f2plYvSgkMwkBiwWQacXAsysuODU60jJtn1INc0Svw1  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 25 Jul 2007 11:12:25 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53683>

Dmitry Kakurin wrote:
> How serious are you guys about Windows support?

Well, it's really a matter of someone stepping up and doing the work. 
Much (nearly all?) of the core git team never touches Windows, so they 
both have no selfish motivation to get it working well and no way to 
test their changes even if they decide to take it up for the greater good.

As has been pointed out, there are a lot of people coming to the list 
and asking for Windows support, but precious few actually contributing 
any code. If everyone who asked for Windows support had been willing to 
fix one Windows-related issue, git's Windows support would be stellar by 
now. I'm as guilty as anyone of asking for stuff without doing it 
myself, so I say this as an observation, not an accusation!

> I'm talking fully-functional port, not Cygwin.

There is a port that uses MinGW instead of Cygwin, FYI. It is still 
perhaps not as native-Windows-like as one might prefer, but it should be 
less alien than Cygwin, anyway.

-Steve
