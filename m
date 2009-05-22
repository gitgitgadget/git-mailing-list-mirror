From: Tim Uckun <timuckun@gmail.com>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 17:44:48 +1200
Message-ID: <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>
	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 07:44:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7NYu-0004jl-JH
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 07:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbZEVFot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2009 01:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbZEVFos
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 01:44:48 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:22117 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbZEVFor convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2009 01:44:47 -0400
Received: by yx-out-2324.google.com with SMTP id 3so936064yxj.1
        for <git@vger.kernel.org>; Thu, 21 May 2009 22:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NQLNPZI/0VEbaMuC2QJyog6OGvqy9+2JPpYjtNDGND0=;
        b=UzJvw/tTinJ438ZWFo+PBCRbgwW0EmowRiLupcsZbCHQIU23UpMXuogRTSwck7h3FM
         sI87xrulMoZ0UfQe/6mfme7VYE+0jZlT6ArpuMRzLfvpTDTGpAGCccwqu/nKMlaooKX4
         r8Iz4Ik7Wru+Wcop/gLZ+y1jHK1uhoY2p64AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b3nBr+Pq1sobh+6vaQmQjoswDfLMkWb6NE7RDsGbDkgAJwkt6CUHyNA9Hi4L9aLQli
         twNc9IEgMYzZCtLBKYa02/b4Q8zc8Z8dOlr0Y1eIKRp79OD/7AVGLaWdleiQQdm6XJrK
         2+BSOaxOP3BW3I5CmrykkTDJYJV5xrIJCR76o=
Received: by 10.90.99.6 with SMTP id w6mr2856884agb.0.1242971088700; Thu, 21 
	May 2009 22:44:48 -0700 (PDT)
In-Reply-To: <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119712>

>> *********Try to rename a directory =C2=A0WTF?: Git thinks any direct=
ory with a
>> .git folder is empty and refuses to rename the directory.
>
> Well, why do other folders contain .git directories?

It just worked out that way.  I am experimenting with a rails app and
those plugins were pulled from github.

> =C2=A0Are they
> *separate* git repositories? =C2=A0If so, git doesn't know what to do=
 with
> them and leaves them alone. =C2=A0(Well, in fact it treats them as
> submodules.)


yes they are separate repositories. I would be happy if it left them
alone or treated them as submodules.  I was just puzzled as to why git
thought they were empty when they were clearly not.

> All your other weird problems seem to come from this, as far as I can
> tell. =C2=A0If not, it would be helpful if you could give *complete*
> reproduction steps for your problem.

Those were the complete steps. I did no other operations on the
directory.  So the fact that the test directory is misbehaving is
because a directory in the vendor hierarchy has a .git folder?

I'll have to clean up all those and see if the problem remains.
