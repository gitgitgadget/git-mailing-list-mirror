From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git-archimport log entries more consistent
Date: Wed, 29 Aug 2007 20:14:17 -0700
Message-ID: <7vmyw9af3q.fsf@gitster.siamese.dyndns.org>
References: <617indss2f.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 30 05:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQaUU-0002bc-Ri
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 05:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180AbXH3DOi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 23:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbXH3DOh
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 23:14:37 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031AbXH3DOh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 23:14:37 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B8E2312AE40;
	Wed, 29 Aug 2007 23:14:56 -0400 (EDT)
In-Reply-To: <617indss2f.fsf@fencepost.gnu.org> (Miles Bader's message of
	"Wed, 29 Aug 2007 21:56:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56995>

Miles Bader <miles@gnu.org> writes:

> When appending the "git-archimport-id:" line to the end of log entries,
> git-archimport would use two blank lines as a separator when there was no
> body in the arch log (only a Summary: line), and zero blank lines when there
> was a body (making it hard to see the break between the actual log message
> and the git-archimport-id: line).
>
> This patch makes git-archimport generate one blank line as a separator in all
> cases.

I would not have any problem with what the result of this patch
would record in the commits, if it was what it did from the very
beginning.  But this is a change in behaviour; I'd like to know
if people who use archimport _rely_ on the current behaviour...

Anybody?
