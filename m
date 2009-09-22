From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Cygwin git dies silently
Date: Tue, 22 Sep 2009 09:08:52 +0200
Message-ID: <20090922070852.GA30285@localhost>
References: <A80C2B4F6C34430FA32A24BF94647076@ouster> <20090919081900.GA7543@localhost> <33D78C6C5C9F45379BC3C07BD3017260@ouster>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Ousterhout <ouster@cs.stanford.edu>
X-From: git-owner@vger.kernel.org Tue Sep 22 09:09:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpzVD-000790-Oy
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 09:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbZIVHJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 03:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755338AbZIVHJW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 03:09:22 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:62638 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331AbZIVHJV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 03:09:21 -0400
Received: by bwz6 with SMTP id 6so2427469bwz.37
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ZrBnw5ck5XkFw7ssGsKqDmnhsENRWnqHW9lS1dps7qg=;
        b=GyVOiun92r9kBaZc37dwB9YIcGi/4U2t+7xIVAgOK9S48p4bqrj4pomyWNBobAOz4+
         bWY/QytwnTT31sgdOiedVzKrpN1NHcXAtgE/AWDK7GcUTB4LC/BNFabDIhlwq6bEWcus
         L+L5/JQBrAriCEqxHM/sDOZBmTRDWqwTZIXrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=hZZo1iH6eOKS/C3VlWNeb90y1IR3dvUCLck9u25Q2Y+dMFHkYAoN/Djyk4Bz7ySjXf
         Pqvnvnj7Q1IM/4hsF/0KJJ/UHL1/WDM1TMonggfxlAYbUyWzTaBBdUmqgD6BAqyRlHpI
         RKNKYPzjqRbomqPnU8PTwtaGjI6T1EBwbQuxQ=
Received: by 10.103.87.35 with SMTP id p35mr224146mul.75.1253603364425;
        Tue, 22 Sep 2009 00:09:24 -0700 (PDT)
Received: from darc.lan (p549A6BD0.dip.t-dialin.net [84.154.107.208])
        by mx.google.com with ESMTPS id u9sm4057858muf.48.2009.09.22.00.09.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Sep 2009 00:09:22 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MpzUb-0008Uq-4E; Tue, 22 Sep 2009 09:08:53 +0200
Content-Disposition: inline
In-Reply-To: <33D78C6C5C9F45379BC3C07BD3017260@ouster>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128921>

[re-adding the list to Cc for future reference]

On Mon, Sep 21, 2009 at 03:37:43PM -0700, John Ousterhout wrote:

> your message eventually led me to the problem, which
> is that somehow I didn't have libz installed.  Once I installed libz
> git is now working.

I'm surprised that cygwin did not take care of installing the dependencies
for you. After all, you were installing the version "that came with cygwin"?
If that is the case, please file a bug report with cygwin, because it's
clearly a problem with their packaging.

Thanks,
Clemens
