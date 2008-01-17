From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Thu, 17 Jan 2008 09:57:23 -0800
Message-ID: <7vtzlcjpx8.fsf@gitster.siamese.dyndns.org>
References: <7vk5m9kvf7.fsf@gitster.siamese.dyndns.org>
	<478F8D9B.5080703@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFZ0j-0002Gd-Ax
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbYAQR5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYAQR5f
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:57:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbYAQR5e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 12:57:34 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 009571CC1;
	Thu, 17 Jan 2008 12:57:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8953A1C3F;
	Thu, 17 Jan 2008 12:57:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70884>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> In lockfile.c:commit_locked_index()
>
> You didn't include the portion of your patch that
> assigned NULL to alternate_index_output before
> attempting to close and rename.
>
> Should that be included?

You are right, but that is a separate topic and should be a
separate patch, so I dropped the hunk from that commit.
