From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 12:52:20 +0100
Message-ID: <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
	 <496EE74F.6000205@viscovery.net>
	 <200901151101.53441.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <j.sixt@viscovery.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>, gitster@pobox.com
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 12:53:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNQnD-00082A-3y
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 12:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753357AbZAOLwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 06:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753331AbZAOLwW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 06:52:22 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:36592 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317AbZAOLwV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 06:52:21 -0500
Received: by yx-out-2324.google.com with SMTP id 8so433453yxm.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=rZQdO2FY6zI5ZacpVfsQqIEH5Z2Mt8WHg87ETTNkZdA=;
        b=C3mwG0peGIOJCY9xp+V8d21x6clyIuPHvhhZ863AKPS0jMyJM6M1jaw9A2Ad6d0dWS
         XiB7Mg+5I4ckxy71AAUiU0mdUw1CR49tV7WoDczbYb7BjlauXeGJ8PXEH8EvTYW5f0CZ
         jZ+0kbmryGKw78te4arkYW61hGu5FLAcQUuYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=UkUoCfKrPvbH3iuR0vxZhnFNRQfOmcCS3RRzMp5LzypgfCeA7Ni7UyyiH73hHhxMEw
         t0S10C4555D5qovprQDgqFD6+qy2aqlTDrJxWzoMk3KcSqrDAY5KfkK2Y5yGitgrqwlD
         AqGJRPLEZV2DMcrH7nL0reP5Xt62iPBFE3XLs=
Received: by 10.150.157.19 with SMTP id f19mr3825211ybe.239.1232020340551;
        Thu, 15 Jan 2009 03:52:20 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Thu, 15 Jan 2009 03:52:20 -0800 (PST)
In-Reply-To: <200901151101.53441.johan@herland.net>
Content-Disposition: inline
X-Google-Sender-Auth: afc59f4d0bad4049
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105781>

On Thu, Jan 15, 2009 at 11:01, Johan Herland <johan@herland.net> wrote:
> "modify" does the "git reset --soft HEAD^" (Anders' suggestion)
> "amend" requires a "git commit --amend" (current behaviour)

Why have amend do the same as edit? If you add an 'amend' one instead
make it drop you into an editor to change the commit message. That's a
workflow I often use. Often times I do not have a proper commit
message when I commit (sometimes it is the result of "git commit -a -m
"tmp"). To me having an 'amend' command that allows one to edit the
commit message would make sense a lot :).

> "edit" == "amend", but is deprecated and goes away in the future

And as such, have edit do what it currently does.

-- 
Cheers,

Sverre Rabbelier
