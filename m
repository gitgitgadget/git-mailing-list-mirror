From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How can I force git to recognize a change change in file modes?
Date: Sat, 28 Feb 2009 08:24:43 -0800
Message-ID: <e38bce640902280824x3ae41d95qab1f1a450235e096@mail.gmail.com>
References: <e38bce640902271717s46cf47f9i7c6bf5aac0d5f273@mail.gmail.com>
	 <20090228045531.14399ebf@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Feb 28 17:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdS13-0000Cn-Ui
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 17:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbZB1QYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 11:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbZB1QYr
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 11:24:47 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:48026 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbZB1QYq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 11:24:46 -0500
Received: by gxk22 with SMTP id 22so3613680gxk.13
        for <git@vger.kernel.org>; Sat, 28 Feb 2009 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8wmBP0U11VbW8V+GLeDX1aVYVPIQCFcYz8711zvAnnY=;
        b=SgLymy2E9xivDpmbbrA1DHWGr5hNEEVy2f8Q2G9rdAFWjW5Zl0pcPEldAcoylrhZjK
         3RQybEJo+V9mpHzyfABsnrUsw5hoS8S2BQoi4ZU1DHXOVgrFX6eQ/iAQaGGT37VqDM4F
         dNysK0Nq5jjh/62+2uKNYYCmo2OdQZIAMA/xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MBh4utx4VOlk+tKd9G0vkC+Ve+zHke3AkXEbYCRtbJ0ELBMbUCTdjRLLtQDWNeu3zi
         W9p8bCLQtZlwZ+uZ6GaSb7NvL8+/t6Z//jWLsKnf/4Y59qYKGuRnDTwIaX23o36dcY8x
         27YcGFc7h9rDoC6SKqeFQoDO8uX5nCTSLUBr4=
Received: by 10.90.52.1 with SMTP id z1mr1866269agz.61.1235838284031; Sat, 28 
	Feb 2009 08:24:44 -0800 (PST)
In-Reply-To: <20090228045531.14399ebf@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111771>

> git doesn't track permissions quite that closely; all it remembers is
> whether the file should be executable or not.

Thanks Jan.  Was this choice made due to the conditional coding
required to track the permission bits content between *NIX and
non-*NIX platform(s)?

bg
