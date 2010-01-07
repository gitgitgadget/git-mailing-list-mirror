From: Eugene Sajine <euguess@gmail.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
	commits?
Date: Thu, 7 Jan 2010 18:50:10 -0500
Message-ID: <76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
	 <201001071813.01187.trast@student.ethz.ch>
	 <76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eugene Sajine <euguess@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 00:50:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT27P-0002Hk-76
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 00:50:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab0AGXuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 18:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235Ab0AGXuN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 18:50:13 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:53132 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab0AGXuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 18:50:12 -0500
Received: by iwn32 with SMTP id 32so2731534iwn.33
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 15:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=kQAysl0mxDQaQuAPMJ6YjN5AZmek6qhQlbgqK5HRG7Y=;
        b=tC0zSPBlbZ+FH4JsqB7Q7lNaA5JkHIHovrVMtz0tvfKtmENMAzDMlelNqMwNdEXorT
         EkygVEP0fIDkNneTqh0IykcDEinkFDRbzvgUytJtUHCb7EY4xvdG8PnAYxjUmJZwdVMT
         cMAM8tXsDq2GHrrAO2OrencWFh6fhjKwg4HYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xycbAOh3zJUQTMyTW/930qorr7wbmIVbKOfjlGeZE8+CRsFVheOCcNgeWdbX6tvWgR
         cbVnLM1udieP8gD7hRPMrwLHZnuXxidisJ3iNLKQCFe36LDmY0wDiQCMumESpeYQJVC1
         HXxLdPYYnxJ07ddVEYbO5ExbqrSqbnvuTOmBk=
Received: by 10.231.157.131 with SMTP id b3mr367960ibx.19.1262908210458; Thu, 
	07 Jan 2010 15:50:10 -0800 (PST)
In-Reply-To: <76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136401>

>
> Yep. That's what i though it is. I.e. origin/branchname will point
> always to the last pushed commit only. Isn't it a bit strange that git
> fetch doesn't update origin/qa?
>
> Probably the problem is that whenever I'm pulling or pushing to remote
> repo i expect the last updated state of particular remote branch to be
> reflected in origin/branchname, but IMHO it is correct expectation...
>
> What do you think?

let me correct my self a little bit:

$ git pull origin branchname

and

$git fetch origin branchname

are both causing the output like this:

>From git://....
* branch      branchname    -> FETCH_HEAD
...

but "git fetch" says:

>From git://....
* branch      branchname    -> origin/branchname

Is this inconsistent behavior necessary by design?

Thanks,
Eugene
