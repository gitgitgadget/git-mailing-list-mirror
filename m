From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Sat, 25 Sep 2010 18:14:46 +0100
Message-ID: <4C9E2E06.1010909@ramsay1.demon.co.uk>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com> <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 19:16:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzYM3-0003kJ-E8
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 19:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535Ab0IYRPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 13:15:55 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:37082 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753597Ab0IYRPy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 13:15:54 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1OzYLn-0005tH-mD; Sat, 25 Sep 2010 17:15:53 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157169>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 

>>
>>> Introduce a new configuration variable, "core.eol", that allows the user
>>> to set which line endings to use for end-of-line-normalized files in the
>>> working directory.  It defaults to "native", which means CRLF on Windows
>>> and LF everywhere else.
>> The following fixup has been sitting in my tree (but not tested on
>> Windows) for a couple of weeks.  Sensible?
>>
>> I don't know what the right choice for Cygwin is; probably LF unless
>> there is some way to detect the systemwide setting at run time.
> 
> Has anybody in Windows land any input?  I don't think what I do before
> 1.7.3 in my tree would matter much, so I am not applying this myself.

Sorry for the late reply to this; I've only just noticed that I hadn't
replied! ;-)

FWIW, I suspect that anything other than LF as the eol on Cygwin would
be *insane*. ;-D

ATB,
Ramsay Jones
