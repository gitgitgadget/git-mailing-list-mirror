From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 18:04:36 -0400
Message-ID: <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com> 
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com> 
	<vpqsk6omppf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 22 00:05:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4i2a-0006XB-7F
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 00:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861Ab0DUWE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 18:04:59 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:53770 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0DUWE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 18:04:57 -0400
Received: by wwb24 with SMTP id 24so4405005wwb.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=jgXVwebbn2XaDRgt9/lYBcWiGl4KJqRqBQ2yxBbJSrM=;
        b=FSkY1lgofmait71RDk/roDKiWnj6ohIlywYFi7lTzVXKLxmDoOOI2xm59Sxosy5IgY
         G9G4bXyEdP8nK+mU7nUT3ZD4yBtU+bNvL9/mz2YzdzEOAJOdg4cH7cqQwT48hOHqII7f
         E6VpKl2IwX0xV2s0nAtsAfLXvz1Ao2sQdI9X4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XXeysYMa5A1iaO1TsAIj5OX/P5jxk0oY/qgEu6CvgGwa56ZC1cRZQ41aAeCm86NnKa
         GIRQA1a3KdLd0UWfC86EMQsF8xEa46ZmDEeFBc0lr0D4y+CkQWFk98NNMOcZr8WXyC4r
         dorlWoO211l6wVtBHbDTQr58GuJN63yX/Hueo=
Received: by 10.216.157.212 with HTTP; Wed, 21 Apr 2010 15:04:36 -0700 (PDT)
In-Reply-To: <vpqsk6omppf.fsf@bauges.imag.fr>
Received: by 10.216.158.3 with SMTP id p3mr3469375wek.9.1271887496268; Wed, 21 
	Apr 2010 15:04:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145469>

>
>>> When you do this you're telling git "I want a new branch from where I
>>> am right now". If you want to be able to pull in a similar way to how
>>> master works, use the '--track' option.
>>
>> Actually, the '--track' option is exactly what I don't want ! :) It
>> tells me:
>
> Read the doc. It is what you want, but you mis-use it.

I will read the doc, thank you for the advice.

'When creating a new branch, set up configuration to mark the start-point
branch as "upstream" from the new branch.'

So no, that's not what I want.

Using :
  git branch test
  git checkout test
  git pull origin HEAD

Is what I want and it works. BUT, I used to need only 'git pull'

Again, the behavior changed since I last used this. No one cares?

  -- aghiles
