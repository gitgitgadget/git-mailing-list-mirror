From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Improve documentation for git-remote-helpers
Date: Mon, 22 Mar 2010 08:34:07 +0530
Message-ID: <f3271551003212004r4ac7db34vad5b23f5d930476d@mail.gmail.com>
References: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com> 
	<f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com> 
	<alpine.LNX.2.00.1003211907390.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 04:04:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtXwR-0002Pr-BB
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 04:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab0CVDEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 23:04:30 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:34823 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799Ab0CVDE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 23:04:29 -0400
Received: by yxe12 with SMTP id 12so1581419yxe.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 20:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=LkNk+GIG5HLAdGofAh0D+Hpqdm8nx3OPzQZ7XbZxULU=;
        b=F28b7Jr1smOa/69Nn6uQGJnXVJB+bb2Mk8dEUYxpASvtJ7JUGAETerplhGDCaR7hXV
         3KIy5KSYakBWAozw4d5keg3t7a4KHEWciz0W+JQcaQntD+20LnCI1oztEsfcLO0vb46h
         3E/27UMzovm3Gq0j4RadfCdW6QbGLnQc4bcFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LoW7Rd9lFZDs9JoJPHMH5Gx4ptZM3eCq7oNSDPqcKcSzvnrHs73wOk/YV/m24eSoBf
         H2E1T2+r/7rM/5xbYxQOanutomx/h0yt9t5tC1nDrSRp5bzVVMga+X8CSEkj43ArjIeK
         bJ103+VIny3iDyOXVAYSZESl7ehOSteJ3JVlY=
Received: by 10.91.21.31 with SMTP id y31mr3540716agi.50.1269227067500; Sun, 
	21 Mar 2010 20:04:27 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1003211907390.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142888>

> I'd like to start by saying that it's good to see patches early, and also
> that I think the best documentation comes from people who are new to
> something going back and forth with people who know it too well to know
> what needs to be said about it.

Thanks :) I just posted a second revision of the patch incorporating
your suggestions.

> Yup. Or maybe these should be documented as a list of capabilities which
> mean that the helper supports the command with the same name, since that's
> a common pattern, and documenting it as a pattern makes it obvious that,
> if we have a new 'export' command, and it needs a capability, it'll fit
> the pattern.

Every capability doesn't necessarily have a corresponding command with
the same name, and vice-versa (see refspec spec?). Besides, I think
it's necessary for the manpage to have a list of capabilities listed
in one place. I'll think about a better format when we get more
capabilities/ commands.

-- Ram
