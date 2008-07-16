From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 17:53:45 -0500
Message-ID: <89b129c60807161553u58f0c926yed4d6fabe49f42af@mail.gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:54:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFtV-000774-Mh
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952AbYGPWxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbYGPWxr
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:53:47 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:29892 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbYGPWxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:53:46 -0400
Received: by wr-out-0506.google.com with SMTP id 69so4240843wri.5
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OKz09mY2Nl6Z63O56vbq7PDx2nRmMYvCvisBNaXwDnM=;
        b=Fd2Pt07ybQEr4nni1iyRytRASRy3//Iq1jUm8Dy8DVf83XZeJRs4YFIPSBVlQEPDzd
         H5SdsHjKtDsJ3kCMiSw/gYX4OmQRy99VW8HwqEWvwJqnAz8PAmWF7qr6e4fOjmL5QvXu
         ZaoFGD5Hkq2XA57On5XaSCEYlAVGFjc/+8yXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XRlC+8XHNV6FeEvwDcEx0qQLjt5+TTE8Y6D+2ZhuyC2Grt7Nog0OnQI2pzeNiPn6rL
         AdPVMpCiefJfxDavbv62jiyXKXe2n7a7rACwIxdl+ecs3NVDlzbQG4uRc0ob6tymuBPC
         omBUrsJiRGuG6cXFwJa+ex9bPOiwxNcqeK4Ps=
Received: by 10.90.66.14 with SMTP id o14mr2296284aga.84.1216248825419;
        Wed, 16 Jul 2008 15:53:45 -0700 (PDT)
Received: by 10.90.102.16 with HTTP; Wed, 16 Jul 2008 15:53:45 -0700 (PDT)
In-Reply-To: <20080716223205.GK2167@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88778>

Hi

On Wed, Jul 16, 2008 at 5:32 PM, Theodore Tso <tytso@mit.edu> wrote:
>
> In general, I find that people are more willing to listen to "we have
> a more powerful way of doing things", if you can first give them the
> equivalent of the "dumb and stupid" way that they are used to doing
> things so they can switch to the new tool right away without too much
> of a steep learning curve; they will then switch to the more
> advanced/powerful workflows at their own pace.  Other people may have
> other pedgogical techniques, but I find mine to work fairly well.
>
> Regards,
>
>                                                - Ted



When one has 100 users in a company using a DVCS, you really need some
sort of simplified workflow documented and taught.  Not everyone who
writes code is particularly keen on the vagaries of a VCS' commands.
I know that must be shocking to this audience the GIT list, but it is
very very true.  They don't give a crap what sort of weird command
combination one can pull out of the 100 or so commands when you type
git-<tab> at a bash prompt.  They just want the damn thing to behave
in a somewhat friendly fashion.  They want to check in their code and
get on with software development and not over analyzing how many ways
they can do the same command.   In my experience, what Ted is
suggesting is the only way to handle it.  Most developers just want it
to work and focus on debugging their project.  Never expect your users
to have the same interest as you in VCS.

Sean
