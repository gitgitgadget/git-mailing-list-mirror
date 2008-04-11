From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Force the medium pretty format on calls to git log
Date: Thu, 10 Apr 2008 22:41:35 -0700
Message-ID: <7vy77lt0c0.fsf@gitster.siamese.dyndns.org>
References: <1207843521-8492-1-git-send-email-melo@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Fri Apr 11 07:42:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkC24-0008Nt-Kn
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 07:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbYDKFls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 01:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbYDKFls
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 01:41:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36315 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbYDKFls (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 01:41:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D1B52BA8;
	Fri, 11 Apr 2008 01:41:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E04662BA7; Fri, 11 Apr 2008 01:41:43 -0400 (EDT)
In-Reply-To: <1207843521-8492-1-git-send-email-melo@simplicidade.org> (Pedro
 Melo's message of "Thu, 10 Apr 2008 17:05:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79265>

Pedro Melo <melo@simplicidade.org> writes:

> If a user as set a format.pretty in his config, git-svn rebase will fail
> with:
>
> Unable to determine upstream SVN information from working tree history
>
> We need to force the medium format to obtain the needed information from
> the log.
>
> Signed-off-by: Pedro Melo <melo@simplicidade.org>

Thanks.  This should have been part of 9225d7b (specify explicit
"--pretty=medium" with `git log/show/whatchanged`, 2008-03-02) but
apparently we did not do a thorough job.
