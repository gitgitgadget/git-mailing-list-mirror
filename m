From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH] Reword -M, when in `git log`s documention, to suggest --follow
Date: Sat, 02 Jan 2010 01:38:21 -0500
Message-ID: <1262412622-sup-7473@utwig>
References: <1261428059-31286-1-git-send-email-alex@chmrr.net> <7vhbr6phlx.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 07:40:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQxfF-0003fw-LP
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 07:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568Ab0ABGiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 01:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491Ab0ABGiW
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 01:38:22 -0500
Received: from chmrr.net ([209.67.253.66]:36469 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab0ABGiW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 01:38:22 -0500
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1NQxcz-0000bU-7W; Sat, 02 Jan 2010 01:38:21 -0500
In-reply-to: <7vhbr6phlx.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136024>

At Thu Dec 31 23:35:38 -0500 2009, Junio C Hamano wrote:
> [snip]

Thinking about this more, I'm more convinced that this is just a
symptom of a bigger problem -- why does the help for `git log` start
off with the _diff_ options, which do nothing unless you also use the
-p option?  It adds ~230 lines of options that are irrelevant to the
most common usage model.  It seems to me like the more correct fix
would be to move the diff options to later in the file (after the
options that are `git log`-specific), or to remove them entirely, and
replace them with a pointer to git diff's options.
 - Alex
-- 
Networking -- only one letter away from not working
