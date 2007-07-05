From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Fwd: git-svn dcommit fail
Date: Thu, 05 Jul 2007 09:18:54 -0700
Message-ID: <468D19EE.6@midwinter.com>
References: <4b3406f0707040256x31f0909cie126d950c60374f1@mail.gmail.com>	 <468C999C.60701@midwinter.com>	 <fa0b6e200707050126m17a23de6uad4909533306eb06@mail.gmail.com>	 <fa0b6e200707050128h6bc3caa4rd661c64128ac7367@mail.gmail.com>	 <7v1wfndyow.fsf@assigned-by-dhcp.cox.net> <fa0b6e200707050406i831816co80ff1500dae6bf54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kees-Jan Dijkzeul <k.j.dijkzeul@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 18:19:05 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6U2m-0004gF-KZ
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 18:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171AbXGEQS6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757546AbXGEQS5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 12:18:57 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:56706
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1755098AbXGEQS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 12:18:57 -0400
Received: (qmail 12508 invoked from network); 5 Jul 2007 16:18:56 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=N9xUuJDYKG5QyVis1oBCoC/lMeqtCdELnO2DTrSxsfBRNkB9P/Gyqj1DmT8PUys/  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 5 Jul 2007 16:18:56 -0000
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <fa0b6e200707050406i831816co80ff1500dae6bf54@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51681>

Kees-Jan Dijkzeul wrote:
> Basically, the problem is as follows: My head commit is a merge:
> $ git show HEAD
> commit e135f26dbae66f539b486646a12aa51e71c196a1
> Merge: bb8ac98... f453e1e...
>
> Both parents are svn-commits.

That seems to be a case that the current merge support in git-svn can't 
handle. I'll refer you to the test I did when the merge support first 
landed on the mailing list:

http://www.spinics.net/lists/git/msg33628.html

The current code seems to be aimed at using branches for local 
development on the git side rather than dealing with relationships 
between multiple svn branches.

I'll also point out this utility, which may be of use to you. It is not 
perfect but it works.

http://www.spinics.net/lists/git/msg29119.html

-Steve
