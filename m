From: Wincent Colaiuta <win@wincent.com>
Subject: Re: A tour of git: the basics (and notes on some unfriendly messages)
Date: Sun, 30 Sep 2007 16:31:50 +0200
Message-ID: <9FDE609B-ABC1-45D7-AFF9-211381CAF830@wincent.com>
References: <87ir5us82a.wl%cworth@cworth.org> <20070929000056.GZ3099@spearce.org> <20070929090121.GA4216@artemis.corp> <912CB4AE-83B9-42D7-A591-E721D1E22439@wincent.com> <20070930134937.GG22560@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 16:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibzqd-00067X-7y
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 16:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398AbXI3OcL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2007 10:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756417AbXI3OcK
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 10:32:10 -0400
Received: from wincent.com ([72.3.236.74]:37544 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755693AbXI3OcJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Sep 2007 10:32:09 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8UEW3ai030898;
	Sun, 30 Sep 2007 09:32:05 -0500
In-Reply-To: <20070930134937.GG22560@artemis.corp>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59544>

El 30/9/2007, a las 15:49, Pierre Habouzit escribi=F3:

> On Sun, Sep 30, 2007 at 12:45:34PM +0000, Wincent Colaiuta wrote:
>>
>> I think that most people just want to know, "Did it work or not?" =20
>> and so
>> when the commands chatter too much they go into filter mode, don't =20
>> really
>> read the output, let alone try to understand it, and just skim it.
>> Ideally Git would be much less "chattery" in general when things =20
>> work,
>> and only be more verbose when things go wrong; of course, finding =20
>> that
>> balance point is where the art lies.
>
>   That's true for git merge that is fast. But people also want to kno=
w
> the command is not stuck in an infinite loop, and for that progress =20
> bars
> or little \|/- animation.

Yes, I agree. I probably should have said that they either want to =20
know "*Did* it work?" for near-instant operations (most Git =20
operations, hopefully), and "*Is* it working?" for long-running ones =20
(network ops, for example) and in those cases you're right that a =20
progress bar would be a nice enhancement.

Cheers,
Wincent
