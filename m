From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Tue, 13 Nov 2007 00:35:01 +0800
Message-ID: <46dff0320711120835h31166370k64e9c92e9cf3432c@mail.gmail.com>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
	 <4738784F.7010106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcFu-0004Ud-Ks
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbXKLQfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbXKLQfG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:35:06 -0500
Received: from py-out-1112.google.com ([64.233.166.178]:54999 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144AbXKLQfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:35:03 -0500
Received: by py-out-1112.google.com with SMTP id u77so1329661pyb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 08:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=kS8EnFhu/1Daw4b/R/paAXpMO29ODdSSbc8Hat3pwmk=;
        b=Gqk81arugQ3lBwhh+XQkpUp9JSKbGvEgXTOp4CwV5qYTcomr5TW3PREqTHQ9hQOld0vJ0BNpFzhR6a8+SJnz3rWz9QGZhL+PNll6tmuuM3BcRxthSO4/dzcbIKAFwX4AJmwk1byy2cfFy0/qaOCugFLz+5UrEA1op7DIk5iIVhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iC1Y4aKnCKwSMDy/gnCGDrBcmSUXuSC3PCpZBZPhizZCMVRKC7iaEm27T208qoOtajnz2bP3JIhmrGpfEDySZ75BqNLhgJCEnSil4Q0qY6D/v2yxyllSDGyvBcfaUDMNZOMgbCwFqn6J+eZc65v/I3k1vvtLbcTghXbsGbHNpAQ=
Received: by 10.35.86.19 with SMTP id o19mr6302171pyl.1194885301611;
        Mon, 12 Nov 2007 08:35:01 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 12 Nov 2007 08:35:01 -0800 (PST)
In-Reply-To: <4738784F.7010106@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64654>

On Nov 12, 2007 11:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:

> But at this time git-commit is about to be made a builtin, and since your
> implementation contains a lot of non-portable constructs ($'', >&) and a new
> dependency on awk (and, hence, has little chances of being accepted), I
> suggest that you stay tuned, and implement this in the forth-coming
> builtin-commit.c.
Implement this in shell scripts is just a piece of cake, but not so
easy in builtin-commit.c. Not to mention that i'm unamiliar with git c
code. $', >& portable problem can be easily corrected. However, awk is
a new dependency? I have seen it in git-mergetool.sh
>
> > A configuration variable 'submodule.status' is used to turn this summary
> > behaviour on or off (default off). Also --submodule and --no-submodule options
> > are added.
>
> There is already 'status.color', I suggest the configuration to become
> 'status.submoduleSummary'.
There is 'status.color', but 'color.status' is prefered as said in the
documentation. So i follows this rule, name the variable submodule.*
just as the ones for git-submodule. I think it's a good idea to put
all submodule related configuration variables in the submodule.*
namespaces.

>
> -- Hannes
>
>



-- 
Ping Yin
