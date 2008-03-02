From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] specify explicit "--pretty=medium" with `git
 log/show/whatchanged`
Date: Sun, 02 Mar 2008 09:00:26 -0800
Message-ID: <7vod9xoyc5.fsf@gitster.siamese.dyndns.org>
References: <7vr6etvlgm.fsf@gitster.siamese.dyndns.org>
 <1204448753-4471-1-git-send-email-crquan@gmail.com>
 <1204448753-4471-2-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:01:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrYv-0002y6-R4
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbYCBRAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYCBRAp
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:00:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbYCBRAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:00:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 00F771330;
	Sun,  2 Mar 2008 12:00:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 398B5132F; Sun,  2 Mar 2008 12:00:34 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75808>

Denis Cheng <crquan@gmail.com> writes:

> The following patch will introduce a new configuration variable,
> "format.pretty", from then on the pretty format without specifying
> "--pretty" might not be the default "--pretty=medium", it depends on
> the user's config. So all kinds of Shell/Perl/Emacs scripts that needs
> the default medium pretty format must specify it explicitly.
>
> Signed-off-by: Denis Cheng <crquan@gmail.com>
> ---
>  contrib/emacs/git.el             |    2 +-
>  contrib/hooks/post-receive-email |    2 +-
>  git-cvsserver.perl               |    2 +-
>  git-merge.sh                     |    2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

I think --pretty is enough and you do not have to say --pretty=medium, but
as long as we are being explicit, we'd better be fully explicit to future
proof them.

The list of in-tree users and places match what I found with my quick
review, which hopefully means both of us did our best effort to catch
potential breakages.

Thanks.


