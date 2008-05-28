From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH/RFC] Revert "filter-branch: subdirectory filter needs
 --full-history"
Date: Tue, 27 May 2008 22:25:10 -0700
Message-ID: <7vbq2rxao9.fsf@gitster.siamese.dyndns.org>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com>
 <200805251426.54755.johannes.sixt@telecom.at>
 <alpine.LFD.1.10.0805251359290.3081@woody.linux-foundation.org>
 <200805262109.19015.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, David Tweed <david.tweed@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed May 28 07:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1EB8-0002o8-Eb
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 07:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbYE1FZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 01:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYE1FZe
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 01:25:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYE1FZd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 01:25:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D8CF53601;
	Wed, 28 May 2008 01:25:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1AB223600; Wed, 28 May 2008 01:25:18 -0400 (EDT)
In-Reply-To: <200805262109.19015.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Mon, 26 May 2008 21:09:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7BFA70B0-2C76-11DD-9628-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83070>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> ... I'm not prepared to dive into
> the revision walk manchinery, so I instead propose to just remove
> --full-history from git-filter-branch.

Ok, let's punt for now and rethink this in the next cycle for 1.6.0.
