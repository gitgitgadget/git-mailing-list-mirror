From: "Donuvi Tanoga" <donuvitanoga@gmail.com>
Subject: Re: fatal: Entry 'xxx' not uptodate. Cannot merge.
Date: Mon, 11 Feb 2008 12:44:51 +0200
Message-ID: <30929dfe0802110244x2912cecfp2f4c4c91236227fe@mail.gmail.com>
References: <30929dfe0802102248p1f1cca44q4cec26a3237a3f20@mail.gmail.com>
	 <vpqwspbyerx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 11:46:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOWAm-0004Eo-W7
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 11:46:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbYBKKoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 05:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbYBKKox
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 05:44:53 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:35326 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbYBKKow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 05:44:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2095229wah.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 02:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tkN9LLwS6nu9Ku/t6uWa7BrBNQlHjfCr3ncT3uulvOQ=;
        b=vzL80VWEU4tBBHy6KjFJz3LEdozfw9iWopbwfq4yPj6K7ae/gc0POniv+avpnSPzxHfV+XPr1TDcfj3KXDeidqjmWM/EbaukZyIEs/h5ToVuhmoLdOBB7HmZdW81tmDhGwpeqFUf/zq5pYOK8n/DWcUPm6eRkEVDZzN+91m8lLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=klfuO0/TEMJ88nXXlhkMwZszbhkoBlgU8Pqw9sFORxobS7mTEaMMwaP4KmhZ8IvZzjb8ibju9tYo/BjiJ48GVhS7+vSX0A2goC6ycV3QqbfSmuV6HR1mtNVsb1ZZOk8bRMigSFSNKce6e67lTIyUbo2XS/1q+wJo2c4bYljFrkc=
Received: by 10.114.76.1 with SMTP id y1mr9517142waa.38.1202726691800;
        Mon, 11 Feb 2008 02:44:51 -0800 (PST)
Received: by 10.114.102.16 with HTTP; Mon, 11 Feb 2008 02:44:51 -0800 (PST)
In-Reply-To: <vpqwspbyerx.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73511>

Thank you Matthieu.

On Feb 11, 2008 12:21 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>
> "Donuvi Tanoga" <donuvitanoga@gmail.com> writes:
>
> > Hi Everyone,
> >
> > I have a problem I don't know how to solve.
> >
> > When I do git pull (on linus' tree), I get the following:
> >
> > Updating 9b73e76..19af355
> > fs/binfmt_elf.c: needs update
> > fatal: Entry 'fs/binfmt_elf.c' not uptodate. Cannot merge.
> >
> > This is 100% my fault, and not a bug (I probably
> > accidentally changed it or something).
> >
> > Can you please help me to fix it ?
>
> Run "git status", it will point you to the modifications you did in a
> slightly more user-friendly format.
>
> Git doesn't allow a merge if you have uncommited changes, either your
> changes are irrelevant and you want to "git reset --hard", or they
> are, and you want to commit (and perhaps use "rebase"), or stash them.
>
> --
> Matthieu
>
