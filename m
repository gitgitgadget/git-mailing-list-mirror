From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: newb: Given a commit id, find which branches have it as an ancestor
Date: Thu, 12 Mar 2009 14:38:38 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794302E0F9BA@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794302E0F9B2@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 12 20:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhqlI-0007HN-H6
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 20:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbZCLTim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 15:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751908AbZCLTim
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 15:38:42 -0400
Received: from emailmn.mqsoftware.com ([66.192.70.108]:51026 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZCLTil convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 15:38:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302E0F9B2@emailmn.mqsoftware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: newb: Given a commit id, find which branches have it as an ancestor
Thread-Index: AcmjKJxyC0yXiQXZQOCnrhthFMdemAAHpzkAAACA0+A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113116>

> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Johannes Sixt
> Sent: Thursday, March 12, 2009 10:38 AM
> To: Kelly F. Hickel

> $ git branch -a --contains the-sha1
> 
> -- Hannes
> 

Thanks, that looks like a really useful command.

Unfortunately, in this case it didn't print anything out (neither did
"git branch -r -a sha1").

What I'm beginning to suspect is that all the commits that should have
gone to master went to some unnamed branch.
Is that reasonable/possible/likely?  This commit has a full ancestry,
but doesn't appear to be on any branch.

In the above question there's an assumption that if a branch exists
without a name, then git branch -a --contains wouldn't print anything
out, is that correct?

Thanks,
Kelly
