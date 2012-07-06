From: Marc Branchaud <mbranchaud@xiplink.com>
Subject: Re: [PATCH 3/6] Teach clone to set remote.default.
Date: Fri, 06 Jul 2012 17:49:11 -0400
Message-ID: <4FF75D57.7010603@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com> <1341526277-17055-4-git-send-email-marcnarc@xiplink.com> <7vzk7dq0qk.fsf@alter.siamese.dyndns.org> <4FF6F811.7000808@xiplink.com> <7vd348of0z.fsf@alter.siamese.dyndns.org> <4FF74DD4.1060800@xiplink.com>
Reply-To: marcnarc@xiplink.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 23:56:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnGW8-00054s-3A
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 23:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932992Ab2GFV4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 17:56:41 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:57166 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab2GFV4l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 17:56:41 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2012 17:56:41 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp12.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 157A13C181D
	for <git@vger.kernel.org>; Fri,  6 Jul 2012 17:49:35 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp146.ord.emailsrvr.com (smtp146.ord.emailsrvr.com [173.203.6.146])
	by smtp12.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id E2A5F3C1823
	for <git@vger.kernel.org>; Fri,  6 Jul 2012 17:49:34 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id CF8781C80A6;
	Fri,  6 Jul 2012 17:49:02 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 34B811C809D;
	Fri,  6 Jul 2012 17:49:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <4FF74DD4.1060800@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201152>

On 12-07-06 04:43 PM, Marc Branchaud wrote:
> 
> So why change "git clone" to always set remote.default if the functionality
> remains the same either way?
> 
> To me it makes a more consistent implementation.  Since "git remote add" sets
> remote.default if it's adding the first remote to the repository, when clone
> itself adds the first remote it should do the same.
> 
> Plus this approach makes "clone -o" also work without any special-casing, so
> the code is cleaner, IMHO.

Also, it means that

	git clone /some/repo

and

	git clone -o origin /some/repo

produce exactly the same result.

		M.
