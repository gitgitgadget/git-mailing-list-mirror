From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 19:04:48 -0400
Message-ID: <32541b130804231604r4c439fa5va5c01bfd53a22cc7@mail.gmail.com>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
	 <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com>
	 <20080422023918.GA5402@sigill.intra.peff.net>
	 <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com>
	 <20080423080826.GA11935@sigill.intra.peff.net>
	 <480F1671.2060602@viscovery.net>
	 <20080423110402.GA27437@sigill.intra.peff.net>
	 <480F218C.3060703@viscovery.net>
	 <20080423214745.GA30057@sigill.intra.peff.net>
	 <7vprsgqiq1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Peter Karlsson" <peter@softwolves.pp.se>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 01:06:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joo1x-0007iR-Oy
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 01:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbYDWXEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 19:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbYDWXEv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 19:04:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:44086 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbYDWXEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 19:04:50 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1141467nfb.21
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ohhg9Rp+gacuAsocNCO6oAOWjSU6H2zN8yf35BpAvUg=;
        b=TnahnHgSG4BrvJAxkD+mb8ZOrRWjEn0JV+efHTDJDVZHHG3Ju2Lg2RJpYwNTg6dbaNTCpF8nip10fKcpXXXWvpUjLXED22T4x+PQ3Q+CWYtZCYnn4Oe6gi7BucbjGC1lCYl1r3uhkvn0XXp+oQzw+rjj1tKdY/Atfn69HzpgmSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gdqiq95mLnVTSvLpMlhFBHaGlS59mLxjtttBhNbJxiixFxbxW5db46HqWXZNhIWyN4LV7b2SLNzCXd/zkVWA7+rQqa5XU3y8C/0hj9hhZq2Y8D/c87FwyO/1goBq3Mx85qQYNbTAhAh1sLxCcgtKtkz/BD6yfPC3fiSXVVFXnlY=
Received: by 10.82.148.7 with SMTP id v7mr1992061bud.1.1208991888566;
        Wed, 23 Apr 2008 16:04:48 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 23 Apr 2008 16:04:48 -0700 (PDT)
In-Reply-To: <7vprsgqiq1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80271>

On 4/23/08, Junio C Hamano <gitster@pobox.com> wrote:
> But once you start saying "even originally the same blob (i.e. identified
>  by one object name) can be rewritten into different result, depending on
>  where in the tree it appears", would it make sense to have blob filters to
>  begin with?
>
>  Shouldn't that kind of of context sensitive (in the space dimension -- you
>  can introduce the context sensitivity in the time dimension by saying
>  there may even be cases where you would want to filter differently
>  depending on the path and which commit the blob appears, which is even
>  worse) filtering be best left to the tree or index filter?

What I really want is the equivalent of "dos2unix --recursive *.c
*.txt etc" for all commits.

Theoretically, a .txt file might be renamed to a .jpg file, in which
case funny things would happen with such a filter, depending which
commit was seen first.

I'm pretty confident that this will never happen to me, but it's a
valid concern.

Have fun,

Avery
