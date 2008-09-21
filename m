From: "Sean Davis" <sdavis2@mail.nih.gov>
Subject: Re: Problems with git over http
Date: Sun, 21 Sep 2008 16:51:21 -0400
Message-ID: <264855a00809211351j1392ad97xf2cd98944014edc@mail.gmail.com>
References: <264855a00809201013h6003abbfr9bbdd20c92e9201d@mail.gmail.com>
	 <vpqskrto48n.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Sep 21 22:52:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhVv1-0001HV-3o
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbYIUUvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbYIUUvX
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:51:23 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:33029 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbYIUUvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:51:22 -0400
Received: by gxk9 with SMTP id 9so2365857gxk.13
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=rACqQO3eqeb5tGjDSktgF3pI88Ad+5Lhk2cQYbzpdFM=;
        b=Pj7wkIFVFAcZTE/VmPFPWC4pSqi072WtzI9kq9Vzj1XaFwN5OavXRGrLA7eJHi9EWF
         WDkPuNmPFG0kUjcGsCHGsfgc53rHPpGZjfMcgiGSdQKTaWDRjpF3SlE4GvfN4PxPEVCU
         NuLD/ePdrgwkyjcJB3On86LQgOmizWH/e191o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=AwY5KuN0ffuoQ7XUFVBCKt3YbX7+t2F8VaHyth0vuxiqszjWU9+LIRESlh33WKrC2e
         39uKTAytaqft1imjAb4beCetaZ2VfpvVEzUIRSfYeENddqff6DaXgITCXpAPmFanGzcZ
         7xNA9IKDnW1KLHTaQ5BSnnT2avGrnOhnUmIU0=
Received: by 10.100.140.10 with SMTP id n10mr2210499and.115.1222030281226;
        Sun, 21 Sep 2008 13:51:21 -0700 (PDT)
Received: by 10.100.197.2 with HTTP; Sun, 21 Sep 2008 13:51:21 -0700 (PDT)
In-Reply-To: <vpqskrto48n.fsf@bauges.imag.fr>
Content-Disposition: inline
X-Google-Sender-Auth: d02b2c1661ec1874
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96431>

On Sun, Sep 21, 2008 at 12:25 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "Sean Davis" <sdavis2@mail.nih.gov> writes:
>
>> I am new to git and trying to set up a remote repository over http.  I
>> have configured apache2 and the bare, empty repository.  Using curl, I
>> can get the file HEAD without a password (seems .netrc is correct?).
>> However, when I try to push to the repository, I get the following:
>>
>> sdavis@lestrade:/tmp/testing> git push
>> http://sdavis@watson.nci.nih.gov/git/sean_git.git/ master
>> fatal: exec http-push failed.
>
> Do you have git-http-push somewhere? What does "git http-push" say?
>
> Probably you have a version of Git compiled with a too old libcurl
> (IIRC, it could have "worked", but a bug in the old libcurl could
> cause repository corruption, and therefore, git refuses to build
> http-push with such version of libcurl).

That was dumb on my part.  That is, indeed, an issue.  Both the mac
binary that I found and the rpm for opensuse do not include
git-http-push.

Sean
