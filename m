From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort at prompt
Date: Wed, 28 Jan 2009 04:50:03 -0500
Message-ID: <81bfc67a0901280150i799c881fyf3f506d7ba3c26d6@mail.gmail.com>
References: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
	 <402731c90901280004l29382eaanedfdfcca75529468@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 10:51:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS752-0001Uw-KU
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 10:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbZA1JuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 04:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbZA1JuH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 04:50:07 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:40877 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbZA1JuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 04:50:06 -0500
Received: by fk-out-0910.google.com with SMTP id f33so3651020fkf.5
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 01:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pkYYhqWJFulwp7DryiU7jMqdYo3d3bew1lx4hyaZFI0=;
        b=Zg5T0KgB0Tot+ExYHc8rPmVfExLvi3Km9tp+0do/kc08nfWGyrg9FvOFI0SGZMREwX
         n9PBaskyweJqA/1GKHvN0/ps7yRdXFoEs6PNuVubhzCnGdBj2/h10vUoSwvbt4mzr5aa
         IXzO9eOunAw+6Jp9gEMDZZ/NYRr21Oj709vFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HyI9PBDQLOba4lqP7/5UhW6d5pnnJDIf+mpPGYQHVIXoToN2Vwg+hhZia7ps2CMvzO
         d2hbOj33Qh0k1IZZ0MT8IOV6SCjO2/X67lmBIbfZXzGsapFdHzxDtNDFJo2C5vXPj0hX
         vGjwRehy1gHIxJuywwO++Egzlvy5mZCflLB8s=
Received: by 10.223.109.84 with SMTP id i20mr722188fap.42.1233136203927; Wed, 
	28 Jan 2009 01:50:03 -0800 (PST)
In-Reply-To: <402731c90901280004l29382eaanedfdfcca75529468@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107516>

>  Also, my example has quit instead of abort for two reasons (the first
>  one is silly)
>  1. skip rhymes with quit, so it reads very nicely out loud
>  2. consistency with git add --interactive
>  3. less typos (q and s are diagonal on qwerty, s and a are adjacent)
>  (okay, that last one is silly too)

I chose abort because it's used in other places in mergetool (for same
purpose). I'm not opposed to cleaning up or making it more consistent
with other utilities though. but perhaps that's for another patch...

>  slightly off-topic:
>  If we're looking at cleaning up mergetool a bit would you all mind a
>  separate patch to convert it to using hard tabs throughout, just like
>  git-rebase.sh?

in an earlier thread... I complained loudly about the mixing of tabs
and spaces, it should be banned imho, causes nothing but problems.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
