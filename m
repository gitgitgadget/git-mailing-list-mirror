From: "Mario Pareja" <mpareja.dev@gmail.com>
Subject: Re: Locking binary files
Date: Tue, 23 Sep 2008 02:39:41 -0400
Message-ID: <94c1db200809222339t7d65081eq7471fef86fb5ec73@mail.gmail.com>
References: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 08:41:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki1aF-0005OL-U4
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 08:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbYIWGjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 02:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbYIWGjo
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 02:39:44 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:4409 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbYIWGjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 02:39:43 -0400
Received: by yw-out-2324.google.com with SMTP id 9so293662ywe.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 23:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ArqfjmavSZ+qC3zi+y/cX8D8xEbl8MV/65m63XnkZMI=;
        b=DdFaO/xaXz+WT2x1Y7QJ/527Z6nC7Oh35b6d/PWN9TA3GvqweG0x/01c5zHZWt6cyJ
         vMnzp8ntOAf5BG7/auTvEdlHuypmZZ0Cess7G1PDa5PBA6df3XnvLQlUwjJwh0O4eKWk
         4MXjhrDBmObAyLsEFAId3KmdoUBbfBrisgQG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jU0BlMd70Hzd26ADL/VqPY9aDBEF2/DbiMw4pahuNvESCWpOrMuXX0dqTH/HUli1AS
         49l8ggSH0RovicIFhPeKmjxKK1r2pII17lt31pMT1za5FcbAAJRZxl1KY7LpUh3jM0tK
         NrQ8DhmCfdxQyzwvUhAgjZuC4gnC+vUTnj9Ng=
Received: by 10.100.214.19 with SMTP id m19mr4029690ang.1.1222151981805;
        Mon, 22 Sep 2008 23:39:41 -0700 (PDT)
Received: by 10.100.207.17 with HTTP; Mon, 22 Sep 2008 23:39:41 -0700 (PDT)
In-Reply-To: <94c1db200809222333q4953a6b9g8ce0c1cd4b8f5eb4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96526>

Hi,

For one and a half years, I have been keeping my eyes on the git
community in hopes of making the switch away from SVN.  One particular
issue holding me back is the inability to lock binary files.
Throughout the past year, I have yet to see developments on this
issue.  I understand that locking files goes against the fundamental
principles of distributed source control, but I think we need to come
up with some workarounds.  For Linux kernel development this is may
not be an issue; however, for application development this is a major
issue. How else can one developer be sure that time spent editing a
binary file will not be wasted because another developer submitted a
change?

To achieve the effects of locking, a "central" repository must be
identified.  Regardless of the distributed nature of git, most
_companies_ will have a "central" repository for a software project.
We should be able to mark a file as requiring a lock from the
governing git repository at a specified address.  Is this made
difficult because git tracks file contents not files?

In any case, I think this is a crucial issue that needs to be
addressed if git is going to be adopted by companies with binary file
conflict potential. I don't see how a web development company can take
advantage of git to track source code and image file changes.  Any
advice would be great!

Regards,

Mario
