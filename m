From: Miles Bader <miles.bader@necel.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 03 Oct 2007 14:10:09 +0900
Message-ID: <buoprzwn5qm.fsf@dhapc248.dev.necel.com>
References: <20070927130447.GH10289@artemis.corp>
	<7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:10:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcwVU-0008BQ-Ui
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbXJCFKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbXJCFKi
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:10:38 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:36875 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbXJCFKh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:10:37 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l9359Jd3016125;
	Wed, 3 Oct 2007 14:10:10 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Wed, 3 Oct 2007 14:10:10 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay21.aps.necel.com with ESMTP; Wed, 3 Oct 2007 14:10:09 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id B59A3458; Wed,  3 Oct 2007 14:10:09 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 27 Sep 2007 12\:22\:24 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59785>

Junio C Hamano <gitster@pobox.com> writes:
> I think it is sensible to have an option to make it push only the
> current branch.  I am not sure if it is sensible to make that the
> default.

I really like the current default, it matches my mental model well:  I
generally use "push" to mean "synchronize the remote repository with my
current one"; if multiple branches have changed, I want those changes
propagated too.

I think changing it would be a bad idea, it just seems a pointlessly
incompatible change.  The reasons I've seen offered on this thread for
changing the default seem pretty weak, e.g., "it's more conservative"
(but more annoying), and "it's more like SVK" (who cares?).

-Miles
-- 
Freedom's just another word, for nothing left to lose   --Janis Joplin
