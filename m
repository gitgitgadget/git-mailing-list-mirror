From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] difftool/mergetool: make the form of yes/no questions
 consistent
Date: Tue, 12 Apr 2016 15:01:19 +0100
Message-ID: <20160412140119.GC11013@serenity.lan>
References: <1460465982.3214.7.camel@redhat.com>
 <20160412132737.GB11013@serenity.lan>
 <1460469192.3214.17.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nikola Forrrr <nforro@redhat.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 16:01:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apysq-0000So-3c
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 16:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933182AbcDLOBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 10:01:32 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:45433 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932223AbcDLOBb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2016 10:01:31 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 26F5EC46BA;
	Tue, 12 Apr 2016 15:01:29 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 1D69120D39;
	Tue, 12 Apr 2016 15:01:29 +0100 (BST)
X-Quarantine-ID: <SD0Q8WURpvyh>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.249
X-Spam-Level: 
X-Spam-Status: No, score=-0.249 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, KAM_INFOUSMEBIZ=0.75, URIBL_BLOCKED=0.001]
	autolearn=no autolearn_force=no
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SD0Q8WURpvyh; Tue, 12 Apr 2016 15:01:23 +0100 (BST)
Received: from serenity.lan (unknown [10.2.0.9])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id D46DD621DB;
	Tue, 12 Apr 2016 15:01:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1460469192.3214.17.camel@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291262>

On Tue, Apr 12, 2016 at 03:53:12PM +0200, Nikola Forrrr wrote:
> On Tue, 2016-04-12 at 14:27 +0100, John Keeping wrote:
> > I think the case in these two is correct as-is.  The "Y" is capitalised
> > because it is the default and will take effect if the user just presses
> > ENTER.
> 
> Thanks John, I'm aware of that. That's why the patch doesn't change
> the case. Maybe I should have mention that explicitly in the commit
> message.

Sorry, I completely missed that.  Your patch does in fact look good, so:

	Reviewed-by: John Keeping <john@keeping.me.uk>

I think I was taken in by the commit message saying 'i.e. "Question
[y/n]? "' and didn't examine the patch carefully enough.  It might be
better just to drop the example since it's obvious what the patch does.
