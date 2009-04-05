From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [question] how can i verify whether a local branch is tracking a 
	remote branch?
Date: Sun, 5 Apr 2009 23:25:29 +0200
Message-ID: <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com>
	 <20090405144413.GC2076@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 23:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZrs-0002Ja-Fd
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 23:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbZDEVZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 17:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbZDEVZc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 17:25:32 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:32858 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZDEVZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 17:25:32 -0400
Received: by fxm2 with SMTP id 2so1642349fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ksJK0vcK2fwXHIfiZow9jmhmvTXU42QmwcxWriC2ZX8=;
        b=n9jLf99wVtl57c0EkTxatyZliTmCjLuNsJbqJRiASyw44YryRM764C5m/RfCY/BCw1
         ZMr3mt/Js2Ye8EeBQm0Gjc0A+51fmLXDO3XWJBl22sGtXR7n5RMe94WoiYmw83DzRl8W
         g6ez8mch9jECLqQwB8N7Ntcqama5UPz3NPgZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fCejFqR31ujJbVlIEjEKfd0FksQVbK1JRuUuHlRS6VIarOuAh4vKpiJ2EDDCcF4/UP
         7dUg4svrvzEcI2owj192kxZOy8ADOJMVDkBF1UL+kSGVIu/eFONCTTKh/q+Xifmjb58a
         1ey+8SbFnIneMDpjAbmceDfO4+wnZL70KTH5M=
Received: by 10.86.82.16 with SMTP id f16mr2556380fgb.32.1238966729228; Sun, 
	05 Apr 2009 14:25:29 -0700 (PDT)
In-Reply-To: <20090405144413.GC2076@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115713>

On 4/5/09, Jeff King <peff@peff.net> wrote:
> On Sun, Apr 05, 2009 at 12:32:29PM +0200, Paolo Ciarrocchi wrote:
>
>> is there a way to verify, using the UI, whether a local branch is
>> tracking a remote branch?
>
> Do you mean "whether it is tracking any branch", or "whether the branch
> is is tracking is remote"?

I mean whether it is tracking a branch and if it is I want to know
which branch is being tracked.

> If the former, then I think if one of branch.$branch.{merge,rebase}
> is set, it is tracking something. The tracked thing is remote unless
> branch.$branch.remote is ".".

An example:
$ git clone -n URL temp
$ cd temp
$ git branch -r
  origin/master
  origin/foo
  Origin/bar
$ git checkout --track -b foo origin/foo

Now, how can I know that foo is tracking origin/foo ?

Thanks.


Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
