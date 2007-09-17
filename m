From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [PATCH 3/3] git-apply: add tests for stripping of leading and trailing whitespace
Date: Tue, 18 Sep 2007 01:44:46 +0200
Message-ID: <m31wcwsvpt.fsf@maximus.localdomain>
References: <11899829424040-git-send-email-bfields@citi.umich.edu>
	<11899829424173-git-send-email-bfields@citi.umich.edu>
	<1189982942187-git-send-email-bfields@citi.umich.edu>
	<11899829421064-git-send-email-bfields@citi.umich.edu>
	<m3myvlv0m0.fsf@maximus.localdomain>
	<20070917150213.GB4957@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQGu-0005d8-U7
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbXIQXou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 19:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbXIQXot
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:44:49 -0400
Received: from khc.piap.pl ([195.187.100.11]:56552 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755607AbXIQXot (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:44:49 -0400
Received: by khc.piap.pl (Postfix, from userid 500)
	id E27147D835; Tue, 18 Sep 2007 01:44:46 +0200 (CEST)
In-Reply-To: <20070917150213.GB4957@fieldses.org> (J. Bruce Fields's message of "Mon, 17 Sep 2007 11:02:13 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58500>

"J. Bruce Fields" <bfields@fieldses.org> writes:

>> It may be valid, some projects use tabs for indentation and spaces
>> for alignment, e.g.:
>
> Yeah, I know.  I was hoping that the stripspace behavior was already
> specific enough to the linux-kernel style that we could just assume that 
> it was only used by developers on projects with the same style.

Actually I would consider linux kernel an example of such project
with spaces for alignment. Except that current tools are not to
the task. Someday...

Obviously other cases are valid, especially 'spaces before tabs'
which IMHO includes '8 or more non-consecutive initial spaces'.
And all trailing whitespace of course.
-- 
Krzysztof Halasa
