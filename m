From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb and remote branches
Date: Fri, 31 Aug 2007 01:09:28 +0200
Message-ID: <cb7bb73a0708301609s330f8d6fna3755bff346452ab@mail.gmail.com>
References: <favitd$3ff$1@sea.gmane.org> <200708300001.39203.jnareb@gmail.com>
	 <cb7bb73a0708300018u37f5c465u5d87eae0eb23543c@mail.gmail.com>
	 <200708301016.17552.jnareb@gmail.com>
	 <7vbqco91fi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 01:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQt8n-0006dc-KH
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 01:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762812AbXH3XJa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 19:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762772AbXH3XJa
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 19:09:30 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:21447 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762710AbXH3XJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 19:09:29 -0400
Received: by py-out-1112.google.com with SMTP id u77so3132998pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 16:09:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iTOTnnKvX16vcQBUqfxUI4eUtr66MEIPWwZXxhWkNaj/SaCNZVeMcwa4ojrraf5RIMichHvgwhUPxK5Fopjskcynlpsk1sMyo3U0Cbp3HAMW4lnQRvc4ydzUe7hbdTKN/fZUmKFNFYGNFzt5xsnMxLPem5f7joX/vNjTScJVe3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g+tzdMwQcGVFt1Jh/qWMhsEBUU37xiduDZmQ8ZVIhIEcYRlkwOzQVCtjpzB8eAwFrup72Ea4ynTrsqIY2o1noRYDRYoJcKH16165kyDVCSKQ1mlmhv8dGEnYKzzngulXvKj7NpABGB/5ZhbzMF5/dNCVrm7BopW+RN9885UHGdY=
Received: by 10.35.85.16 with SMTP id n16mr1193616pyl.1188515368684;
        Thu, 30 Aug 2007 16:09:28 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Thu, 30 Aug 2007 16:09:28 -0700 (PDT)
In-Reply-To: <7vbqco91fi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57089>

On 8/30/07, Junio C Hamano <gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
> > That reminds me that gitweb has no support for detached HEAD as of yet,
> > although I don't think we want to encourage detached HEAD in public
> > repo.
>
> That logic is flawed, I am afraid.  If you have been talking
> only about serving public repository via gitweb, then the topic
> of the thread becomes totally moot.  Exposing or even having
> remotes/ in public distribution point repository would be even
> more wrong than using detached HEAD in public repository.  Other
> people who interact with you should not have any business what
> you happened to have fetched from _your_ upstream --- if you
> want to publish them and act as a relay for your downstream,
> then they should be fetched from your branch namespace.

OTOH, having 'origin' exposed, and knowing the 'origin' URL, would
open lots of interesting fields of research, such as distributed git
mirroring to download large repositories from more than a client etc.

Anyway, making visible remotes an option that defaults to disabled
would address both the issue above and the one below:

> But obviously people use gitweb/instaweb as a way to view their
> own live repository, and I think it makes sense to show and
> support remotes/ in such a case.  It also would make sense to
> support detached HEAD there as well.

If I understand correctly, a detached HEAD is simply a checkout in the
middle of a branch, and thus not named. So what exactly are we looking
for when we talk about supporting a detached HEAD? Would it be enough
to display HEAD in the list of heads?

-- 
Giuseppe "Oblomov" Bilotta
