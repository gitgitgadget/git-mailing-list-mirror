From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Tue, 27 Jul 2010 01:42:39 -0400
Message-ID: <AANLkTin+jUB85Zua7TP_dmdU9QSEiAuTDZhPQQ7hQTP-@mail.gmail.com>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org> <AANLkTimdYfv-Z57iHD+YLfjKi66av5xmaC3JEMRNRw+Y@mail.gmail.com> 
	<AANLkTin9kbMp5nOS=GaM2rX1w+y8vbzYfWunkSSeoPZg@mail.gmail.com> 
	<20100727053040.GA6014@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 07:43:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdcwW-00084o-Ng
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 07:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab0G0FnB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 01:43:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47826 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab0G0FnA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 01:43:00 -0400
Received: by wyf19 with SMTP id 19so2750176wyf.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 22:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PX/jUQ/ktVPrtGwO0tnbRu+WeQyvABcYHD1jn6fNUCs=;
        b=ZJ0EBhSqfYEmH1Qi/w/ptojLUsXWPDQ5M5julKtHXUg7uBLOSUKJdtdj7FtE/qEx/V
         kkmmzsZUs84wsq6/dQj7JmArg60DqDYkNfjfEXMie1pIluzpA+CKtvkxT1MyaRBYp/G2
         QSEeFWfI8dMz9XK5GULMdS3aixCWyAcPlIW04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xcdessY/fL/v1SMs17aMurkmET91w1vsV9FVcEx0BSI5kc8sPTXeywJ2JEY3N4cOmf
         sumCjOrCE4GoBJ4gOqMIWzZbxf2FutaoHKYCVuYEk+O9vir8+RqxGUioAfgTbvANQaOW
         SRInIm0mMoVOtcES6TdoywDSAFA6BHSNH1+iE=
Received: by 10.227.145.208 with SMTP id e16mr8317825wbv.164.1280209379247; 
	Mon, 26 Jul 2010 22:42:59 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Mon, 26 Jul 2010 22:42:39 -0700 (PDT)
In-Reply-To: <20100727053040.GA6014@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151912>

On Tue, Jul 27, 2010 at 1:30 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 23, 2010 at 02:16:45AM -0400, Avery Pennarun wrote:
>> Only this: Junio said that there are no major downsides to this chan=
ge
>> - and given the slow pace of change in gitk/git-gui, this is probabl=
y
>> true - but are there any *upsides*? =A0What problem does this solve?
>
> One minor complaint with the current setup is that browsing the histo=
ry
> with path limiting is unintuitive. You can't do "gitk gitk" in the
> gitk-git directory. You must instead do "cd .. && gitk -- gitk".

Arguably this would be an encouragement to fix the path limiting code,
in a similar way that people expect switching to a submodule setup to
encourage people to fix submodules :)

Have fun,

Avery
