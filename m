From: thestar@fussycoder.id.au
Subject: Re: How to pull remote branch with specified commit id?
Date: Wed, 14 Jan 2009 16:54:47 +1100
Message-ID: <20090114165447.qdlwqqfnk4goccgg@webmail.fussycoder.id.au>
References: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com>
	<496C6234.9040903@viscovery.net> <496D0E65.3000200@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailinglist <git@vger.kernel.org>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 07:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMyqJ-000435-NP
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 07:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbZANGBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 01:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbZANGBl
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 01:01:41 -0500
Received: from cherry.cbr.hosting-server.com.au ([203.88.118.153]:43597 "EHLO
	cherry.cbr.hosting-server.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754424AbZANGBk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 01:01:40 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Jan 2009 01:01:39 EST
Received: (qmail 9855 invoked by uid 48); 14 Jan 2009 16:54:48 +1100
Received: from  ( [unknown]) by webmail.fussycoder.id.au (Horde MIME
	library) with HTTP; Wed, 14 Jan 2009 16:54:47 +1100
In-Reply-To: <496D0E65.3000200@kitware.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105587>

> Johannes Sixt wrote:
>> Consider this: You accidentally push a branch with confidential data to a
>> public repository. You notice it early, and quickly delete the branch
>> using 'git push the-repo :refs/heads/that-branch'. At this time the
>> objects with the confidential data are still lingering in the public
>> repository. But with the current behavior noone can access them even if
>> the SHA1 happens to be known.

Doesn't this line of reasoning only apply to the ssh and git transports?
  (ie, the file and rsync transport would retrieve it regardless)
