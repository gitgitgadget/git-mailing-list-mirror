From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] builtin/blame.c::prepare_lines: fix allocation size of sb->lineno
Date: Sat, 08 Feb 2014 22:34:42 +0100
Message-ID: <87ha89b85p.fsf@fencepost.gnu.org>
References: <1391851166-10393-1-git-send-email-dak@gnu.org>
	<87lhxmc4sr.fsf@fencepost.gnu.org>
	<20140208212154.GA4283@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 08 22:34:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCFY1-0006hx-5r
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 22:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbaBHVeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 16:34:44 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:51934 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbaBHVeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 16:34:44 -0500
Received: from localhost ([127.0.0.1]:50976 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WCFXv-00050Z-6F; Sat, 08 Feb 2014 16:34:43 -0500
Received: by lola (Postfix, from userid 1000)
	id B95C3E12E5; Sat,  8 Feb 2014 22:34:42 +0100 (CET)
In-Reply-To: <20140208212154.GA4283@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 8 Feb 2014 16:21:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241863>

Jeff King <peff@peff.net> writes:

> However, is there a reason not to use:
>
>   sizeof(*sb->lineno)
>
> rather than
>
>   sizeof(int)
>
> to avoid type-mismatch errors entirely (this applies both to this patch,
> and to any proposed rewrites using malloc).

It deviates from the style of the original code by tried and true Git
developers.  So feel free to roll your own patch here: it's not like
this one has any copyrightable content in it.

-- 
David Kastrup
