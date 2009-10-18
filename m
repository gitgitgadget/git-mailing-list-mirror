From: alexandrul <alexandrul.ct@gmail.com>
Subject: Re: Creating something like increasing revision numbers
Date: Sun, 18 Oct 2009 18:29:22 +0300
Message-ID: <4ADB3452.6030508@gmail.com>
References: <20091018144158.GA9789@gandalf.dynalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Sun Oct 18 17:29:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzXhX-0005d5-I6
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 17:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbZJRP3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 11:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754627AbZJRP33
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 11:29:29 -0400
Received: from mail-px0-f171.google.com ([209.85.216.171]:48635 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbZJRP33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 11:29:29 -0400
Received: by pxi1 with SMTP id 1so649785pxi.33
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GoC1aFQKWLGNiqk8ZLEmiH0P/TAl1A89bLGndMAqxz0=;
        b=mPLnlx9JKmlBcz27wrg14V185/mdDcTJtmu9RSWpDcz7hdNyY9KPsSHYwhrMUJu/Vx
         u627ZEaHI8CnoXBTmdct5198hi+RLX95yPjvNfNS2fGK0TTeEaJP8akjSVrpsr7YyBV6
         +E0Js5v543DlmGPDFOtXCkB2jh2ggdOG0/zFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nyR414i0Umf/i5qi8X70U+HKfQ84eEXJhWsh0uCMuzFPzUAP354Fdi294K3pqub4pE
         9XANVEhS4NAvOCUKysmUIxK0SmoCmPWYOsnclwEC6ghlVSYU9+fxNRSQ+7Zv/FxlY+Sx
         MSLR9IsWZQd9TX785qMA6ezw0FCz2WLFmYD+A=
Received: by 10.114.10.4 with SMTP id 4mr3952472waj.105.1255879773620;
        Sun, 18 Oct 2009 08:29:33 -0700 (PDT)
Received: from ?192.168.2.8? ([89.136.114.133])
        by mx.google.com with ESMTPS id 22sm1118862pxi.2.2009.10.18.08.29.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 18 Oct 2009 08:29:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091018144158.GA9789@gandalf.dynalias.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130598>

Norbert Preining wrote:
> My idea is that git - like subversion - could (if asked to) count each
> commit (global to the repository, irrelevant of the branch) and give it
> a version number. Since we all will use a bare repository on a server
> and pull/push from/to there, I think that something similar could be possible.

I was thinking to set a post-commit hook that reads the current version
from a file, increment and save it, and also set a tag with that value.

Being a DVCS, this kind of versioning can only be trusted on a single repo,
but if you set it on the "main" repo, it should work.

The only drawback could be the ever growing number of tags,
I don't know how it will work with thousands of tags or more.

Have a nice day,
  A.
