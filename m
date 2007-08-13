From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] gitk - dont warn when deleting synonym for current head
Date: Mon, 13 Aug 2007 09:04:52 -0400
Message-ID: <30e4a070708130604g5b848b2fm4b42e145384c0ba4@mail.gmail.com>
References: <1186952583887-git-send-email-mdl123@verizon.net>
	 <18111.39773.231609.306547@cargo.ozlabs.ibm.com>
	 <46BFAF8E.1000508@verizon.net> <46BFB908.7050000@gmail.com>
	 <18111.54668.327095.685366@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mark Levedahl" <mdl123@verizon.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 15:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKZcQ-0007MH-Bn
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 15:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030687AbXHMNFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 09:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940932AbXHMNFI
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 09:05:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:12137 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S972439AbXHMNEz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 09:04:55 -0400
Received: by nf-out-0910.google.com with SMTP id g13so485425nfb
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 06:04:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F1X0h9JvvguPDqeoOeOKmZHUO1UMlAlLwo0r/wMxWY9tmeRE3+qslMTg6m7KEExsAI5pJtO9s1lhJj7Alxr21+1JJRRwgYcGJFh8wb+5gMCSXRKukNbkDe1TWcRFl11fC6PT72tWg2GAzimq4A72RSzT/IcmLnuuKZizpB/yD0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a1whHFRZotmOwXZgEySuNBSyO4MeCnFdw7xMK27vhe2wggCjZzTHE4z6u3uMq9XChLeZAJludA8UlsSF+NXHoDpAbUKuSAhhjfxSJCraBLJFyyuUvIybR3Ud/8/ulbV3vwjp+4+8zzLCZjC5y+g6YiLlL1C3mtysV8PU65ujunI=
Received: by 10.78.177.3 with SMTP id z3mr2185661hue.1187010292708;
        Mon, 13 Aug 2007 06:04:52 -0700 (PDT)
Received: by 10.78.190.5 with HTTP; Mon, 13 Aug 2007 06:04:52 -0700 (PDT)
In-Reply-To: <18111.54668.327095.685366@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55762>

On 8/12/07, Paul Mackerras <paulus@samba.org> wrote:
> Mark Levedahl writes:
> It does load the full repository DAG - that's how it gets the
> information for the Precedes:, Follows: and Branch(es): fields in the
> commit display.  It's true that that can be turned off, though, and in
> that case an "are you sure" dialog would be appropriate.
>
> Paul.
>
If I do bare gitk, gitk loads the DAG only for HEAD, it does not read
what else is there. For instance,
