From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: Cannot fetch whole history from Perforce
Date: Tue, 8 Mar 2011 21:36:31 +0100
Message-ID: <AANLkTin6BBD+b2OYRk32GyAaEqFa-V7T1B7jEVujRkuL@mail.gmail.com>
References: <AANLkTik6fxHUJbp6dWdAgV-wr=P=FxK1K-vGAGy8ruBd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>, pw@padd.com
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 21:36:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px3e2-0002z3-CU
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 21:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756601Ab1CHUgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 15:36:33 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:47895 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab1CHUgc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 15:36:32 -0500
Received: by qyk7 with SMTP id 7so3231110qyk.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 12:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=B/MhqEjWGSs5PTPKAMAlMR0cQuFqEBoYhNh7XeMTYVk=;
        b=MN+dizvBweMvlYwMRWBbmwBykiJa1+iOX6mWobWrJMadRLDk+tc7nFeRIU9F3migfn
         o4rsLfje+SQIDyL2UNbg5u39CVpq2ZhdjBIwSeiC13NtNo1zNTM5lYpyzrSDShtP8kBj
         7WJuK4lU587PdPJq7sJKLf6N9pQdY/AbJSFiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ftHb3tOgbLj6ILcbzSO074yb4+7YS5+JbLnhFRhHOPOHIurVhNROPszr4SBDt9YAZL
         HdAn1O7Bf3LxHopGCPcFKdcYMTSqzEpeX+Tp2PlH4YlDECf3d8Z6y67iDCM7WmVna4mY
         BLiWuFETRougkI9Usg7ApgUaGJvX3L1dv+8Ic=
Received: by 10.229.65.71 with SMTP id h7mr1442191qci.229.1299616591917; Tue,
 08 Mar 2011 12:36:31 -0800 (PST)
Received: by 10.229.218.200 with HTTP; Tue, 8 Mar 2011 12:36:31 -0800 (PST)
In-Reply-To: <AANLkTik6fxHUJbp6dWdAgV-wr=P=FxK1K-vGAGy8ruBd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168687>

Hi,

On Tue, Mar 8, 2011 at 7:09 PM, Anatol Pomozov <anatol.pomozov@gmail.com> wrote:
> Hi, I am using HEAD version of the git and I have an issue with git-p4
> tool (p4 to git importer).
>
> git-p4 works fine when I import HEAD version of my project
>
> $ git p4 clone //depot/foo/bar --verbose
> But it fails with a cryptic error when I try to import @all revisions:
[...]
>
> $ git p4 clone //depot/foo/bar@all --verbose
> Importing from //depot/foo/bar@all into bar
[...]
>
> Can it be related to Pete's changes?
> http://permalink.gmane.org/gmane.comp.version-control.git/167281

Sorry for not testing myself before responding, but in my experience
with Perforce a trailing slash may be significant. Did you try this
format?
$ git p4 clone //depot/foo/bar/@all
If that also fails you may be onto something.

- Thomas
