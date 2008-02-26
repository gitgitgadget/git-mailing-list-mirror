From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Support TEST_GIT_PATH variable for the path for the git to
 test
Date: Tue, 26 Feb 2008 13:01:48 -0800
Message-ID: <7vhcfv4ekj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802251600220.19024@iabervon.org>
 <7v63wch9ia.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261242210.19024@iabervon.org>
 <7v63wb5zec.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261350510.19024@iabervon.org>
 <7vpruj4ge1.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0802261539130.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:03:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU6wm-0002Ef-3l
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 22:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbYBZVCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 16:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957AbYBZVCF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 16:02:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57382 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbYBZVCE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 16:02:04 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 247EF165D;
	Tue, 26 Feb 2008 16:02:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 769D6165B; Tue, 26 Feb 2008 16:01:55 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802261539130.19665@iabervon.org> (Daniel
 Barkalow's message of "Tue, 26 Feb 2008 15:46:17 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75173>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> Ok, so even "installed" case need to rely on "test-blah" we build.
>
> Right. Would it be okay to build those into t/helpers/* or something, 
> instead of into the project root, so that they're just naturally separate 
> from the actual program?

Yeah, it sounds like a plan.
