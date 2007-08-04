From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 04 Aug 2007 18:55:26 +0800
Message-ID: <46B45B1E.5020104@midwinter.com>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr> <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net> <46B3F762.1050306@midwinter.com> <7vfy2zj4nj.fsf@assigned-by-dhcp.cox.net> <46B418AA.4070701@midwinter.com> <20070804091249.GA17821@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>,
	git@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 12:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHHIT-0001TL-AI
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 12:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbXHDKza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 06:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbXHDKz3
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 06:55:29 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:35865 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754005AbXHDKz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 06:55:29 -0400
Received: (qmail 9136 invoked from network); 4 Aug 2007 10:55:28 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=vi5dImuQQBteXiz6mgJygQrDD5n67zzgdPxPoEhPNcctLqGfqsFBQb8hkerrlo7s  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 4 Aug 2007 10:55:28 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20070804091249.GA17821@uranus.ravnborg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54821>

Sam Ravnborg wrote:
> Never looked at Ascii-doc... but how about finding the loopholes
> in Ascii-doc to make it 10x faster?
> That would benefit a larger user-base than just doing-it-ourself.
>   

Because AsciiDoc is only half of the toolchain we use. (Though in your 
defense, I made the mistake of only mentioning AsciiDoc by name, rather 
than "the AsciiDoc toolchain.") We run asciidoc's output through xmlto, 
which is just as slow and is a highly general piece of software for 
doing arbitrary transformations of XML documents. I won't say it's 
impossible to speed up xmlto as well, of course, but it's probably an 
order of magnitude more work than implementing a new parser/renderer for 
our .txt files.

-Steve
