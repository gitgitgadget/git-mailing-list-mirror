From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Configure test for FREAD_READS_DIRECTORIES
Date: Wed, 05 Mar 2008 09:57:22 -0800
Message-ID: <7vd4q9njel.fsf@gitster.siamese.dyndns.org>
References: <200803041048.53399.michal.rokos@nextsoft.cz>
 <200803041217.37027.michal.rokos@nextsoft.cz>
 <7v7igi911y.fsf@gitster.siamese.dyndns.org>
 <200803041248.54197.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Wed Mar 05 19:00:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWxsc-0004Y9-Da
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 18:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbYCER5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 12:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYCER5f
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 12:57:35 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYCER5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 12:57:35 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 666E41321;
	Wed,  5 Mar 2008 12:57:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B1E1312FE; Wed,  5 Mar 2008 12:57:26 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76247>

Michal Rokos <michal.rokos@nextsoft.cz> writes:

> Will do... Did that.
>
> Do you think that there's some reason not-to merge it?

Yes, if you meant "apply as-is" by "merge it".  No, if you meant "apply
after an initial round of sanity checks, even if it is not perfect".

I was hoping that with this approach, in a week after you sent
out your call-for-help-in-testing, you could send a version for
inclusion with a commit log message that says "tested on X (by
Foo), Y (by Bar),...", with the patch text that is exactly the
same as what people tested.  The point is not to make that list
of platforms exhaustive, but at least make it a bit more than
"works for me".

And I think that plan has worked well.
