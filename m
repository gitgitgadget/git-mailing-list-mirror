From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Q] Abbreviated history graph?
Date: Tue, 04 Nov 2008 00:45:12 -0800
Message-ID: <7vzlkfriav.fsf@gitster.siamese.dyndns.org>
References: <200811031439.12111.brian.foster@innova-card.com>
 <alpine.LFD.2.00.0811031129060.3419@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811031211180.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Foster <brian.foster@innova-card.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:46:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHYg-0001Th-Ab
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbYKDIp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbYKDIp2
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:45:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbYKDIp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:45:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E05CA7895A;
	Tue,  4 Nov 2008 03:45:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 020CC78959; Tue,  4 Nov 2008 03:45:19 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811031211180.3419@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Mon, 3 Nov 2008 12:15:05 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ED748EC0-AA4C-11DD-B9F8-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100060>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 3 Nov 2008, Linus Torvalds wrote:
>>
>> I'll post a simple series of four commits in a moment.
> ...
> Side note: it's certainly possible that we could improve on this. Right 
> now, "--simplify-namespace" will totally override any path simplification, 
> so you can't get a combination of pathnames _and_ naming commits. I don't 
> know exactly what the rules should be, but I could imagine that we could 
> do something like:
>
>  - if no pathnames are given, work the way the current patch-series works.
>
>  - if path-names are given, make rev_compare_tree() truen 
>    REV_TREE_DIFFERENT if a name decoration _or_ a tree difference exists.
>
> Anyway, that's a fairly trivial extension to the idea, and doesn't really 
> matter for the basic code. It can easily be left for later.

Thanks.

Including this (and the --source one), the series looks reasonable.
