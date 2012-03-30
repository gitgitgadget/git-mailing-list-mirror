From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Fri, 30 Mar 2012 16:12:14 -0700
Message-ID: <7vhax5k7jl.fsf@alter.siamese.dyndns.org>
References: <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org>
 <20120330210112.GA20734@sigill.intra.peff.net>
 <7vzkaxkccg.fsf@alter.siamese.dyndns.org>
 <20120330215344.GD20734@sigill.intra.peff.net>
 <7vvcllka61.fsf@alter.siamese.dyndns.org>
 <20120330222044.GA22371@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 01:12:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDkzd-0003Ej-NC
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 01:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761579Ab2C3XMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 19:12:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761541Ab2C3XMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 19:12:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9255E5FFA;
	Fri, 30 Mar 2012 19:12:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xGjk5sG4gpRM8ibH7NmPw6V8Fks=; b=l4yUvS
	wAdGqzk6h3rysxZxF5BVwUYphjex5pGJe2bxzojpotzxpYBJXeSy+DAJlXgtGwHK
	gPHMSiLt5MYEYLc/ZIoXMYIk278W/XDIhHClI3ozuNe0fvsDweyaaltyjV+7N098
	v3s6ProLIlm0yAcXZpYY6msa/kaEsVFvflSO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jM1LB4DqUjTPTsu74bLdQPtrjuMGLgcR
	TlNiJGa2Eep9z7sZBdZupiNImyqmnasfMJbBler+OnOg3XiB13ONonJ571FAwr9R
	T+QWdw/zgIYDNF0DH9xnl4zF6np2jfY3tnkuotnlUWP4KhffITV3hTWc+roF5uD1
	Si93Rjx8biI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89D435FF9;
	Fri, 30 Mar 2012 19:12:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E17B45FF6; Fri, 30 Mar 2012
 19:12:16 -0400 (EDT)
In-Reply-To: <20120330222044.GA22371@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 30 Mar 2012 18:20:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAE6961A-7ABD-11E1-AE19-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194424>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 30, 2012 at 03:15:34PM -0700, Junio C Hamano wrote:
>
>> In the meantime, we can do this.
>
> I'm OK with this. We could perhaps even invite people to take part in
> the discussion. I'm not sure if that will generate anything more than a
> set of "me too" votes, though.

Yeah, but at that point, people who pushed against "matching" will help
us, instead of letting us hang dry.

I really hated that 1.6.0 transition, where noisy vocal ones disappeared
once they got what they wanted without defending the choice they forced on
us.

 Documentation/RelNotes/1.7.10.txt |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RelNotes/1.7.10.txt b/Documentation/RelNotes/1.7.10.txt
index d326ff8..5d72446 100644
--- a/Documentation/RelNotes/1.7.10.txt
+++ b/Documentation/RelNotes/1.7.10.txt
@@ -32,12 +32,12 @@ Compatibility Notes
  * When you do not tell which branches and tags to push to the "git push"
    command in any way, the command used "matching refs" rule to update
    remote branches and tags with branches and tags with the same name you
-   locally have.  In future versions of Git, this will change to use the
-   "upstream" rule to update the branch at the remote you would "pull"
-   from into your current branch with your local current branch.  The
-   release after 1.7.10 will start issuing a warning about this change,
-   to encourage you to tell the command what to push out, e.g. by setting
-   push.default configuration.
+   locally have.  In future versions of Git, this will change to push out
+   only your current branch according to either the "upstream" or the
+   "current" rule.  Although "upstream" may be more powerful once the
+   user understands Git better, the semantics "current" gives is
+   simpler and easier to understand for beginners and may be a safer
+   and better default option, but we haven't decided yet.
 
 
 Updates since v1.7.9
