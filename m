From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] In Examples, explain option -r and refer to git-rev-list[1]
Date: Mon, 27 Aug 2007 02:55:07 -0700
Message-ID: <7vy7fxjo90.fsf@gitster.siamese.dyndns.org>
References: <r6lqfgnp.fsf@cante.net> <46D28502.3030003@etek.chalmers.se>
	<7vy7fxl7hx.fsf@gitster.siamese.dyndns.org>
	<7vbqctl6ky.fsf@gitster.siamese.dyndns.org>
	<20070827084423.GA19230@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>,
	Git Mailing List <git@vger.kernel.org>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <lukass@etek.chalmers.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 11:55:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPbJV-0004xp-He
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 11:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbXH0JzO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 05:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbXH0JzO
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 05:55:14 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36996 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195AbXH0JzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 05:55:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 00FA812936A;
	Mon, 27 Aug 2007 05:55:30 -0400 (EDT)
In-Reply-To: <20070827084423.GA19230@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 27 Aug 2007 04:44:23 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56799>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 27, 2007 at 01:33:49AM -0700, Junio C Hamano wrote:
>
>> --- a/builtin-log.c
>> +++ b/builtin-log.c
>> @@ -258,6 +258,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
>>  	git_config(git_log_config);
>>  	init_revisions(&rev, prefix);
>>  	rev.always_show_header = 1;
>> +	rev.diffopt.recursive = 1;
>>  	cmd_log_init(argc, argv, prefix, &rev);
>>  	return cmd_log_walk(&rev);
>>  }
>
> This should perhaps rather go in cmd_log_init (and be removed from
> cmd_show and cmd_whatchanged). I think this is semantically a little
> more clear, and the change will affect other log porcelains (right now
> just "git-reflog --name-status", but also new ones if they are added).
>
> But yes, this is post-1.5.3, so I will shut up rather than nitpicking
> your "not meant to be applied now" patches.

Thanks for your comments; rather than shutting up, could you
send an improvement after 1.5.3 happens?
