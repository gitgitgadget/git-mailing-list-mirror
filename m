From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Sat, 01 Nov 2008 23:08:06 -0700
Message-ID: <7v1vxu4q49.fsf@gitster.siamese.dyndns.org>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
 <20081030143918.GB14744@mit.edu> <20081030144321.GF24098@artemis.corp>
 <20081030163056.GA8899@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org, Sam Vilain <samv@vilain.net>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Nov 02 07:09:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwW9b-0005VB-17
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 07:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYKBGIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 01:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYKBGIZ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 01:08:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbYKBGIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 01:08:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8497677B23;
	Sun,  2 Nov 2008 01:08:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 27D0777B22; Sun,  2 Nov 2008 01:08:13 -0500 (EST)
In-Reply-To: <20081030163056.GA8899@mit.edu> (Theodore Tso's message of "Thu,
 30 Oct 2008 12:30:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7DC2318-A8A4-11DD-9A70-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99816>

Theodore Tso <tytso@mit.edu> writes:

> On Thu, Oct 30, 2008 at 03:43:21PM +0100, Pierre Habouzit wrote:
>> 
>> git format-patch origin/next.. works already. I'm used to the asymetric
>> git format-patch origin/next syntax, and I would be sorry if it
>> disappeared though, and I see no really good reason to get rid of it.
>
> The reason why it annoys me is because I often what to cherry-pick a
> single patch to send to someone, and so while "git show 332d2e78"
> shows me the patch, but if I want to use git-send-email for that
> particular patch, "git format-patch 332d2e78" doesn't DTRT.  I have to
> type "git format-patch 332d2e78^..332d2e78" instead.
> ...
> (And I get annoyed when I want to run git format-patch on a single
> patch not at the tip of the tree; but if it's just me, I can write a
> "git format-single-patch" wrapper script to get around it.)

Huh?  I am so used to "git format-patch -1 HEAD" (or "332d2e78") that I am
very surprised.
