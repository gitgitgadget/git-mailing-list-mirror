From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] I don't known anyone who understands what it means when they do a merge and see "file.txt: needs update". "file.txt: has changes" is much clearer.
Date: Mon, 5 May 2008 12:35:06 -0400
Message-ID: <32541b130805050935l7257a5e3t9b44d61abe28db37@mail.gmail.com>
References: <1209798522-13618-1-git-send-email-timcharper@gmail.com>
	 <alpine.DEB.1.00.0805031509170.30431@racer>
	 <7v3aozwcj6.fsf@gitster.siamese.dyndns.org>
	 <3DE78C03-DA35-4CB5-8D3D-0529A89065EC@gmail.com>
	 <7v63tvszgo.fsf@gitster.siamese.dyndns.org>
	 <32541b130805031721n29cf470cx391fe0e8b4943706@mail.gmail.com>
	 <7vtzhesvxu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tim Harper" <timcharper@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 05 18:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3fV-0005iK-VX
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149AbYEEQfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 12:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755179AbYEEQfM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:35:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:8103 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbYEEQfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:35:10 -0400
Received: by fk-out-0910.google.com with SMTP id 18so748558fkq.5
        for <git@vger.kernel.org>; Mon, 05 May 2008 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vW7hbQzjxct/aBU+NTtPvofyACEFEmt4UNyfgCs1Rmw=;
        b=vXsBFOMz5bp+M5wu4qJ1ZEos6NmUe/La0dXcM+Lo/XAcYVx+zKkQ10n06riVpT6v8pl1nLMeK+mNYUFiJKMyQ3euFHd5irGOpX6DvBlkuHnkGPflyUFL99Lxpu0NfpdgOuD28m4DE8qzRzFnWy/LSnu7sf33j7sobIfq4CUguXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LSES6wyWq2gYYNq/n14e1PC0TyHo+XZRN34o6QOkgLYWlS4XpnT6dtTlnI0AfYQzQklhhIn9CZv9ETfwTMn/jII891poxcHHHC/qrXZqOIfLsU48X2aN3vGuUzx3pAhuRB3haV5DBL++3EOzrL5kQf5Wb4hkLWTviXhFSJhUrpw=
Received: by 10.82.182.1 with SMTP id e1mr70912buf.41.1210005306892;
        Mon, 05 May 2008 09:35:06 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Mon, 5 May 2008 09:35:06 -0700 (PDT)
In-Reply-To: <7vtzhesvxu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81296>

On 5/3/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
>  > On 5/3/08, Junio C Hamano <gitster@pobox.com> wrote:
>  >> Of course not.  Where does end-user scripts come into play when you are
>  >>  running the testsuite?
>  >
>  > I thought user scripts weren't supposed to rely on the porcelain
>  > output?  It seems to change rather frequently anyway.
>
> Wasn't the patch about changing output from "update-index --refresh",
>  which is as low as you can get?

Hmm, perhaps the problem then is that we're using plumbing output and
presenting it to the user as part of the porcelain.  Is there an
elegant way to fix that?

Avery
