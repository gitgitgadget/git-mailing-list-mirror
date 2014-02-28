From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC 0/3] Make git more user-friendly during a merge conflict
Date: Fri, 28 Feb 2014 11:11:53 +0100
Message-ID: <87fvn335sm.fsf@fencepost.gnu.org>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<20140226202601.GK7855@google.com> <857g8f1ugu.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Feb 28 11:12:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJKQD-0001Ip-Ry
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 11:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbaB1KL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 05:11:56 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:37472 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaB1KLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 05:11:55 -0500
Received: from localhost ([127.0.0.1]:36513 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WJKQ6-00064x-8m; Fri, 28 Feb 2014 05:11:54 -0500
Received: by lola (Postfix, from userid 1000)
	id DC172E06B9; Fri, 28 Feb 2014 11:11:53 +0100 (CET)
In-Reply-To: <857g8f1ugu.fsf@stephe-leake.org> (Stephen Leake's message of
	"Fri, 28 Feb 2014 03:01:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242936>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> I like commands that "do the right thing". So no, this would not be
> confusing.

I _hate_ commands that think they know better than to do what they are
told.  In particular when doing destructive things.  And just because
_you_ like them does not mean they are not confusing.

In the long run, it is much more confusing if you come to rely on some
commands doing "the right thing" while in other cases, the actually
written thing is done.

"do the right thing" commands also tend to do the wrong thing
occasionally with potentially disastrous results when they are used in
scripts where the followup actions rely on the actual result.

-- 
David Kastrup
