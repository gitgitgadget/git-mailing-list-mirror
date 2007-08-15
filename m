From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merge-recursive: do not rudely die on binary merge
Date: Wed, 15 Aug 2007 04:50:46 -0700
Message-ID: <7vbqd9rp7t.fsf@gitster.siamese.dyndns.org>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	<20070814231422.GA10662@pe.Belkin>
	<7vps1paceh.fsf@assigned-by-dhcp.cox.net>
	<6bcc356f0708150419h51546814x62ceb7c900293d58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Chris Shoemaker" <c.shoemaker@cox.net>, git@vger.kernel.org,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Nikodemus Siivola" <nikodemus@random-state.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 14:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILHeq-0000L0-0b
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 14:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062AbXHOMHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 08:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbXHOMHW
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 08:07:22 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbXHOMHU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 08:07:20 -0400
X-Greylist: delayed 985 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2007 08:07:20 EDT
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D09512035A;
	Wed, 15 Aug 2007 07:51:10 -0400 (EDT)
In-Reply-To: <6bcc356f0708150419h51546814x62ceb7c900293d58@mail.gmail.com>
	(Nikodemus Siivola's message of "Wed, 15 Aug 2007 14:19:16 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55894>

"Nikodemus Siivola" <nikodemus@random-state.net> writes:

> On 8/15/07, Junio C Hamano <gitster@pobox.com> wrote:
>
>> People should learn this command.  Really.
>>
>>         $ git cat-file -p :$n:path
>>
>> where $n == 2 is ours, $n == 1 is common ancestor, and $n == 3
>> is theirs.
>
> A question related to this: as a user, how can I tell if a command
> is something I'm expected to use, or if thinking I need it is a
> sign that I'm doing something wrong?

Good question.

I guess "git show" instead of "git cat-file -p" is probably the
recommended way these days.  Mostly sticking to what the user
manual demonstrates would be a safe thing to do, as J. Bruce
Fields has really did a great job carefully picking the order of
the commands to be presented in the manual.
