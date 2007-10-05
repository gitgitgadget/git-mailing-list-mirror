From: Bill Lear <rael@zopyra.com>
Subject: Re: Correction for post-receive-email
Date: Fri, 5 Oct 2007 07:35:15 -0500
Message-ID: <18182.12163.311826.242309@lisa.zopyra.com>
References: <449c8cfc0710050014j9bbf057ka108ee27dea49a89@mail.gmail.com>
	<200710050913.58835.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric Mertens" <emertens@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idmka-0006nd-4A
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755434AbXJEM5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 08:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbXJEM5n
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:57:43 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61673 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbXJEM5m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:57:42 -0400
X-Greylist: delayed 1342 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2007 08:57:42 EDT
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l95CZHP01355;
	Fri, 5 Oct 2007 06:35:17 -0600
In-Reply-To: <200710050913.58835.andyparkins@gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60078>

On Friday, October 5, 2007 at 09:13:57 (+0100) Andy Parkins writes:
>On Friday 2007 October 05, Eric Mertens wrote:
>
>> I noticed that my mutt wasn't correctly detecting the signature block
>> on the end of the automated emails I was receiving from the script in
>> contrib. I've made this trivial change in my local copy of the script,
>> but I figured that if I was going to be modifying the source code I
>> should share my changes.
>
>That change has been in my pending queue for a while.  It's technically 
>correct, but I've never submitted it.  The reason I haven't is that it adds 
>trailing whitespace.
>
>Perhaps one of the shell gurus can offer a nicer way of having a trailing 
>space be output in a heredoc that doesn't add a trailing space in the source 
>script?

I have a few changes I would like to see in this script, ones that I think
would make it generally more useful.  I don't have a clean patch, though,
so should I just submit suggestions to you directly, Andy?


Bill
