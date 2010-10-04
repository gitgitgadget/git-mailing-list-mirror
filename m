From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v4 0/4] Detection of directory renames
Date: Mon, 4 Oct 2010 01:20:54 -0500
Message-ID: <20101004062054.GI24884@burratino>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 08:24:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2eT9-0000cI-Om
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 08:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab0JDGYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 02:24:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52740 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab0JDGYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 02:24:09 -0400
Received: by gwj17 with SMTP id 17so1556144gwj.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=A0YFIQM0oEDzlyJjI0ip0DXXOdRPwSzZVcPXaDNONEA=;
        b=cWtC9vloWQpqBwJtSSrLHIG8WrViRlgGojVGdeekoD75v70opSXmE8j6p+FPkvS3+X
         Vsp7Hl0VmSvjL1DFdMOwACMumUa/1+NY9/Aij2/xwqj9OIIFi4JQxxYkVDV2iifEnp84
         UY5Hl3gs+BH6KIx0jpjUsKDamZQvyydUfwNX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nboCdpEz9zgTPF9YFX/pzCJqmbirFdvhtFLWa0QHeGBbaCP3uwybR6sGFnUQ92Dy2w
         dJYxtTxcovU7mPWseFBRYY5osEhS+wEoAGT/PL1IMzMBTnB2VDvREzzFQ5yujWgDF/ii
         fnJKHsMRg3hnDGhNJUNPJo7qqqcoH/SO2fUzI=
Received: by 10.101.25.13 with SMTP id c13mr5050361anj.123.1286173448708;
        Sun, 03 Oct 2010 23:24:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i30sm8614629anh.29.2010.10.03.23.24.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 23:24:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286138529-6780-1-git-send-email-ydirson@altern.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157981>

Yann Dirson wrote:

> At last a reroll of that old series.

v3: http://thread.gmane.org/gmane.comp.version-control.git/99780
v2: http://thread.gmane.org/gmane.comp.version-control.git/99529
v1: http://thread.gmane.org/gmane.comp.version-control.git/94612

In particular, from the cover letter to v1:

| I often found myself lost when looking at a diff where a couple of
| large dirs where renamed, and a handful of files were modified to take
| the rename into account - not a rare situation, I'd say.  In such a
| case, the diffs themselves are mostly hidden among numerous rename
| entries.
| 
| To that, I felt that git ought to know better, and could easily
| present a directory rename as such.

Yes!

> I hope we can turn the simple detection feature to something
> acceptable for inclusion - that is, once unified diff output shows the
> detected renames as annotations, and once the known major holes are
> plugged (both from FIXME and testcases).

Okay, I look forward to learning the output format.
