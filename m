From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Fix sed syntax in t7502-commit for OSX
Date: Thu, 15 May 2008 11:37:32 +0200
Message-ID: <8aa486160805150237t734b24dcw4a153e41cbc7436e@mail.gmail.com>
References: <1210817948-72280-1-git-send-email-git-dev@marzelpan.de>
	 <7vwslwgdyi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Marcel Koeppen" <git-dev@marzelpan.de>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 11:39:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwZus-00016g-5k
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 11:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbYEOJhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 05:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbYEOJhg
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 05:37:36 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:38607 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbYEOJhf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 05:37:35 -0400
Received: by yw-out-2324.google.com with SMTP id 9so174944ywe.1
        for <git@vger.kernel.org>; Thu, 15 May 2008 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yXJHAhWKPJqko3ClGsGvhfXqZ8U2LIp4ghB0b+zMUik=;
        b=fzz29I+0y4PGnrHWOa/OF8JLS609clCn/2l/f5nSYmEbkCuAtauleZwd8tFsWCWH4WUkkdwnojaQnh2VhRTtdoVFeJVLCqlnnJdBK2If6rGS9Nt+Ka9PkBhfA0C/WuNZrfWv1UWRUVxOw7rA28uxpKYydXq0w0qStzeLX18ZqLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=elPnXbT/K+Gu/6bKPng51uZ2zCL+C8P+WguPmsnsFmHLCYB420NYjLAVT2O9Bz2FoeHaIsat8ZE8St/ITn49+zaDfxetjP1U6GblynOyxDipf7vmPg4cXv1APXjV7ijcykPq9ZC2ROEM2jVA6xbSBpOeluua8qapo4/WBibGibA=
Received: by 10.150.57.1 with SMTP id f1mr2039693yba.77.1210844252598;
        Thu, 15 May 2008 02:37:32 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Thu, 15 May 2008 02:37:32 -0700 (PDT)
In-Reply-To: <7vwslwgdyi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82194>

On Thu, May 15, 2008 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:

>
> But more importantly, as we are serious about portability, we should not
> be using "sed -i" which is not even in POSIX to begin with.

Is there a way (environment variable, flag) to test if it is POSIX? Or
we just have to know?

I'll send a patch to document the "sed -i" issue in
Documentation/CodingGuidelines.

>  Can we
> rewrite these places without using the in-place extension?

Yes, I'll do it soon if nobody beats me.

Santi
