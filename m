From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Bisect: add "skip" to the short usage string.
Date: Mon, 29 Oct 2007 15:35:31 +1100
Message-ID: <ee77f5c20710282135y438db381hfbb81d49ed962eac@mail.gmail.com>
References: <20071029053153.fe400886.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 05:35:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImMLq-0007Qy-Nm
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 05:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXJ2Efd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 00:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbXJ2Efc
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 00:35:32 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:51171 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbXJ2Efc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 00:35:32 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1456771rvb
        for <git@vger.kernel.org>; Sun, 28 Oct 2007 21:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CsHJZL3FIimn7N59DGxnz3aNC2e0YxD072NPTFmQEkg=;
        b=LNvR+rLDEgoCGwj3YjsGWJKGum9SF9dZ2fDYoC5NUpj1lHP6M2SkYJaUs8CT/106rNOyHDlD4tAyo3qg5hKX/sakb5yaeUENjnp/U0uyQ3BB8ykVSpmYkPbeLhwH1bC3yCr4tPQnrDg/AScS/YHbEoX47DQTH4aCfsjo5ZjwBik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jRj1I0IJnQ8oWHGVyF1ImC1+V7dhYcJ+Jyk7jPKrKGNaLE6tshmJbnWyCj8heaO5FzehbrI+Rw3WX4dpCk0hWieLfT0C32inA7eTP2Ld8HmMv4hAYxQoK2rlRE0oUOoEyViAn9v48GgAXTO9wcypUR1RxDisUar+JsudVEGhx30=
Received: by 10.140.147.5 with SMTP id u5mr2554965rvd.1193632531705;
        Sun, 28 Oct 2007 21:35:31 -0700 (PDT)
Received: by 10.141.115.4 with HTTP; Sun, 28 Oct 2007 21:35:31 -0700 (PDT)
In-Reply-To: <20071029053153.fe400886.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62598>

On 10/29/07, Christian Couder <chriscool@tuxfamily.org> wrote:

>
> -USAGE='[start|bad|good|next|reset|visualize|replay|log|run]'
> +USAGE='[start|bad|good|next|reset|visualize|replay|log|skip|run]'
>  LONG_USAGE='git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
>          reset bisect state and start bisection.

"skip" should be closer to the "bad" and "good" options, since it's
most similar to them in that list.


Dave.
