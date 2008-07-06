From: "Adam Brewster" <adambrewster@gmail.com>
Subject: Re: [PATCH v5]
Date: Sat, 5 Jul 2008 22:49:31 -0400
Message-ID: <c376da900807051949y78161d5dv17f251567ba888da@mail.gmail.com>
References: <20080705204849.GJ4729@genesis.frugalware.org>
	 <1215293200-28199-1-git-send-email-adambrewster@gmail.com>
	 <7vskunpyqz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 04:50:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFKKe-0005m3-L4
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 04:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753431AbYGFCtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 22:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYGFCtd
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 22:49:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:31500 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368AbYGFCtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 22:49:32 -0400
Received: by yw-out-2324.google.com with SMTP id 9so775562ywe.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 19:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OIq2d9zCj/QWlkrIdCEo9ZPkABdQK7xlFZeKPv9CZGQ=;
        b=GJ+konR9fCxLn61dqkXsK6qNHkfO/Ls57Hsgyd30GJurNsNgkap0YGaQjziY27UQo2
         jgARaexi0q3zI1wLISLlVajcP+e04pHPazL/14A9bfSm7svuKzXcrjywtbF60f4fcpCE
         gk5wmNxmIUf4WLVxzgBjQTbxqI6Rf8RkXOuNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=t0tstYYP/8hfNiQnjKuvPF9dRb6bdjeESPyKgDuU3iNrBY8OUreji4GAGMgBlmX0IC
         1fAbEyEOq6vnIlbvZizgYz2c5KcHceDZ/rlFLDydCabj1YZ7Yyu3aaWvp6FHfDBYF1W2
         +FcT0FTfcpoSuWwI1W+k/2qlCF4Wc0IsYryQE=
Received: by 10.151.142.2 with SMTP id u2mr5166783ybn.148.1215312571737;
        Sat, 05 Jul 2008 19:49:31 -0700 (PDT)
Received: by 10.150.205.18 with HTTP; Sat, 5 Jul 2008 19:49:31 -0700 (PDT)
In-Reply-To: <7vskunpyqz.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87486>

>
> Yeah, it is simply a bad taste to use helper in builtin-A from builtin-B.
> More library-ish files such as revision.c are better home for utility
> functions to be shared between builtins and commands.
>
> Here is what I queued.
>

Thank you.

> By the way did you compile test your fix before sending?
>

I ran make and test, but I didn't notice the warnings that prompted
the question.  I also forgot to re-check it after re-working the
commits to put everything in order.

> -- >8 --

Thank you again for your help and patience in dealing with my multiple
failed attempts to get this right.

Adam
