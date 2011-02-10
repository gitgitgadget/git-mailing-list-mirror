From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Adding default remotes to a bare repository
Date: Thu, 10 Feb 2011 22:24:20 +0100
Message-ID: <AANLkTimg0YZ7eQ=hsxqSYJPipahLpiqZqSVkFz25=A2k@mail.gmail.com>
References: <AANLkTikVtSFs+qRiWJwxre8urOJs7q2HXBGPZkiTmn=i@mail.gmail.com>
	<4D5437C4.6000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 22:24:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pne02-0007EN-84
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 22:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab1BJVYV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 16:24:21 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47566 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab1BJVYU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Feb 2011 16:24:20 -0500
Received: by pwj3 with SMTP id 3so431392pwj.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 13:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gx7Fn573ZStcNmMZZEDUNlh6GGMSbfSuN2Ak9ein7BE=;
        b=Ii1AnPyhn4q7vI3jV1kZgS+rY7avjtEXb4kMX/cA6qYzG3rEKrjk1IA59JqDSDFq4c
         g374glI2GZFxrd43eAc7pGMkJuqLQ6GOEaKfis/ZILKoMwkXefhqFGoU504wY/EDpiAj
         pGWEmLdjdZeCD3VnEtIcf6UHCZ2K3gl+k6/tU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f+a9BNQlHSUGLSWob3CxMjmOW9BOe2nYuPENz3rYHe3Ux9O62Kw1xXBA+nbirfnMF3
         RPfPTOWY5pzC6JiK2qLPRSefZzeKNCzvnJyxmehxmEUFV1aZLlyheS671eps8Z8RWjPj
         vvIxX19UQppnLZOe3Fai9p4T1ZoJW+N4VlIuU=
Received: by 10.142.223.8 with SMTP id v8mr825720wfg.182.1297373060290; Thu,
 10 Feb 2011 13:24:20 -0800 (PST)
Received: by 10.142.44.3 with HTTP; Thu, 10 Feb 2011 13:24:20 -0800 (PST)
In-Reply-To: <4D5437C4.6000401@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166501>

On Thu, Feb 10, 2011 at 8:08 PM, Neal Kreitzinger
<nkreitzinger@gmail.com> wrote:
>
> You could write a script that does the clone and then adds the remote=
s. =A0We
> have a "menu" written in bash scripts and it does the clones and adds=
 the
> default remotes automatically. =A0So instead of just doing "git clone=
", people
> would run that script to do the clone and add the remotes.
>

Sure.

But I'm wondering why cloning operation can't import the remote
branches of the cloned repository.

Actually I'm wondering the same thing for hooks. If a repository setup
some hooks, can't these hooks be installed by default in the new
repositories ?

--=20
=46rancis
