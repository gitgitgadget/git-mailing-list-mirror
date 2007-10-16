From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Tue, 16 Oct 2007 16:07:58 +1000
Message-ID: <ee77f5c20710152307n48431a6eu5dc95ee504968e4e@mail.gmail.com>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
	 <471302D2.6010405@trolltech.com>
	 <ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
	 <200710150902.52653.johan@herland.net>
	 <7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
	 <ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
	 <0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com>
	 <85ve98gl57.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Geert Bosch" <bosch@adacore.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Junio Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:08:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihfbe-00011P-Uc
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbXJPGIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbXJPGIB
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:08:01 -0400
Received: from nz-out-0506.google.com ([64.233.162.232]:21075 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760993AbXJPGIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 02:08:00 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1128652nze
        for <git@vger.kernel.org>; Mon, 15 Oct 2007 23:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=TFfjLd7yjg8W9pjNuhfGCzpTh2bQgl5oZJF1JcmqK64=;
        b=cnkLKVWJaO913K6V7A982aseo/H43NlJthf9h9z9y+AETUjmyLEyzL8540wDDaVN5btP7yExT+9+JYXqPwRjwh3y/S81V9J61doP0x0WRCHic1hWtDOoHua7WLdQnWonBAgaNKKUdwuaRt1u6zE6+rtlV7vet95HhFSMshRdR+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EZ4Y5KE2r34XZSZtiowoBYGSqU8cWdq7aCsX50UKNUgV4fR0VqqLKQgKzOTPuqoBAGMwzECXFW2Jj0wfltYtb9rLj4nrXWlUWSBnQRJXKU4MJ5M426CmGLYWCpTw30ncFBq47rg9ub5ZF/lY015YjThH4ITl7NJ7Jz15C4M2tkY=
Received: by 10.141.180.5 with SMTP id h5mr3226515rvp.1192514878765;
        Mon, 15 Oct 2007 23:07:58 -0700 (PDT)
Received: by 10.141.153.4 with HTTP; Mon, 15 Oct 2007 23:07:58 -0700 (PDT)
In-Reply-To: <85ve98gl57.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61086>

On 16/10/2007, David Kastrup <dak@gnu.org> wrote:
> Geert Bosch <bosch@adacore.com> writes:
>
> > On Oct 15, 2007, at 13:53, David Symonds wrote:
> >> That's also why I suggested "skip"; you might not be able to test a
> >> particular commit, but you might also not *want* to test a particular
> >> commit for some reason.
> >
> > Skip seems a great choice: it directly expresses the wish to
> > not consider a certain commit. The reason is unimportant.
>
> But it is an _action_, while "good" and "bad" are properties.

"skipped", then. Either way, something like this has got to be much
better than "dunno".


Dave.
