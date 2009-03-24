From: roel kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] git-cget: prints elements of C code in the git repository
Date: Tue, 24 Mar 2009 17:17:00 +0100
Message-ID: <25e057c00903240917w56fd4c08p8bbf2edbb34fe244@mail.gmail.com>
References: <49C8B159.2040600@gmail.com>
	 <alpine.DEB.1.00.0903241257430.7493@intel-tinevez-2-302>
	 <49C8E074.4030808@gmail.com>
	 <20090324135906.GA10644@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm9Kt-0006sF-Cn
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 17:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757188AbZCXQRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 12:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759611AbZCXQRH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 12:17:07 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:36258 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761548AbZCXQRD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 12:17:03 -0400
Received: by bwz17 with SMTP id 17so2295637bwz.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YVG1E5lPmSbILx1YegpUkccvwb+wIW1CslNIPPtC7os=;
        b=xuCwHTqiLI4cczizZgARPvEKBLt3e+LT5EYN9BnojHedI+PLj2k87kreBju1utEbzS
         KLFQ62PuYh1Rb4lqYb0PjgHdxAUKP7eH84dMU+NdH0qcU8xU0DFBWrQbJOXaF3zW76Q1
         IooRRxL+cjmhlX9E9yE4a71EE0/U/YjNFTsLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LVvnub/VYtCCJg3LBxj6TcNYSxjU22RhSaWHbeyf9KUemR5eO0Ft3H8e5frGaEjMTv
         7SmeghVlP7XZ1xAXP4/Z1/l1ySTVKPvIHnKxs/+PXmvqLOqLg46NX+RTXOqdVQVXj+pg
         KJkn4OKYd6gE4HB/PeNMKIfPVXiq1EmGwr/rg=
Received: by 10.223.113.132 with SMTP id a4mr7214160faq.75.1237911420915; Tue, 
	24 Mar 2009 09:17:00 -0700 (PDT)
In-Reply-To: <20090324135906.GA10644@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114469>

> Wouldn't it be a lot easier to base this on something like ctags, which
>  already knows how to do all the parsing of C quirky C?
>
>  I.e.:
>
>   git ls-files | xargs ctags
>   vi -t get_sha1

You are right, I'll see what I can do with it.
