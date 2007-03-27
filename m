From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git svn fetch spewing warnings
Date: Tue, 27 Mar 2007 12:17:46 -0700
Message-ID: <m23b3qts11.fsf@ziti.fhcrc.org>
References: <m28xdkvsxx.fsf@ziti.fhcrc.org>
	<20070327190004.GD16591@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:17:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWHB8-0007fE-O6
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 21:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934201AbXC0TR4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 15:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934203AbXC0TR4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 15:17:56 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:27500 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934201AbXC0TRy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 15:17:54 -0400
Received: by nz-out-0506.google.com with SMTP id s1so2516658nze
        for <git@vger.kernel.org>; Tue, 27 Mar 2007 12:17:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=QfH5WkdMM69PmeTlOqSQSCNWHCJ+usc244e8k6eFw+u7VD/xRG80k6OLrn4tDYikjoPu7LJ5yt1NAHI1CYHw/LY4fxOBpNZoTlGvQ0PK9N0aRRgw9jjmXTpjwWdgCU9RF2U7HkmFnamKmBLUW4govm6wy010TyurlRdPt2h1rII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=Viy+cpl0KigqCFB8nxKfcGCO2Q6D6uJq6xGynhUwS1049lMl3UaKkmTdn1Iz7PSIqfv/fUVwH2xiFwvUYGJylmBsGMs0eLLruorBgvdgdFqNrqWj9ZhAjNsnhOvzuLguSK4AkSk7VraeYEo1LtNg4Bbfl96H2mX/nYdOtPyk4aY=
Received: by 10.114.254.1 with SMTP id b1mr3294373wai.1175023072958;
        Tue, 27 Mar 2007 12:17:52 -0700 (PDT)
Received: from ziti.fhcrc.org ( [140.107.156.111])
        by mx.google.com with ESMTP id m26sm1264046pof.2007.03.27.12.17.52;
        Tue, 27 Mar 2007 12:17:52 -0700 (PDT)
In-Reply-To: <20070327190004.GD16591@localdomain> (Eric Wong's message of "Tue, 27 Mar 2007 12:00:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43297>

Eric Wong <normalperson@yhbt.net> writes:
> We now try harder to find previous versions of the path we're tracking.
> I've also changed the window from 1000 to 100 revisions, so the
> warning message spewing is 10 times more frequent.  Don't worry, though
> it's harmless :)

Not a big deal.  But perhaps those warnings could go to a log file of
some kind and then a summary at the end could say:

  There were 500 warning messages, check git-svn-fetch-TIMESTAMP.log
  for details.

And to push a bit further, why do I care about these messages.  What
action might I take based on them?  I almost didn't discover that the
warnings were harmless because I C-c'd out a few times thinking that
something was really wrong before deciding to just let it run.

+ seth

-- 
Seth Falcon
