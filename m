From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log --graph --first-parent weirdness
Date: Wed, 04 Jun 2008 11:05:38 -0700
Message-ID: <7v1w3dxeh9.fsf@gitster.siamese.dyndns.org>
References: <20080604150042.GA3038@mithlond.arda.local>
 <7vmym1xgy4.fsf@gitster.siamese.dyndns.org>
 <20080604173820.GA3038@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:06:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3xNm-0006K5-09
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 20:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYFDSFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 14:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753645AbYFDSFx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:05:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbYFDSFx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 14:05:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5839C5E82;
	Wed,  4 Jun 2008 14:05:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8228F5E80; Wed,  4 Jun 2008 14:05:47 -0400 (EDT)
In-Reply-To: <20080604173820.GA3038@mithlond.arda.local> (Teemu Likonen's
 message of "Wed, 4 Jun 2008 20:38:20 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DDFBAC6C-3260-11DD-9BCB-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83804>

Teemu Likonen <tlikonen@iki.fi> writes:

> To me it's perfectly fine to turn off --graph when used with
> --first-parent, but yes, generally users might expect to see a line of
> M's, *'s and |'s there. At least it would clearly show which commits are
> merges and which are not.

I disagree.  If you are doing --first-parent, you do not _care_ what is
merge and what is not.  Besides, you can easily see that from the log
message if you cared enough.

And if the graph actually draws the real ancestry graph (i.e. without
--first-parent), the lines visually show which is merge and which is not,
so the "M" gets very distracting.

I'd really suggest changing the "M" and use "*" everywhere.
