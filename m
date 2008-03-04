From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix 'git remote show' regression on empty repository in
 1.5.4
Date: Tue, 04 Mar 2008 00:37:28 -0800
Message-ID: <7vd4qaanqv.fsf@gitster.siamese.dyndns.org>
References: <20080304060036.GA17106@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:38:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSfc-0007zj-UU
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762666AbYCDIhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762644AbYCDIhr
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:37:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762596AbYCDIhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:37:46 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 49D183949;
	Tue,  4 Mar 2008 03:37:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A8F2F3948; Tue,  4 Mar 2008 03:37:39 -0500 (EST)
In-Reply-To: <20080304060036.GA17106@spearce.org> (Shawn O. Pearce's message
 of "Tue, 4 Mar 2008 01:00:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76052>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  It will cause a merge conflict against `master` as there is a
>  change there to invoke transport_disconnect(transport) before
>  displaying the refs.
>
>  Since the disconnect patch is not in maint, but this is a current
>  regression in 1.5.4.3, I'm sending you a conflicting patch.  :)

That's perfectly fine.  Merging is what maintainers do.

