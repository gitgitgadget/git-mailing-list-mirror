From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort at prompt
Date: Wed, 28 Jan 2009 04:53:12 -0500
Message-ID: <81bfc67a0901280153v33993d73p63687c78df555b48@mail.gmail.com>
References: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
	 <20090128084756.GA28493@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 10:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS786-0002Ov-SJ
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 10:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbZA1JxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 04:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbZA1JxP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 04:53:15 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:45333 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbZA1JxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 04:53:14 -0500
Received: by fk-out-0910.google.com with SMTP id f33so3652505fkf.5
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 01:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Jf9V6AV9QqM4kpFrgQPK8/eKN7WpIHTzBamlmWVvNn8=;
        b=wiQDGMCDbgMAMEVrtHqya2AKJWUG+LiCw2/wZlSqKqikziOnkkFlW7zw/Q4aoAwp1Z
         N6szeio8QOJ4JpzegIhqn3a43gui2D1WF8pHuedUYkxA75tD/EcMKKE3igYUEDgN133f
         F4r2rLTPOssbHnH3+Q0gKTdq0oOiEId9VE7c8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=t1vWG6kE9U/t977mW/lD/JTF+1JNWIDVOmWAvFhVV5g5RvxsAkxRooNMtLxCW5jK/l
         jZY0P/DgMG9++8VCrF2E6OhAV/LdK42XwNoT9WDbCSYvjitcLUWK+Zv08N+JwaorcMWa
         AlJ/UAzLoEw7c9+4M7h/BnhNuhsXdJm/LK5xQ=
Received: by 10.223.110.144 with SMTP id n16mr2109713fap.63.1233136392393; 
	Wed, 28 Jan 2009 01:53:12 -0800 (PST)
In-Reply-To: <20090128084756.GA28493@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107518>

>  With this change, it would seem to be more logical to ask whether the
>  merge tool is to be run before creating the temporary files, removing
>  the need for them to be cleaned up if the answer is no. I think that
>  this would be cleaner overall.

I agree, but to be honest, I couldn't get the logic wrapped around my
head, so I did it this way. refactoring does seem to be the best idea,
but I don't understand enough of it yet to do so.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
