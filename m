From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Status of kha/experimental
Date: Thu, 11 Oct 2007 21:38:12 +0100
Message-ID: <b0943d9e0710111338u109aa304o6ba9c886a42c2e24@mail.gmail.com>
References: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com>
	 <20071007213307.GA32210@diana.vm.bytemark.co.uk>
	 <b0943d9e0710091410w1559f1a0yb5055182fd289646@mail.gmail.com>
	 <20071009214613.GC26436@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20071010082602.GF12970@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Yann Dirson" <ydirson@altern.org>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig4nY-0003Dv-6y
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 22:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbXJKUiO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2007 16:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbXJKUiO
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 16:38:14 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:25185 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbXJKUiN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Oct 2007 16:38:13 -0400
Received: by rv-out-0910.google.com with SMTP id k20so613321rvb
        for <git@vger.kernel.org>; Thu, 11 Oct 2007 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=BNdGDNyhY/5RgPlL5DE8WHONDNIqaxvdeYcMaTYRkQ4=;
        b=Mw/nYrSy5veGgOKkq2AuxmetPFEqt5aYfi2LGyP4i34nn2IrBaMbL2KL/MG6JKwcC2IejNVoPyliolwHUSxdiAWIKO6M8ZvfTWDAwSvtzW/q0FcSfaCtrJostqIoN7UmRRSWzQm64+VNthp3Fp7aK8XhdS8a3EENBEEm44UDkhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e2fE1XQxB68TxXXG1DB5kpY8uLF2aGFOtjzRGcQ6+2e49p/mX98ryiwQhkbbNxlrTalEUfpKy5pVMJflQQWlI7cCA+fn+r/NQDf8vW8Tt7hfWnQej4hfkABgi0p5mUV8yQeOwUWuE8VXV2EJmEgryqIN0aztvuxFWyW1FK2+T1o=
Received: by 10.141.160.9 with SMTP id m9mr1173618rvo.1192135092174;
        Thu, 11 Oct 2007 13:38:12 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Thu, 11 Oct 2007 13:38:12 -0700 (PDT)
In-Reply-To: <20071010082602.GF12970@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60631>

On 10/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-10-09 23:46:13 +0200, Yann Dirson wrote:
> > The best situation would be that there would be a code freeze at
> > some time, during which I could update those patches without too
> > much perturbations, but that may be asking a lot :)
>
> There aren't that many of us working on StGit. If you can give a
> reasonably accurate start date and duration of the freeze,

This would mean that I have to be more organised :-).

> I don't
> think it would be a problem.Others would simply have to be aware that
> any patches not merged before the freeze would have to be rebased on
> top of your work once the freeze is over.

I'll try - let's say we freeze it starting with the coming Monday
(what's currently in kha/safe will be merged anyway) and aim to
release 0.14 in about 3 weeks (or as soon as we fix the major bugs).

--=20
Catalin
