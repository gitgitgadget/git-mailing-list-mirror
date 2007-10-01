From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems setting up bare repository (git 1.5.3.3)
Date: Mon, 01 Oct 2007 16:24:09 -0700
Message-ID: <7v641qquzq.fsf@gitster.siamese.dyndns.org>
References: <m3fy0u7bk3.fsf@barry_fishman.acm.org>
	<7vejgeqxd1.fsf@gitster.siamese.dyndns.org>
	<87bqbisae6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Barry Fishman <barry_fishman@acm.org>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 01:24:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcUcj-0000Rt-NG
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 01:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748AbXJAXYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 19:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbXJAXYR
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 19:24:17 -0400
Received: from rune.pobox.com ([208.210.124.79]:32773 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbXJAXYR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 19:24:17 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 2CD6313FBC2;
	Mon,  1 Oct 2007 19:24:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D7DF13FA81;
	Mon,  1 Oct 2007 19:24:33 -0400 (EDT)
In-Reply-To: <87bqbisae6.wl%cworth@cworth.org> (Carl Worth's message of "Mon,
	01 Oct 2007 16:06:09 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59648>

Carl Worth <cworth@cworth.org> writes:

> On Mon, 01 Oct 2007 15:32:58 -0700, Junio C Hamano wrote:
>> "master:master") does not exist there, and we do not create it
>> unless you give a full refname that begins with refs/ (so that
>> push can tell if you want to create a tag or a branch).
>
> And why is that?

I think Daniel's rewrite of remote ref matching code that has
been cooking in 'next' changes the match semantics of the remote
side in subtle way to make it easier to favor branches when
pushing branches, but I juggle many topics and I have to go back
to the code to make sure.  Since you are interested, and more
importantly since I know you are capable to do the digging
yourself, I won't be doing the digging myself immediately,
though.
