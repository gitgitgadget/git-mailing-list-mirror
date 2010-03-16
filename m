From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Problem Pushing to Remote Repository
Date: Tue, 16 Mar 2010 12:57:01 +0800
Message-ID: <be6fef0d1003152157m241d3a59sca06a4ab13252ec7@mail.gmail.com>
References: <3f81a4241003151445v6b45d63bm63aeb0dfdd36fb6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Bryan Richardson <btricha@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 05:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrOqK-0006PO-7B
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 05:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab0CPE5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 00:57:07 -0400
Received: from mail-iw0-f176.google.com ([209.85.223.176]:57338 "EHLO
	mail-iw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab0CPE5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 00:57:04 -0400
Received: by iwn6 with SMTP id 6so635084iwn.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 21:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=MlCzk4hJ4Gr7H4wMt25IsosfmzS22k5nr8i+/9wOxJQ=;
        b=KgRYDjuhY9ORZbYJ6SMTq+fk3UkQtFAZBDKEUTNPDr+qmDp1iexTM3Zev54YBWOBCD
         pZsKle9pv4JmLMxrmWNzw47UfVshvZdZ/TK67Ff3Vr8qswQannYCWAd9riqg+rIiOyXU
         TdkIHxOp303H8tGFxwY3m+AsETApwfVyT3uOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=qGK8WkBTCHZWVm9zBJ1yKTYhFTfVVgMCtNH96YMeYk/70ntR5yoFvvPUqCN4VtRzdd
         ClxWx/VEZElV1fB2jx74Mqs1aOmOT8foMqwzSv35q4KLhF3zmtVgUQyO7tDpa1QQFdru
         RXmLUODMYap9QaMTv7lt6trhHsVV2148OKxTo=
Received: by 10.231.190.204 with SMTP id dj12mr28144ibb.9.1268715421785; Mon, 
	15 Mar 2010 21:57:01 -0700 (PDT)
In-Reply-To: <3f81a4241003151445v6b45d63bm63aeb0dfdd36fb6f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142299>

Hi,

On Tue, Mar 16, 2010 at 5:45 AM, Bryan Richardson <btricha@gmail.com> wrote:
> Hello All,
>
> I'm trying to push a Rails application to Heroku using git, and the
> push consistently stalls when writing objects (and always at 84%). Can
> anyone tell me what might be the cause of this? Is it on my end or the
> remote end? Could it be due to a slow network connection (which I'm
> unfortunately on right now)?

if this persists, you could look at git bundles. I believe heroku
provides ssh, so you should have scp/sftp. Bundle up the git objects,
scp the bundle to your heroku account, then unbundle it.

-- 
Cheers,
Ray Chuan
