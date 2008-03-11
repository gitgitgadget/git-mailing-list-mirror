From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 01/10] "git read-tree -m" and the like require worktree
Date: Tue, 11 Mar 2008 21:57:53 +0700
Message-ID: <fcaeb9bf0803110757i5f31c6b9w3b0e65af401e3ca0@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103316.GA8902@laptop>
	 <alpine.LSU.1.00.0803111400430.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 15:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ5w4-0006be-3I
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 15:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbYCKO54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 10:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819AbYCKO54
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 10:57:56 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:19918 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbYCKO5z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 10:57:55 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2293041fkz.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tF2EvuWsMMNX8bj2+Z9Pnd52A32HGYX4bXyhiqzx3gs=;
        b=bzr5hLADLsMedRS9rV4SAPIjnQRWoAMquyiqEcUVQEhB/mQ3FV/EckX8bo9RNEDkN2B9XK/oak6TPNioHFqsUTXtzMI8Dw2dyDgumowdWBGk+8N/aHlJmEwwTXvOe7eqWxNzp1Xyrt+cXFCFsr3fdTOrqwCaMJeT7cUe9lfoRCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rinxUf4Izk/XRuwgPfr8F1GzOkgmZGGFkqDtJh6z0WSut3aozTOpIGrzJH1R6HFYOvdJE8jI3Hw6mBideimjLVkwR7D/m0wGQWNP4g4Czdpa0Hd7jh7oDB1d8tFb7jnhowasM1334Rc50ufoi3kEdbUz19xhGWlXpEv6PXcQwu8=
Received: by 10.82.121.15 with SMTP id t15mr16575636buc.31.1205247473245;
        Tue, 11 Mar 2008 07:57:53 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 07:57:53 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111400430.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76859>

On Tue, Mar 11, 2008 at 8:02 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>  How about
>
>         git read-tree -m without -i requires work tree
>
>  Hmm?

I thought that was the patch was about. Did I write the patch so bad? :(

>
>  Other than that, it looks like an obvious bugfix which is independent of
>  the rest.

Agreed completely. As said in the other mail, this patch can be cherry
picked well without the rest of the series (should I resend it?).

>
>  Ciao,
>  Dscho
>
>



-- 
Duy
