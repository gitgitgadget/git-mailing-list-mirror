From: Junio C Hamano <gitster@pobox.com>
Subject: Re: confusing GIT_DIR behavior case
Date: Mon, 17 Mar 2008 16:00:54 -0700
Message-ID: <7v8x0harbt.fsf@gitster.siamese.dyndns.org>
References: <1205793829.5984.1242927563@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Britton Kerin" <bkerin@fastmail.fm>
X-From: git-owner@vger.kernel.org Tue Mar 18 00:02:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbOLD-0004Xh-Np
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 00:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbYCQXBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 19:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbYCQXBN
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 19:01:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYCQXBM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 19:01:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E35CC18CA;
	Mon, 17 Mar 2008 19:01:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C170F18C7; Mon, 17 Mar 2008 19:01:07 -0400 (EDT)
In-Reply-To: <1205793829.5984.1242927563@webmail.messagingengine.com>
 (Britton Kerin's message of "Mon, 17 Mar 2008 14:43:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77468>

"Britton Kerin" <bkerin@fastmail.fm> writes:

>    1.  GIT_DIR (and --git-dir) should make git behave exactly as if git
>    was 
>        wired to look for $GIT_DIR rather than '.git'.  The occurence of
>        the
>        GIT_DIR description in the top-level man page (for 'man git')
>        seems to
>        suggest that this is how things work.

That's underdescribing things.  Presense of GIT_DIR means much more than
that (e.g. you are at the top-level of the repository unless you have
WORK_TREE).

>    4.  The noob docs should make some mention of this issue.

Which "noob docs" did you look at (and do you think other people would
most likely to look at)?  I think the most important description they need
is not to mess with these environment variables.  It might sometimes be
needed to move .git away from its default place (and I haven't been in
that situation yet, so you have to be more advanced than me ;-)), but if
you are doing such a non-default thing, you are certainly no longer
"noob".
