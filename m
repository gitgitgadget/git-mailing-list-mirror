From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 2/3] git-apply: complain about >=8 consecutive spaces in initial indent
Date: Mon, 17 Sep 2007 11:24:12 +1200
Message-ID: <46a038f90709161624j6eb55de6m61aab9e585e22a05@mail.gmail.com>
References: <11899829424040-git-send-email-bfields@citi.umich.edu>
	 <11899829424173-git-send-email-bfields@citi.umich.edu>
	 <1189982942187-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 17 01:24:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX3TO-0004Z3-KH
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 01:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbXIPXYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 19:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXIPXYO
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 19:24:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4692 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbXIPXYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 19:24:13 -0400
Received: by ug-out-1314.google.com with SMTP id z38so681711ugc
        for <git@vger.kernel.org>; Sun, 16 Sep 2007 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uAu6dVW9NkjF/EYQpqF6YgDADSGkMCfCZS5NEVG0OYI=;
        b=Uet1RFxBOmx/Wxz+GP/orvqtVhDhCNChHBg8ExjTDhAgJeU2JN8YsFIPG++fpb5bU1dnR8QZOXGk0oPqYnMsKcOGpaCvZM2bgmRqeaBXv1sG1yJtuMgtQYeMhw7L9L5LbP8M1SHLRLmRfTUhQ7wj460BFo8piJeUxw1N9vnLyPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NypBFvt+6GxCfCUZBJbD5M2AZUn98CzwkYdT3FCz0RUJG/ciZ+NEtuNeszZjPt+jUQ6PTBRiXSmU+9zbFtGY+cEfX3/TptuRzkKij72K1wmXQt4BRMLgXTAJXJXR9e1f8pA1TGEBX1pWSbStW/Ypav1SRq/BnCZlM20SIHqr7uY=
Received: by 10.66.243.2 with SMTP id q2mr6480176ugh.1189985052540;
        Sun, 16 Sep 2007 16:24:12 -0700 (PDT)
Received: by 10.67.23.15 with HTTP; Sun, 16 Sep 2007 16:24:12 -0700 (PDT)
In-Reply-To: <1189982942187-git-send-email-bfields@citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58366>

On 9/17/07, J. Bruce Fields <bfields@citi.umich.edu> wrote:
> Complain if we find 8 spaces or more in a row as part of the initial
> whitespace on a line, and (with --whitespace=stripspace) replace such by
> a tab.

I do quite a bit of hacking on "spaces-for-indentation" projects and
still use stripspace to cleanup my patches. So no, thanks.

Perhaps split it off to a separate option? I'm not opposed to the
functionality per-se, but don't put together with
trailing-space-trimming. It's a different beast. Everyone agrees
trimming trailing spaces as much as everyone disagrees on
tabs-vs-spaces.

cheers,



m
