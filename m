From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 00:17:49 +0100
Message-ID: <320075ff0807161617v4a4b323ep5c879745bee89759@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com>
	 <7vmykhr6h1.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com>
	 <7vabghr5br.fsf@gitster.siamese.dyndns.org>
	 <32541b130807161246l579d3a5em65496ee9119ef1ef@mail.gmail.com>
	 <7vr69tpoze.fsf@gitster.siamese.dyndns.org>
	 <20080716223205.GK2167@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 17 01:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJGGp-0007DW-J4
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 01:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759671AbYGPXRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 19:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756177AbYGPXRx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 19:17:53 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:3891 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759424AbYGPXRw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 19:17:52 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1891596yxm.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=daW9lLmR/SeFQuSVPWIJSIcdsHx/9dEHr5HodOmKffE=;
        b=v78sfTaB0NfkDmR4Dn0+8VAVP4R4KqKzqahrA96jB272jTaz5wepQ7suqJKwusIlNj
         mJiIY+N6tW0N2KHKNN4Q1p7m9vwMudy9AhrKfAmF0X5cmkp61cx1eKDTBC6ups2SYDV9
         WXtUlf5z4JzQeeU5IIF4S/Bh25Ym3wbl+L26M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=vgCBtJCB/xhda1P+GBAx9+Fx59gMoUNHtHduDwKYa2umTvVp0CHyktZ9ZcsKAf+rTy
         O0PwPzkw99kkpeXOSnyVOEFD9AGW738zicDvHrFM0Jty+okYYdph/r6drh98qMJ+6cLH
         ODHa/ojhvr5RgsPGxqxoeczs7Pvwl9UnvX7PQ=
Received: by 10.103.17.13 with SMTP id u13mr1319486mui.90.1216250270067;
        Wed, 16 Jul 2008 16:17:50 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Wed, 16 Jul 2008 16:17:49 -0700 (PDT)
In-Reply-To: <20080716223205.GK2167@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88780>

>
> In general, I find that people are more willing to listen to "we have
> a more powerful way of doing things", if you can first give them the
> equivalent of the "dumb and stupid" way that they are used to doing
> things so they can switch to the new tool right away without too much
> of a steep learning curve; they will then switch to the more
> advanced/powerful workflows at their own pace.  Other people may have
> other pedgogical techniques, but I find mine to work fairly well.
>

That totally mirrors my experience.

Unless you're teaching people totally new to SCM, they're likely to
have experience of something else, and are likely to ask 'but how do I
do xyz'. And sometimes the reply is rather embarrassing, as the new
and powerful way involves 5x as many commands. That's where it gets
the reputation of complexity (when actually it might be more correct
to be a reputation of verbosity).

I tend to actually avoid the commands (porcelain or plumbing) to begin
with, and actually concentrate on the data structures (commits, blobs,
index etc) - then how various people's repos look when you do
particular commands. That way people tend to relax about the many
commands as they can grok that there's probably lots of things you
need to do bit by bit, but that aren't relevant to understand right
now - this seems to help in abstracting away the complexity without
sweeping it under the carpet.

So I pretty much agree. Your set looks good, but I always do fetch and
merge before pull, and also add rebase at the end.
