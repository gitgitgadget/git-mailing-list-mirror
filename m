From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Conflict editing
Date: Mon, 5 Mar 2007 10:59:33 +1300
Message-ID: <46a038f90703041359w3cf5ff14n85445396c0ffc422@mail.gmail.com>
References: <Pine.LNX.4.63.0703041339350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070304181044.GC8560@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Mar 04 22:59:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNyjz-0003np-Vk
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 22:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbXCDV7g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 16:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752526AbXCDV7g
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 16:59:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:2478 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbXCDV7f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 16:59:35 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1890666nfa
        for <git@vger.kernel.org>; Sun, 04 Mar 2007 13:59:34 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iwp8kb1Xm6ycoSAJnqsHcoircIoAhlDzZoeH+3/eVRW7+dphN+dhKVEWHmiOnBypfq79njMyquUUXiO2TbEuIgfo5F9tyIl+a5Q8gun9bnAJkBQJzvsr9z2pj1Lb2iA/r5fI6ZwpNaCEN19bjLGKn/XxMBHmHGHmxdcmig1mbUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XqoCHoqWSTwD623fn4/qy10TKtU/oGlzp+x7c7nXk51iWm4cEfbZNtnsa+0SexpjMdiosutloWVZNduqu7pKLdSX4zjsqTnqylL7Z04vMht7E+7LkerkzkUN6YokCkThr/qQCNopCf/tpEIchzblGdG1fuoD1qICLng2ksBlJxc=
Received: by 10.82.175.2 with SMTP id x2mr4199808bue.1173045573857;
        Sun, 04 Mar 2007 13:59:33 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Sun, 4 Mar 2007 13:59:33 -0800 (PST)
In-Reply-To: <20070304181044.GC8560@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41373>

On 3/5/07, Theodore Tso <tytso@mit.edu> wrote:
> It currently uses a hard-wired preference order for the GUI merge
> tools, based on the current functionality of said merge tools, but the
> plan is to add options parsing and a config option to allow a
> user-specified override.
>
> Any comments, suggestions?

I find xxdiff much better than meld, tkdiff and kdiff -- but maybe I
just don't know how to use them, or they have gotten better in the
last few months.

I had written (and posted) a git-xxdiff earlier. A (minor) concern is
that from a packaging and dependencies perspective, the packager has
to suggest *all* of them, and still a default install may not work at
all -- it might be a good idea to suggest what to install in the error
message. Or depend on all of them (yuck!).

One thing I _don't_ want as a user is to see the graphical mergers
starting by default. Most merges are trivial, and I can just edit them
in emacs or vi.

And when a merge is really hard, and calls for merge-centric tools, I
open gitk alongside to see what commits happened on each side.

cheers,


martin
