From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Wed, 27 Feb 2008 14:50:41 -0800
Message-ID: <7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
 <7v7igqyii9.fsf@gitster.siamese.dyndns.org>
 <18373.58839.636432.448970@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Feb 27 23:52:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUV86-000373-8e
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 23:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759410AbYB0WvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 17:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760692AbYB0WvD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 17:51:03 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759399AbYB0WvA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 17:51:00 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CD432136;
	Wed, 27 Feb 2008 17:50:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5E1F12131; Wed, 27 Feb 2008 17:50:53 -0500 (EST)
In-Reply-To: <18373.58839.636432.448970@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Thu, 28 Feb 2008 09:36:07 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75315>

Paul Mackerras <paulus@samba.org> writes:

> Another thing: I have noticed that git rev-parse --revs-only doesn't
> pass the --merge and --left-right flags through, even though the help
> for git rev-parse says that --revs-only means "Do not output flags and
> parameters not meant for git-rev-list" (which I assume means the same
> as "Only output flags and parameters meant for git rev-list"), and git
> rev-list accepts and uses the --merge and --left-right flags.  I
> assume this is just an oversight in git rev-parse.

Yeah, the option list is not maintained well for the last few
years and needs to be updated.
