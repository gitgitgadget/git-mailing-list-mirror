From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/5] General configuration portability (Resend)
Date: Fri, 12 Mar 2010 08:22:48 +0100
Message-ID: <fabb9a1e1003112322l73cd8f93wffb1829f7988c22a@mail.gmail.com>
References: <20100311162750.GA7877@thor.il.thewrittenword.com> 
	<1268326882-sup-9149@pinkfloyd.chass.utoronto.ca> <20100312062308.GI7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 08:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpzDQ-0000HZ-MY
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 08:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab0CLHXN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 02:23:13 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45060 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595Ab0CLHXM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 02:23:12 -0500
Received: by pwi1 with SMTP id 1so526594pwi.19
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 23:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/1BdfYqkiIG70tp23yjb2EAnCR9anjIzONpxR769V/Q=;
        b=NRXNPK0fp5IbAhfoYBvuO5aQaDhw8XSdT9kFRIkOSSgNxEWns5a50V2WA2HzDD3kDP
         /H5eb8RcA2cH3EwOfvBzBMo3rxIiBJp+fQ+GiWt8Ee+FkyPYhqVF1ufYr5w0W3Qk8q/P
         XiCYnJN1As2xUmGutWLJYfseATOHndBnPaw+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YFLPKwBZSlp6IKnU1omV2VxHrj+DVeJF4XAum2eMjmreD4KOHMDCgFBYppq0wQ+rnZ
         CHzd28uFgawoZTZ7ODKrOgEI35pMj5S9cnqxA1xHFnYSFSKKibW/wPcmtKbbuR6LCQkI
         Oa10MjZxDJsMb4fT0lxVD3+WgS0YFxCazgMuE=
Received: by 10.142.152.17 with SMTP id z17mr2190040wfd.45.1268378588245; Thu, 
	11 Mar 2010 23:23:08 -0800 (PST)
In-Reply-To: <20100312062308.GI7877@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142028>

Heya,

On Fri, Mar 12, 2010 at 07:23, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:
> My employer kindly agreed to donate a little of my paid time to push
> the git patches we require to build on our supported hosts back
> upstream. =A0There is certainly some good stuff in here that is usefu=
l
> outside of our environment, but I have another 1600 packages to port
> too...

While understandable, I hope your employer also understands that just
dumping a large patch upstream and tell them "have fun with it" does
not a good open source contribution make? Consider the time balance:
the investment required for us to figure out whether this patch is any
good for git, (not being familiar with the changes you're introducing,
and probably unable to test them since we lack the setup), and the
time it will cost you to split up the patches into an easily
reviewable series. I hope you (and your employer?) will agree that
it'd be less time for you to do so, than for us :).

Of course, if your employer is more like "pointy-haired boss" there's
not much you can do either.

--=20
Cheers,

Sverre Rabbelier
