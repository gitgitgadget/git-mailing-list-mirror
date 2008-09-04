From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix AsciiDoc errors in merge documentation
Date: Thu, 04 Sep 2008 16:19:10 -0700
Message-ID: <7vbpz31oup.fsf@gitster.siamese.dyndns.org>
References: <48BFBBEF.6010403@isy.liu.se>
 <200809042348.48570.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gustaf Hendeby <hendeby@isy.liu.se>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 05 01:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbO7u-0002wf-VI
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 01:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYIDXTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 19:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYIDXTT
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 19:19:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbYIDXTS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 19:19:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 912FF746EE;
	Thu,  4 Sep 2008 19:19:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8C008746E9; Thu,  4 Sep 2008 19:19:13 -0400 (EDT)
In-Reply-To: <200809042348.48570.johan@herland.net> (Johan Herland's message
 of "Thu, 04 Sep 2008 23:48:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E56097D2-7AD7-11DD-8EA3-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94972>

Johan Herland <johan@herland.net> writes:

> In the section on conflict markers, the "<<<<<<<" sequence is compiled by
> AsciiDoc into invalid XML. A way to resolve this is by inserting something
> between the last two characters in that sequence (i.e. between '<' and '"').
>
> This patch encloses the conflict markers in backticks, which renders them
> in a monospace font (in the HTML version; the manual page is unaffected),
> and with the pleasant side-effect that it also fixes the AsciiDoc compile
> problem.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>
> On Thursday 04 September 2008, Gustaf Hendeby wrote:
>> Trying to compile the documentation from next has failed for me for a
>> while and now I got to the point where I tracked down the offending
>> commit: 70a3f89733a (git-merge documentation: describe how conflict is
>> presented).
>
> This fixes the problem for me.

Thanks.  It's good to see issues with new changes are resolved while they
are still in 'next'.

Have you tried this patch without double quotes around the teletype text,
by the way?
