From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-status: colorize status output
Date: Sat, 05 Aug 2006 04:21:33 -0700
Message-ID: <7vejvve8ci.fsf@assigned-by-dhcp.cox.net>
References: <20060805031418.GA11102@coredump.intra.peff.net>
	<20060805105953.GA5410@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 13:21:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9KDq-0003P9-Ue
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWHELVg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWHELVg
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:21:36 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:1504 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751437AbWHELVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 07:21:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805112134.UXV1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 07:21:34 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060805105953.GA5410@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sat, 5 Aug 2006 12:59:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24907>

Matthias Lederhofer <matled@gmx.net> writes:

> Jeff King <peff@peff.net> wrote:
>> The git-status output can sometimes be very verbose, making it difficult to
>> quickly see whether your files are updated in the index. This adds 4 levels
>> of colorizing to the status output:
>>   - general header (defaults to normal white)
>>   - updated but not committed (defaults to green)
>>   - changed but not updated (defaults to red)
>>   - untracked files (defaults to red)
>> The idea is that red things indicate a potential mistake on the part of the
>> user (e.g., forgetting to update a file, forgetting to git-add a file).
> Perhaps the default values should not use the same color twice? I'd
> suggest yellow for changed but not updated.  But well, it's no problem
> to change this in my config, I just find it a bit confusing to have
> the same color for different things.
>
>> Color support is controlled by status.color and status.color.*. There is no
>> command line option, and the status.color variable is a simple boolean (no
>> checking for tty output).
> Is there any way to do isatty() from shell scripts?

Yes.
