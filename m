From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-add.txt: Explain --patch option in layman terms
Date: Mon, 31 Aug 2009 10:46:06 +0300
Organization: Private
Message-ID: <87y6p08lz5.fsf@jondo.cante.net>
References: <87ocpxb46g.fsf@jondo.cante.net>
	<7vab1hdppb.fsf@alter.siamese.dyndns.org>
	<87tyzp9da4.fsf@jondo.cante.net>
	<7vskf954sr.fsf@alter.siamese.dyndns.org>
	<87ab1gaol2.fsf@jondo.cante.net>
	<7vbplw28js.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 09:46:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi1an-0001Ae-0f
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 09:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbZHaHqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 03:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbZHaHqL
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 03:46:11 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:47528 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbZHaHqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 03:46:10 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 9570518CEE8;
	Mon, 31 Aug 2009 10:46:11 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A078A093014; Mon, 31 Aug 2009 10:46:11 +0300
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 3A55B2BD51;
	Mon, 31 Aug 2009 10:46:06 +0300 (EEST)
cc: jari.aalto@cante.net
In-Reply-To: <7vbplw28js.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 30 Aug 2009 16:20:23 -0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127467>

Junio C Hamano <gitster@pobox.com> writes:

I apologize if you though I did not read. I did, but I the separate
paragraph order did not meet here as you might have intended.

To recap, your suggestion, if read correct:

    --patch:
    -p::
        Review the difference between the index and the work tree, and add
        modified contents to the index interactively by choosing which
        patch hunks to use.

        Run ``add --interactive``, but bypass the initial command menu and
        directly jump to `patch` subcommand.  See ``Interactive mode'' for
        details.

For more direct first line, howabout:

    --patch:
    -p::
        In a modified work tree, choose interactively which patch hunks to
        add. This gives a change to review the difference between the
        index and the work before adding modified contents to the index.

        This effectively runs ``add --interactive``, but bypass the
        initial command menu and directly jump to `patch` subcommand.
        See ``Interactive mode'' for details.

Jari
