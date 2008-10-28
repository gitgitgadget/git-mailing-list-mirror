From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach/Fix pull/fetch -q/-v options
Date: Mon, 27 Oct 2008 20:21:35 -0700
Message-ID: <7vprllh0ao.fsf@gitster.siamese.dyndns.org>
References: <1224606624-5082-1-git-send-email-tuncer.ayaz@gmail.com>
 <20081027190816.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 04:23:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KufAg-0003qR-Bo
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 04:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbYJ1DVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 23:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYJ1DVw
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 23:21:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbYJ1DVw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 23:21:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 07CCE75EEC;
	Mon, 27 Oct 2008 23:21:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 26DFF75EE8; Mon, 27 Oct 2008 23:21:42 -0400 (EDT)
In-Reply-To: <20081027190816.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon, 27 Oct 2008 19:08:16 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8FCB106C-A49F-11DD-9B71-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99271>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Tuncer Ayaz <tuncer.ayaz@gmail.com>:
>
>> After fixing clone -q I noticed that pull -q does not do what
>> it's supposed to do and implemented --quiet/--verbose by
>> adding it to builtin-merge and fixing two places in builtin-fetch.
>
> Junio, may I ask what the status of this patch is? Maybe the patch was lost in the noise? The commit log message is written very differently from existing commits in the history of git, and I am thinking that maybe that is why you did not like the whole patch? Or is it lack of any test script?

Well, perhaps you've been with us long enough to get too picky like
myself, but this was genuinely lost in the noise and my scrambling to get
back to normal.  We do not typically say "I did this, I did that", but the
first paragraph in Tuncer's message is perfectly fine.  I would probably
liked the second paragraph better if it were after --- lines (it is more
about the possible enhancements in other areas, and does not belong to the
commit log message for this change), but it is not a grave enough offence
to get the patch rejected.

The patch itself looks Ok; the lack of test script additions does indeed
bother me somewhat, but it is not too big a deal.

P.S. We are having fun at GitTogether'08 in the first half of this week,
so please expect slower response than usual.
