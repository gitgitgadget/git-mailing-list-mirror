From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: improve description of GIT_EDITOR and
 preference order
Date: Mon, 26 Mar 2012 11:31:58 -0700
Message-ID: <7v4ntbp61t.fsf@alter.siamese.dyndns.org>
References: <loom.20120323T133648-453@post.gmane.org>
 <7vty1ftc4e.fsf@alter.siamese.dyndns.org>
 <loom.20120326T100258-967@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rodrigo Silva "\(MestreLion\)" <linux@rodrigosilva.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:32:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCEi8-00019r-OL
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 20:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932860Ab2CZScC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 14:32:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43828 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932796Ab2CZScB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 14:32:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D7FC7878;
	Mon, 26 Mar 2012 14:32:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=vsKw0rTmXKg6qnMCy//wdFZCIlw=; b=UXp395sHlHX026lkYrrS
	NTPf5qJW2zwAK1uVJBSP9Yv+e9ShUnZyVaoUALSxhLCc0qr/yRqSwLq5N2jTPP72
	CgcCcqyDwv78o5lF2NzVXpiHxAXttXl0c1g3cS/rBcVA0Saprqxo1+7FaBBlGBYv
	+kzmVZ3BQD6MSjbqRf5kEow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Dsu8ThtB7BTqTp+8ocJU4Z/cq85nf0+ZjAhMBakBbFwC6W
	R2p6ade7N15sJ50gp8WqqRMLSUBjcusJZTNe6bXl5qnyiJ3oEFbGOZHRNGgoHKPD
	jk8CvRoP/7xnZi5nSoqFRxQVPzteiU3js/IV6Wpo/M/xJaoxkwP+7Ba+i2bHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3812F7877;
	Mon, 26 Mar 2012 14:32:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF9097875; Mon, 26 Mar 2012
 14:31:59 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F969CABA-7771-11E1-AF79-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193952>

Rodrigo Silva "(MestreLion)"  <linux@rodrigosilva.com> writes:

> So, what should I do now? Re-send the patch with just the accepted parts
> (and adjusting commit message accordingly)? Or this will be done by you?

People either say "Yeah, I agree with the suggestions---can you apply it
without the change to git-var.txt?", or respond to the review message with
an updated patch with "I agree with the review suggestion and dropped the
change to git-var.txt" after the three-dash lines (i.e. the comment does
not become part of the commit log message).

For something small and easy like this one, it's OK to do either way.

For larger changes, people tend to do the latter, as often they do not
agree (and they do not have to) with *all* the point raised in the review,
and it would become more error prone to let me pick, choose and edit the
original submission.

I'll just apply your patch with minor tweaks.  Thanks.
