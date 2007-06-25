From: "Bu Bacoo" <bubacoo@gmail.com>
Subject: Re: Darcs
Date: Mon, 25 Jun 2007 18:54:00 +0200
Message-ID: <cecbdd220706250954m6ce18fcem6cae4729e795e947@mail.gmail.com>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
	 <87vedcqna7.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Florian Weimer" <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Jun 25 18:54:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2rpR-0002Xo-2D
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 18:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbXFYQyG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 12:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbXFYQyE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 12:54:04 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:7381 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbXFYQyC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 12:54:02 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1421907nzf
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 09:54:01 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gVbRfR/yirPG2JPSaZX8xJ+Iw3jHIOv1sBtbaJ/lCZCnbtNli3/7FJuke79O2gUgvWFenpDZnIhaTB+MD7iVS1SSgeD/lsyASI3Il164kYp04T8SJvkQaLnEiSJq4Mh+WzwA6GWS6YjAPwM/VQdwH+CvuFWWsaeZZ2MlLMLWD/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f/j0oTsC5kkDOMBCFIQedVuG18PErWJaH25rl2hQEhz25VP3TsUFMiVlK76LCrJWZUOfnnXzlywftqKRH4SGPdVpsfuJxdqNn9Zw7WZ7RXslUANqio0YR6Fcil+0bbXqXRsAypn2dhbqEh8BXlv2gw2cuPqqNmUIqaB1su1etbc=
Received: by 10.142.82.17 with SMTP id f17mr319692wfb.1182790441017;
        Mon, 25 Jun 2007 09:54:01 -0700 (PDT)
Received: by 10.142.255.7 with HTTP; Mon, 25 Jun 2007 09:54:00 -0700 (PDT)
In-Reply-To: <87vedcqna7.fsf@mid.deneb.enyo.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50908>

Florian, what are you moving to? To GIT?

On 6/25/07, Florian Weimer <fw@deneb.enyo.de> wrote:
> * Bu Bacoo:
>
> > What do you think about darcs?
>
> The UI is nice, but darcs is quite slow (even if you don't hit the
> exponentional corner case in the merge algorithm).
>
> My main gripe with darcs, and the prime reason why I'm moving away
> from it, is its lack of support for software archaeology.  If you
> haven't tagged a tree at some point, you'll face lots of trouble when
> you try to restore something that resembles the tree you had back
> then.  This is a direct consequence of the "heap of patches" approach,
> but it's a real nuisance, and the benefits of the increased
> flexibility don't make up for it, IMHO.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
