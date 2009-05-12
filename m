From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git fails with control characters in trunk directory name
Date: Tue, 12 May 2009 08:51:29 +0200
Message-ID: <81b0412b0905112351l126a7c5bh902a7c7748d9a77a@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
X-From: git-owner@vger.kernel.org Tue May 12 08:51:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3lq0-0006N0-GL
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 08:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198AbZELGvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 02:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755953AbZELGvb
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 02:51:31 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:51328 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755865AbZELGva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 02:51:30 -0400
Received: by bwz22 with SMTP id 22so3074666bwz.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Np35GM2vKyI1fy1BDMDyt2NNcTnpkxI5HQEDl1eakYA=;
        b=IzTx+Zr644/hT4AEaXjCY6bFQsLfzX0Ttxp5pyVhoQSjs9QOBLzG/9j+Y4GheX6tln
         QN+jHt/YjO8viXKCuZ+Kd2p/YTGRR8e2YpiQuxOxskOH2BNcCHVfhAezU5+4ZlwOKYch
         +YkDCt2RBep4bxTLBhki7G/7x5vw/tOxD93Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=v+pZzUq+cRyrT8on2zXdGNGY+Ro6pZ3hwiTm8BfbyQLeDXe2cKnJrXIh8+VjQAWs2F
         s24ghaAIdIOy64M8zRtllilVHYlmSmePEvc20yXCuWInbyCEhp/ll/b67ArBgWGPWmuf
         I54nmqmLvv99mbhzWrtSZHEUu7YfFjFMeMP1Q=
Received: by 10.204.121.140 with SMTP id h12mr7724790bkr.70.1242111089958; 
	Mon, 11 May 2009 23:51:29 -0700 (PDT)
In-Reply-To: <200905112208.21017.Hugo.Mildenberger@namir.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118873>

2009/5/11 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
> Using the mouse to paste a git url from a website into a terminal session in
> order to clone the repository, I recently managed to include invisible
> control characters into the git trunk directory name.

Git has no "trunk". Not in CVS/CVN sense, at least

> Consequently, I faced all sort of strange behaviour like git pull not working
> (error 2), later on a kernel make which supposedly could not finding a rule
> to create the trunk directory and more such inconsistencies.
> I then reinstalled git, rcs and so on and also tried unsuccessfully several
> git versions. The next morning I looked into the .git/config file and
> recognized that the "url" key value within the [remote "origin"] section
> contained some control characters: ^J and \n, as fas as I remember.

What platform are you on?
Can you show your .git/config?

> While this was almost entirely my fault, git could possibly apply a filter,
> reject such a name or at least issue a warning.

Maybe. Or maybe it can just work (well, assuming the user meant to
use an url with character you considered "control").
