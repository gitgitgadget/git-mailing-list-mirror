From: sf <sf@b-i-t.de>
Subject: Re: [PATCH] Teach --text option to diff
Date: Fri, 07 Jul 2006 13:53:25 +0200
Message-ID: <44AE4B35.6060607@b-i-t.de>
References: <11522684373987-git-send-email-sf@b-i-t.de> <7v64i91xow.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 07 13:54:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyouq-0004PB-A9
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWGGLyN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWGGLyN
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:54:13 -0400
Received: from main.gmane.org ([80.91.229.2]:39312 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932135AbWGGLyL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jul 2006 07:54:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FyouF-0004J9-Lu
	for git@vger.kernel.org; Fri, 07 Jul 2006 13:54:00 +0200
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 13:53:59 +0200
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 07 Jul 2006 13:53:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.4 (X11/20060606)
In-Reply-To: <7v64i91xow.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23434>

Junio C Hamano wrote:
> Stephan Feder <sf@b-i-t.de> writes:
> 
>> I have to send patches of binary data to a customer but the builtin diff
>> was no help in this case.
> 
> Given the previous patch, and also your point #2 below, I would
> have expected you to introduce an option to force files to be
> treated as binary even when they are otherwise misidentified as
> text, but this patch is going the other way.
> 
> Interesting.

Not really. I was surprised that the GNU diff option --text is
unsupported in the builtin diff.

> 
>> 1. The shorthand -a for --text is not implemented. Is there a conflicting
>> shorthand?
> 
> I do not think of one offhand, but it's the responsibility for
> the party to propose such an enhancement to do the study ;-)

Of course. I did not find any conflict but as the builtin diff and its
options are used by quite a lot of git commands I wanted to make sure.

If no objections arise I am going to add the shorthand.

>> 2. For diffstat --text is ignored. It seems pointless because binary
>> patch data is not for human consumption anyway.
> 
>> 3. No documentation yet. If the patch is accepted I will add a short
>> description. To Documentation/diff-options.txt?
> 
> Most likely that would be the place.

Good.
