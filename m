From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH TAKE 2] Avoid a useless prefix lookup in strbuf_expand()
Date: Sat, 09 Feb 2008 18:36:08 -0800
Message-ID: <7vr6fl5yhz.fsf@gitster.siamese.dyndns.org>
References: <1202568019-20200-1-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:37:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO24G-0003yB-2w
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754925AbYBJCgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbYBJCgc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:36:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbYBJCgb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:36:31 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DAC2511F6;
	Sat,  9 Feb 2008 21:36:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D4B411F3;
	Sat,  9 Feb 2008 21:36:25 -0500 (EST)
In-Reply-To: <1202568019-20200-1-git-send-email-mcostalba@gmail.com> (Marco
	Costalba's message of "Sat, 9 Feb 2008 15:40:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73295>

Marco Costalba <mcostalba@gmail.com> writes:

> Currently the --prett=format prefix is looked up in a

s/prett/&y/;

> New patch with Junio suggestions included.

Hmph, this is a blast from the past.

I do recall pointing out that a rather common "format:%an <%ae>"
ends up parsing the same line twice, and mentioned we may want
to memoise the first call's result in the format_commit_context
structure, but what else did I suggest???

Anyway, I'll take a look later.  Thanks.
