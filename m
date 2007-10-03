From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push (mis ?)behavior
Date: Tue, 02 Oct 2007 22:39:13 -0700
Message-ID: <7v7im4hi4e.fsf@gitster.siamese.dyndns.org>
References: <20070927130447.GH10289@artemis.corp>
	<7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
	<buoprzwn5qm.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:39:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcwxG-0005Rj-Sm
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbXJCFjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbXJCFjW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:39:22 -0400
Received: from rune.pobox.com ([208.210.124.79]:36780 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514AbXJCFjV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:39:21 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 114E1140AAE;
	Wed,  3 Oct 2007 01:39:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5C1C913EE84;
	Wed,  3 Oct 2007 01:39:39 -0400 (EDT)
In-Reply-To: <buoprzwn5qm.fsf@dhapc248.dev.necel.com> (Miles Bader's message
	of "Wed, 03 Oct 2007 14:10:09 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59789>

Miles Bader <miles.bader@necel.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> I think it is sensible to have an option to make it push only the
>> current branch.  I am not sure if it is sensible to make that the
>> default.
>
> I really like the current default, it matches my mental model well:  I
> generally use "push" to mean "synchronize the remote repository with my
> current one"; if multiple branches have changed, I want those changes
> propagated too.
>
> I think changing it would be a bad idea, it just seems a pointlessly
> incompatible change.  The reasons I've seen offered on this thread for
> changing the default seem pretty weak, e.g., "it's more conservative"
> (but more annoying), and "it's more like SVK" (who cares?).

Usually we hear people complain louder on the list.

People who are happy with the existing behaviour tend to be
quiet, and we should be really careful not to break things for
silent majority.

I try to stay fairly conservative, often more conservative than
what I would like to be myself, for this exact reason.
