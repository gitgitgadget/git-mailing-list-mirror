From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] git-cvsexportcommit: don't cleanup .msg if not yet committed to cvs.
Date: Thu, 1 Mar 2007 14:29:38 +1300
Message-ID: <46a038f90702281729r71fd8241t554a3a281d211ecb@mail.gmail.com>
References: <20070227181721.GA4244@bogon.ms20.nix>
	 <20070228123539.23809.qmail@d6daeb0e3466c1.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 02:30:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMa7Q-00041Z-2x
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 02:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbXCAB3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 20:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932956AbXCAB3k
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 20:29:40 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:49185 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934AbXCAB3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 20:29:39 -0500
Received: by nf-out-0910.google.com with SMTP id o25so734968nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 17:29:38 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OwDCRVkls6PU7y1pTyBCyDm/Xyi6UTzNr6fGbfBXxqfNdQUPQCcQf+1MDDOnWvyyHpJ5ijwkSDteePGa2LyUBaeRyEUJZbfOo3kxwxTMpTZmotFMJ1yBqaxaQrENj4hMmtVVfPc4OYkE/k14xON3hwG+blJEOpJXU5iuRBM2Knw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l6Fs2PFUpM7VV9ek1t2dw1qPyt9OkLNRHR9BKtIqg4WGdVa+onf1k8FjD5nRIvqqnRtdGUdBCHtiyu/OhELcPNNCETtqguVj19IqAk3mcEYFdLOKWZtrVqxrYAi7H28LLhNeDPC8AtRnHf+LsTSx5iKo7V+6BJp6CUYvW/tciPM=
Received: by 10.48.210.16 with SMTP id i16mr4851988nfg.1172712578433;
        Wed, 28 Feb 2007 17:29:38 -0800 (PST)
Received: by 10.48.215.2 with HTTP; Wed, 28 Feb 2007 17:29:38 -0800 (PST)
In-Reply-To: <20070228123539.23809.qmail@d6daeb0e3466c1.315fe32.mid.smarden.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41030>

Ack. I though I had sent this same fix about a month ago as

"cvsexportcommit: do not delete .msg when performing manual commits"
461cc1944cf17210149c20bafa7dbbc467b2e89f

but it looks like I didn't. Shame on me.



martin
