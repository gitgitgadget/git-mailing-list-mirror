From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: A script to show diff in new window while
 editing commit message.
Date: Wed, 21 Jan 2009 15:59:13 -0800
Message-ID: <7vy6x4b48e.fsf@gitster.siamese.dyndns.org>
References: <4977A2C9.1070502@tedpavlic.com>
 <1232577906-868-1-git-send-email-ted@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 01:00:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPn0A-00054v-8O
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 01:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbZAUX7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 18:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756160AbZAUX7U
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 18:59:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307AbZAUX7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 18:59:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B83192BF1;
	Wed, 21 Jan 2009 18:59:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ED52A92BDF; Wed,
 21 Jan 2009 18:59:14 -0500 (EST)
In-Reply-To: <1232577906-868-1-git-send-email-ted@tedpavlic.com> (Ted
 Pavlic's message of "Wed, 21 Jan 2009 17:45:06 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 839354B0-E817-11DD-82E1-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106705>

Ted Pavlic <ted@tedpavlic.com> writes:

> It could be improved by supporting a command-line flag that would mimic
> the "git commit -v"-type behavior of opening the diff in the same window
> as the commit message. This would extend existing commands like "stg
> edit" that do not already have a "-v"-type option.

If a single-buffer operation is an improvement, then I do not see the
point of this script.

 * Some people would like two-buffer operation and they may use this
   script as their core.editor.

 * Other people (including me) would find it very natural to use "\C-x 2"
   if they need to look at two places of the same buffer, because that is
   what they are used to do when editing a long file every day.  They just
   use "commit -v" without bothering with this script.

 * Yet other people (like Dscho) would find it too late to have a chance
   for final review when writing a commit log message anyway, and won't
   use either.

And I think choice is good.

Having said that, if the lack of "final chance to review the diff" in some
StGIT subcommand is the real problem you are trying to solve, I think it
is better solved by fixing StGIT.  If this script can be used as a
substitute for the real solution, that may be a welcome unintended side
effect, but I do not think you should make it the main selling point of
the script.  After all people may not want to use this script when they
are working directly with git, but still would want StGIT fixed.
