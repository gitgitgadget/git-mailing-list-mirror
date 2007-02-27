From: Junio C Hamano <junkio@cox.net>
Subject: Re: Worrisome bug trend
Date: Tue, 27 Feb 2007 12:42:30 -0800
Message-ID: <7vodnfcoy1.fsf@assigned-by-dhcp.cox.net>
References: <7vodnfg4sy.fsf@assigned-by-dhcp.cox.net>
	<45E493D3.7060407@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM9A8-0000J2-1c
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933092AbXB0Umc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933099AbXB0Umc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:42:32 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59658 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933092AbXB0Umb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:42:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070227204146.BPDE1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Feb 2007 15:41:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UkiW1W00e1kojtg0000000; Tue, 27 Feb 2007 15:42:31 -0500
In-Reply-To: <45E493D3.7060407@vilain.net> (Sam Vilain's message of "Wed, 28
	Feb 2007 09:25:55 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40793>

Sam Vilain <sam@vilain.net> writes:

> Junio C Hamano wrote:
>> I take that as a sign that git hasn't been exercised well and
>> yet more ancient bugs are sleeping, waiting to be triggered, not
>> as a sign that we are very careful and adding only small number
>> of risky new code in the releases.
>>   
>
> No! It's a sign that there aren't enough tests :)
>
> Maybe investigate the coverage of the test suite?

I know we cover most of the success (expected) cases for things
we care about, but at the same time I personally find that tests
for failure cases (insane input, dataset expected to fail) are
missing.

We do not need investigation.  We need a volunteer.

And perhaps a new patch/feature acceptance criteria that
requires both expected behaviour and expected failure tests, but
I am lazy ;-).
