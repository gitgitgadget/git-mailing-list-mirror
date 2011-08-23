From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] Documentation: Grammar correction, wording fixes and
	cleanup
Date: Tue, 23 Aug 2011 17:15:06 -0400
Message-ID: <1314134106.5186.64.camel@drew-northup.unet.maine.edu>
References: <7vk4a5wc67.fsf@alter.siamese.dyndns.org>
	 <1314060519-24035-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Aug 23 23:16:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvyKX-0000p9-Ra
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 23:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab1HWVQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 17:16:14 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:59188 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1HWVQM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 17:16:12 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p7NLFBUR014105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Aug 2011 17:15:11 -0400
In-Reply-To: <1314060519-24035-1-git-send-email-bwalton@artsci.utoronto.ca>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p7NLFBUR014105
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1314738915.68808@BcFVaNa8/ZEWl4FCCY+bZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179972>


On Mon, 2011-08-22 at 20:48 -0400, Ben Walton wrote:

> +. You could be using the `objects/info/alternates` or
> +`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanisms to 'borrow'
>  objects from other object stores.  A repository with this kind
>  of incomplete object store is not suitable to be published for
> -use with dumb transports but otherwise is OK as long as
> -`objects/info/alternates` points at the right object stores
> -it borrows from.
> +use with dumb transports but is otherwise OK as long as
> +`objects/info/alternates` points to object stores containing the
> +missing objects.

Umm, I'm not prepared to call this an improvement. The objects aren't
_missing_, they just aren't present in the most immediate object store.
I'm a minimalist when it comes to this sort of edit and would have just
excised the word "right" from the awkward segment.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
