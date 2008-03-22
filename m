From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Path filtered history not maximally simplified
Date: Sat, 22 Mar 2008 12:52:25 -0700
Message-ID: <7vve3eh6yu.fsf@gitster.siamese.dyndns.org>
References: <47E3AE38.5060405@viscovery.net> <47E3BCD5.2070405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Mar 22 20:53:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd9mD-0005kJ-Rk
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 20:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbYCVTwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 15:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbYCVTwd
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 15:52:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbYCVTwc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 15:52:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B9DE215AA;
	Sat, 22 Mar 2008 15:52:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 27A0E15A9; Sat, 22 Mar 2008 15:52:28 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77846>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Ok, it turns out that M is an evil merge, i.e. the file in M is different
> from both A and 3, but in such a way that it does not show up in a diff
> --cc that has only 3 lines of context. In particular, one of the commits
> 1, 2, 3 added a single line at an isolated spot in the file, and I undid
> that addition in the merge commit M.
>
> Sorry for the noise.
>
> -- Hannes
>
> (So, *that's* why they are called "evil"!)

Just a nomenclature, but independent changes merged trivially cleanly are
"normal" merges, not evil.

Evil merges are the ones that actually change the result in such a way
that new lines in --cc output do not have _any_ counterpart in any of the
parents.
