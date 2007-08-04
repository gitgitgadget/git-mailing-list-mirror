From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 04 Aug 2007 11:49:54 +0800
Message-ID: <46B3F762.1050306@midwinter.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net>	<200708040341.36147.ismail@pardus.org.tr> <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?SXNtYWlsIETDtm5tZXo=?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 05:50:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHAf6-0007qN-Pb
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 05:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764187AbXHDDuZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 23:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764206AbXHDDuY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 23:50:24 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:50569 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1764187AbXHDDuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 23:50:22 -0400
Received: (qmail 13847 invoked from network); 4 Aug 2007 03:50:21 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=JV7COLJIA97fFYIP2TqiZrDvw7wFau8VNNQ2XOg+SHx2i8AbYtz1uqfUreueGya6  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 4 Aug 2007 03:50:21 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54787>

Junio C Hamano wrote:
> The asciidoc toolchain used by us (either AsciiDoc 7 nor 8) does
> not seem to work well with docbook-xsl 1.72 and 1.73, it seems.
>   

How attached are we to asciidoc? Every time I do a clean build and sit 
there twiddling my thumbs waiting for xmlto to do its thing, I think to 
myself, "If this were a dedicated Perl script to do the syntax 
transformations directly to man and html formats, it would blast through 
all the .txt files in a second or two total." It seems outlandish to me 
that it takes longer to build the (relatively small) documentation than 
it does to build the actual code. Plus we constantly run into this sort 
of problem.

Do we want to keep using asciidoc (e.g., so people can easily export to 
other asciidoc-supported formats), or is a dedicated renderer something 
we'd consider switching to? I have a flight from China back to the US 
coming in a couple weeks; this could be a perfect little project to keep 
me occupied between in-flight movies. It doesn't look like the syntax 
transformations are very hard, and it'd be easy enough to verify 
correctness by just comparing against the existing asciidoc output.

Am I correct in observing that "*roff -man" and HTML are the only two 
output formats we care about, or do people use other formats in their 
private branches?

-Steve
