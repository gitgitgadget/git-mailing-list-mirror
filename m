From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Refactoring the tag object; Introducing soft references (softrefs);
 Git 'notes' (take 2)
Date: Sun, 10 Jun 2007 12:42:48 -0700
Message-ID: <466C5438.3020600@midwinter.com>
References: <200706040251.05286.johan@herland.net> <200706100116.46062.johan@herland.net> <20070610082935.GD2951@artemis> <200706101631.27600.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 21:42:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxTJP-0005Jg-8x
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 21:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756587AbXFJTmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 15:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbXFJTmx
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 15:42:53 -0400
Received: from tater.midwinter.com ([216.32.86.90]:41174 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754785AbXFJTmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 15:42:52 -0400
Received: (qmail 8867 invoked from network); 10 Jun 2007 19:42:52 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=c0KpU9W19miDPHFLPp+78804nqCJYlyQvP1OOiItNOwO9isOYeXbJVr0PlVFJMEG  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 10 Jun 2007 19:42:52 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <200706101631.27600.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49760>

Johan Herland wrote:
> Interesting. But I'm not sure I want to give up the fixed-length softref
> records as I imagine it makes the lookup and processing _much_ faster.
>   

The token (really a namespace identifier) could be defined as a string 
with a fixed, probably small, maximum size. Or, better IMO, it could be 
an integer with a bunch of enumerated values for internal git uses and a 
range reserved for unofficial / experimental use. I agree that 
fixed-length records seem like a win here, assuming this is the general 
storage layout we end up with when all is said and done.

-Steve
