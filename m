From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 18:10:21 -0400
Message-ID: <o2l32541b131005071510x492269dz84e9cc35bfa04942@mail.gmail.com>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> 
	<alpine.LFD.2.00.1005071007320.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071147460.901@i5.linux-foundation.org> 
	<alpine.LFD.2.00.1005071529050.14468@xanadu.home> <m2g32541b131005071236u962d2c73n85d25093d1e048bb@mail.gmail.com> 
	<alpine.LFD.2.00.1005071626040.14468@xanadu.home> <n2l32541b131005071400uf90ab0e8se882fce6b3abf522@mail.gmail.com> 
	<alpine.LFD.2.00.1005071708090.14468@xanadu.home> <x2j32541b131005071426tb875cc1dtcc26e86d868d2e8b@mail.gmail.com> 
	<4BE48F84.3050200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Sat May 08 00:10:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAVkt-0003kS-J9
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 00:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858Ab0EGWKn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 18:10:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32846 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0EGWKm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 18:10:42 -0400
Received: by gyg13 with SMTP id 13so930679gyg.19
        for <git@vger.kernel.org>; Fri, 07 May 2010 15:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=o6IgId48ajwhxr1fkrokHHnqjy5sXPhChSLzPtoYOAc=;
        b=ErBDyveqYu0P0mfGc9JfCLVhaPN2FzGKZhGNLAq7jx/b2zIY9dwUFwW7HBueGZhccf
         suZlgsDXsVd/TEp9wPLRYQWHbzZtJoTfalf60bxbaSLXLWXxITdW3+bOr43ecqh6D77i
         haLlE+v3v0vztjPq7dbUSCK+3l3XXJafIVASs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NvLag2xEv69K4d3DA9+fDCqIya+ZLVE2iSlqA8hH/t864ExRmU5mkU8noo0qLBO7Ei
         pKxMKWjrE8brgtBZMSpTApbNsluy2UBtj0RKmedNtqO4xHAoA+TlpzKZ8pm0TtgGnPbS
         BXeiSf1M7n7UWZ1IhQNyh/J9yHyJLYnBSuIFk=
Received: by 10.150.213.15 with SMTP id l15mr3993149ybg.202.1273270241153; 
	Fri, 07 May 2010 15:10:41 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Fri, 7 May 2010 15:10:21 -0700 (PDT)
In-Reply-To: <4BE48F84.3050200@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146609>

On Fri, May 7, 2010 at 6:09 PM, A Large Angry SCM <gitzilla@gmail.com> =
wrote:
> Avery Pennarun wrote:
>> =A0 =A0cp .gitconfig .git/config
>>
>> Perfectly valid. =A0Copying the other way might (or might not) resul=
t in
>> invalid options in .gitconfig, which probably ought to be warned
>> about. =A0But the syntax is obviously identical.
>
> Which one takes precedence? I *MUST* be able to override a distribute=
d
> .gitconfig/.gitparams/.gitparameters file.

Yes, absolutely.  As Linus said, the in-project file is lower priority
than your .git/config and ~/.gitconfig files.

Avery
