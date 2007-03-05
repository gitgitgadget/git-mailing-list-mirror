From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 18:22:24 +0100
Message-ID: <45EC51D0.7000406@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org> <Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45EC35B2.2070808@lu.unisi.ch> <Pine.LNX.4.63.0703051701331.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 18:22:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOGtL-0007j2-Ab
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 18:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbXCERW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 12:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbXCERW0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 12:22:26 -0500
Received: from server.usilu.net ([195.176.178.200]:38163 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752812AbXCERWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 12:22:25 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Mar 2007 18:22:24 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.63.0703051701331.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 05 Mar 2007 17:22:24.0073 (UTC) FILETIME=[D6E26B90:01C75F4A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41464>

>>>> +	/* Try an exact match first.  */
>>>> +	sscanf(value, "refs/%*[^:]:%n", &len_first);
>>> This is the first time I saw that sscanf format type. How portable is it?
>> It is.  At the very least it is in OpenGroup.
> 
> That is not very reassuring for me. However, I learnt something new about 
> sscanf(), so it was not lost on me.

Google books reveals that it's called a "scanset" (I didn't know that either).  I found it in "C: The Complete Reference" by Herb Schildt (2000) and "POSIX Programmer's Guide" by D.A. Lewine (1991).  I don't have K&R at hand to check.

Paolo
