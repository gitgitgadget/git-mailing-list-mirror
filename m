From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH] Add contrib/stg-gitk: helper script to run gitk
Date: Wed, 10 Jan 2007 10:34:53 +0000
Message-ID: <2faad3050701100234g1580d344lcc84b143ee965a23@mail.gmail.com>
References: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth>
	 <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com>
	 <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>,
	"GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 10 11:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4anM-0002R4-8x
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 11:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbXAJKez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 05:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbXAJKez
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 05:34:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:29168 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbXAJKey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 05:34:54 -0500
Received: by ug-out-1314.google.com with SMTP id a2so65788ugf
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 02:34:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xrph5bX/DlOdjGGJpxDmszpMPSoVIaLHJzkRO0JNnhgKpRGEaBnbHL1CDv0oSrwWb3EbYSVcNzNxCszfs7CvsAxbQmPrrKzARaJWfd+XcYfs7q5ziH2p6ULjGyDOEz/OTJzUlEItiHD/OBA0xWmmF/xlOGsygAlL8SZEQfYGS+Q=
Received: by 10.66.232.9 with SMTP id e9mr253195ugh.1168425293351;
        Wed, 10 Jan 2007 02:34:53 -0800 (PST)
Received: by 10.66.221.1 with HTTP; Wed, 10 Jan 2007 02:34:53 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36498>

On 09/01/07, Yann Dirson <ydirson@altern.org> wrote:
> (let's go off-topic)
>
> That makes me think that such command names like "show" are a bit too
> general: stgit uses "show" for patches, but nothing says it is for a
> patch and not a series.
>
> Also, when presenting GIT/StGIT to co-workers, I found them to be
> confused by eg. "stg push" and "stg commit" having different semantics
> than "git push" and "git commit".

They're also confusing because the stg docs and other stg commands
consistently talk about patches being 'applied' or 'unapplied', not
'pushed'. If stg push/pop were to make sense as single commands they
would be eg stg apply/unapply, or stg patch-apply, stg patch-unapply.

Cheers,
Baz
