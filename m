From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] checkout without arguments does not make sense
Date: Mon, 21 Jul 2008 17:36:59 -0400
Message-ID: <32541b130807211436h77bf5985xa61ed7b4941c47dc@mail.gmail.com>
References: <200807212206.32818.johannes.sixt@telecom.at>
	 <20080721204955.GI32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 23:38:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL351-0007Z5-HF
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 23:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbYGUVhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 17:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbYGUVhD
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 17:37:03 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:31795 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbYGUVhA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 17:37:00 -0400
Received: by yx-out-2324.google.com with SMTP id 8so288417yxm.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 14:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rFudgFtYi0KJMT4v91cyixAWAhftlcgpaog1LjM79og=;
        b=J2AB4S8SlMgAd4DNkq8aGiovc6+OCSgofPftB9oo0Vay2mQhd5W9SLz7UfuGToO1B1
         0WRwLMpHOf/cq+jPkuhKRqQFnPMV7fDXz05V36iCfq9Vn9yN4RaBJpNLKyvcjzrwGGNC
         8FCPD9P3SLNc+6aa8dhesN9wYIMGOdLYPR/ZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l5I/PtwvHJxYWIz+ZXIaRhpshyXwgXcsXK7zNgqjeCHYoKLW+v0CTafoNLhhTNX5MS
         UIb22QdxdKraZqY7nqOlh8w0qgq8Bwsq71MnOfO6k0Sa5sMJA4NJenBzQjqQGmaRxiJr
         c3meW2fs1ZTopaBckhIPh9snn6TUrkOXrXk40=
Received: by 10.150.182.17 with SMTP id e17mr4431590ybf.123.1216676219752;
        Mon, 21 Jul 2008 14:36:59 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Mon, 21 Jul 2008 14:36:59 -0700 (PDT)
In-Reply-To: <20080721204955.GI32057@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89407>

On 7/21/08, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Actually I think it _is_ useful, like this:
>
>  $ git checkout
>  Your branch is ahead of the tracked remote branch 'junio/next' by 1 commit.
>
>  How will it be possible to get that info easily after your patch?

Eek, are we using "checkout" to get status information now?  If that
goes wrong, you could be blowing away your locally modified data by
accident.

I think "git status" reports this information in recent versions, doesn't it?

Thanks,

Avery
