From: John Keeping <john@keeping.me.uk>
Subject: Re: Minor correction to Git book
Date: Wed, 8 May 2013 11:51:42 +0100
Message-ID: <20130508105141.GH25912@serenity.lan>
References: <71E08C07CB3C444098033ABD69925159145BB1DDE1@BATH-EXCMS.praxis.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Robin Messer <robin.messer@altran.com>
X-From: git-owner@vger.kernel.org Wed May 08 12:52:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua1yf-00006B-98
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 12:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881Ab3EHKv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 06:51:57 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56278 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754875Ab3EHKvx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 06:51:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E01A8866034;
	Wed,  8 May 2013 11:51:52 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c7YBc1CpYWZv; Wed,  8 May 2013 11:51:47 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4E97286602E;
	Wed,  8 May 2013 11:51:43 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <71E08C07CB3C444098033ABD69925159145BB1DDE1@BATH-EXCMS.praxis.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223654>

On Wed, May 08, 2013 at 11:24:56AM +0100, Robin Messer wrote:
> I'm just learning Git so I don't yet know how to submit this
> as a patch, but I'm reading the Git Book to get myself started
> and I think there is a mistake on the page at:
> 
> http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Repository
> 
> It says: "For another example, if you stage the benchmarks.rb file and
> then edit it, you can use git diff to see the changes in the file that
> are staged and the changes that are unstaged:"
> 
> I believe this should say "git status" rather than "git diff".

I think the text is correct as it stands.  "git status" shows you that
there are changes that are staged and unstaged, "git diff" (and "git
diff --cached") shows you what those changes are.
