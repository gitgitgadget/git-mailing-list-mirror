From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 8 Sep 2009 11:24:37 -0300
Message-ID: <a4c8a6d00909080724q1c792f6bs641ea9d000d08b5a@mail.gmail.com>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>
	 <81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com>
	 <vpqhbvekldk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 08 16:32:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml1jq-0003JP-2K
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 16:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbZIHObz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 10:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbZIHOby
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 10:31:54 -0400
Received: from mail-yx0-f194.google.com ([209.85.210.194]:61664 "EHLO
	mail-yx0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZIHOby convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 10:31:54 -0400
Received: by yxe32 with SMTP id 32so5905713yxe.23
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GJSJ5heupuvCGrdkcFUXNsJbfecXWyTBfIkFdiENxI0=;
        b=Wx63E0eW9gr4OaLbvp0olylRnpOztF2n/FLLxOclU++0WjAiIQW1gLn9JHTvGhVhGc
         wyDOgGdFE5+dY6fPznBoVMtUwzcy19hdDM/DJeX15acFSD63ai/w5KyBNDb2QsSE52w8
         4KW5XfGGZ1jqbvM+SbiL/hrOE9k0Xfvc1bF08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UFruik2EA7TOu41muww5j6reA5kJMEYn3mYyM6BPOzc3PkWmFyuRBftwkQUH2iR3MG
         4E3MOuTRiaNPpNs0jWmg04E70AX4ZSiXvNGf/MK+iH57c8V4kmV9outPWbye1TvTx0cx
         hdKqkxlpphUtXXM1mPRTXgBthDzjNJO1Z2auI=
Received: by 10.100.60.1 with SMTP id i1mr16985897ana.11.1252419877858; Tue, 
	08 Sep 2009 07:24:37 -0700 (PDT)
In-Reply-To: <vpqhbvekldk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128008>

On Tue, Sep 8, 2009 at 3:20 AM, Matthieu
Moy<Matthieu.Moy@grenoble-inp.fr> wrote:
> Your commit message doesn't say what's wrong with
>
> | Alternatively you can use autoconf generated ./configure script to
> | set up install paths (via config.mak.autogen), so you can write
> | instead
> |
> | =A0 =A0 =A0 =A0 $ make configure ;# as yourself
> | =A0 =A0 =A0 =A0 $ ./configure --prefix=3D/usr ;# as yourself
> | =A0 =A0 =A0 =A0 $ make all doc ;# as yourself
> | =A0 =A0 =A0 =A0 # make install install-doc install-html;# as root
>
> which is already in INSTALL a few lines after what your patch adds.

I tried to being more explicit about what the new users has to do. The
first instruction that the text says is: "Normaly you can just do
"make"".
But the new user, cloning git won't have a configure file, so he can't
just do "make".

And then, the text says: "so you can write instead". This brings me to
one alternative (not what I really should do), when in fact it should
be (I guess) the first instructions that new users need to follow.
