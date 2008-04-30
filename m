From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: help with git usage
Date: Wed, 30 Apr 2008 08:02:05 -0400
Message-ID: <1c5969370804300502obbc5a63v4c2c1a1175084237@mail.gmail.com>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com>
	 <alpine.LNX.1.00.0804291354070.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Daniel Quinlan" <danq@brtt.com>, git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 14:03:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrB1X-0003pj-Jy
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 14:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758836AbYD3MCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 08:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756902AbYD3MCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 08:02:09 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:14766 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757913AbYD3MCI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 08:02:08 -0400
Received: by py-out-1112.google.com with SMTP id u52so768126pyb.10
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+H/8lDLSE5DNGJY7YoyQ3sDV3RBujAvKOAPBZSq42qo=;
        b=cAte9xMB9N+9IdHl0zhf68INtUfbW0FSHaIuQB36vFMdQ1Kl/je7uRa1VSqbnBrGqAEAgNdMJYeyvegD8uGS+zZ6LX804s0LbDlAh21rJztkTeTLvt32m2Hejt9iNa1s1vBqYOtO78fOYvgdAIdobcxy1k66hiF5VbMkC5wEsmo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZF1gRFC7awy/mc331L3JKOCUNH9xbw3iALPLf1rIQz7SNp+oaiWOaTtMaiAAMahxLn2pBmBVtlyqXR+7+Aka6CI+DSSQcgskqHY+tmt3iKC1Hv8w/dngfmKpt0IszgkIF+UHoB6zVR7e1pdlUF/kdvO3kav/q8k4oQV9arT6bxs=
Received: by 10.141.20.7 with SMTP id x7mr252972rvi.255.1209556925850;
        Wed, 30 Apr 2008 05:02:05 -0700 (PDT)
Received: by 10.141.3.15 with HTTP; Wed, 30 Apr 2008 05:02:05 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0804291354070.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80830>

On Tue, Apr 29, 2008 at 2:07 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 29 Apr 2008, Daniel Quinlan wrote:
>
>  > I've been trying to use git for awhile now, (and I've read a lot of
>  > documentation, though maybe my
>  > comprehension has not been high enough) but there are several operations which
>  > I
>  > can't figure out:
>  >
>  > 1) After cloning a repository from work at home, making some changes and
>  > committing them,
>  > I use "git push" to push them back to the work repository.  The changes seem
>  > to make it to the
>  > work repository (I see the commit message in git log), but I can't figure out
>  > how to get the
>  > changes into the working set at work.  (evidently not merge, checkout or reset
>  > -- seems like it
>  > should be merge, but)
>
>  You shouldn't push to a non-bare repository.

Is there any reason it wouldn't be appropriate to make git refuse to
push to non-bare repositories?
