From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: A couple branch questions
Date: Wed, 13 Feb 2008 17:45:16 -0800
Message-ID: <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 02:45:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPTAg-0008Rv-FG
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 02:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbYBNBpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 20:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbYBNBpS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 20:45:18 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:17482 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbYBNBpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 20:45:17 -0500
Received: by rv-out-0910.google.com with SMTP id k20so133358rvb.1
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RoJDws6N84DmSdS3EMEwrF5ipHsE7h6bD4PIAifQSRQ=;
        b=lVLHonbnN4o9X2PmBJlpi/6XJ7Qt7kV87utuuJ9cSpZyp1Il98PLAENhOITrpEeb+AT6TRUBcHtsDorgfOi0d+U4T2gqStLBEtBfYnVgD4UHgjpgT1LmWGsIszYEQ7spXwiXhFkAsWBc/4mW6hbAI9ruh848VV7e+F5+E7nHnvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=heg35E7EycMc4JSVFV/ceXeyu1M3fR9vQ7dNYYz1mm7SYpxa+s1XMMIGuRwZTiZyuE0gsuryVez144RDPg9iOXbnv/+JLpaEOb09qiH1Rz0hbWA2WCqQO6jjLRl0NHYZg9MQy3waoFm/PDU12rnYwRcq4V0xO/7jthhBSxF97Rk=
Received: by 10.140.88.11 with SMTP id l11mr497039rvb.156.1202953516208;
        Wed, 13 Feb 2008 17:45:16 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Wed, 13 Feb 2008 17:45:16 -0800 (PST)
In-Reply-To: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73839>

On Feb 13, 2008 5:39 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> 1) git-branch -d <branchname> complains if <branchname> hasn't been
> merged to HEAD. Shouldn't it really only complain if <branchname>
> hasn't been merged into any local branch? i.e., as long as
> <branchname> has been merged, why care to which branch?

It's easy to mistype branch names, and you typically only delete them
after you merge them into your current branch. If you're really sure,
just pass -D instead of -d.


Dave.
