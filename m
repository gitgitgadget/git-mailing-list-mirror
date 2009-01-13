From: Brad King <brad.king@kitware.com>
Subject: Re: How to pull remote branch with specified commit id?
Date: Tue, 13 Jan 2009 16:57:57 -0500
Message-ID: <496D0E65.3000200@kitware.com>
References: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com> <496C6234.9040903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:08:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMrQP-00015L-Pe
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 23:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755209AbZAMWG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 17:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755175AbZAMWG1
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 17:06:27 -0500
Received: from public.kitware.com ([66.194.253.19]:44929 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbZAMWG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 17:06:26 -0500
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Jan 2009 17:06:26 EST
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id 48CC24A02;
	Tue, 13 Jan 2009 16:59:43 -0500 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id 9587C89861;
	Tue, 13 Jan 2009 16:57:57 -0500 (EST)
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <496C6234.9040903@viscovery.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105549>

Johannes Sixt wrote:
> Consider this: You accidentally push a branch with confidential data to a
> public repository. You notice it early, and quickly delete the branch
> using 'git push the-repo :refs/heads/that-branch'. At this time the
> objects with the confidential data are still lingering in the public
> repository. But with the current behavior noone can access them even if
> the SHA1 happens to be known.

Might a repack (perhaps an automatic one) put the object in a pack
(perhaps in a delta chain) that can be fetched through another ref?

-Brad
