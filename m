From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read
 refs
Date: Wed, 20 Sep 2006 17:12:56 +0100
Message-ID: <45116888.4050806@shadowen.org>
References: <20060920085200.GA21865@shadowen.org> <eer19l$6hm$1@sea.gmane.org>	<4511173D.7020702@shadowen.org> <7vodtak00n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:14:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4hQ-0001r1-V9
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWITQNW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWITQNW
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:13:22 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:6927 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751721AbWITQNV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:13:21 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GQ4gv-0007bu-0D; Wed, 20 Sep 2006 17:12:53 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodtak00n.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27361>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> I guess we could teach for-each-ref to output this as well?  Perhaps
>> something like authorstamp?
> 
> I think you can work with "author" or "committer" to grab the
> whole raw line.
> 
> About the quoting and parsing, language specific quoting mode is
> meant for git-for-each-ref to produce a string that can be eval'ed
> in the host language.  Think of the command as a tool to write a
> short program for you.

Thanks for the education.  Very simple, and very powerful.  I knew there
was a reason for it out there.  Will respin a V3 patch in a bit.

-apw
