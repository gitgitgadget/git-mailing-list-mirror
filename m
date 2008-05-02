From: "Sitaram Chamarty" <sitaramc@gmail.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Fri, 2 May 2008 22:29:29 +0530
Message-ID: <2e24e5b90805020959h42258110vfd6fb4957643e6fc@mail.gmail.com>
References: <4819CF50.2020509@tikalk.com>
	 <20080501144524.GA10876@sigill.intra.peff.net>
	 <4819DCF1.7090504@tikalk.com>
	 <20080501152035.GB11145@sigill.intra.peff.net>
	 <20080501203940.GA3524@mithlond.arda.local>
	 <2e24e5b90805011906g769723f0g3ffbbe6588cf23d0@mail.gmail.com>
	 <7vtzhhxwep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>, "Jeff King" <peff@peff.net>,
	"Ittay Dror" <ittayd@tikalk.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 19:00:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrycP-0002oC-FY
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 19:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762613AbYEBQ7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 12:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762378AbYEBQ7d
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 12:59:33 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:24100 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762222AbYEBQ7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 12:59:32 -0400
Received: by ti-out-0910.google.com with SMTP id b6so303888tic.23
        for <git@vger.kernel.org>; Fri, 02 May 2008 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zEnt5vy7OqHwHKz/6wyIWRO0Exo61pwlCPRH+JV5OmY=;
        b=CXOrAmeRvn7irWaIF1qYpNh99SYlaBGeEq8ZKJwTHuDHNF52Q/e/C/VXML8sUC3+9z6lW18806Fh+pKi5CGexz6BTjCnvGd/1Pk/LEZp2zYkDQSMefeY3t8P8Lvut7E9/kg38rQBZJ2zOXwGEr7+lPZw6wgqIGNVNCm4WXebBpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MljtE5zoriXteeDzx33IqXHToOCbDUOksPTW/FUlQ7eJ4ShmYWuEw9aIjTTqLZhRGcnyFN7w8br/1U+1s9fIZh+tuFLbRKEE5dhvoRM+7jtJuDwU3nfvGFco+4qd6LGrLAlfzHi5UWS7p+3jMbYfZiGLQ4rrnmNiT/WBkhbn8wI=
Received: by 10.110.73.3 with SMTP id v3mr323774tia.21.1209747569755;
        Fri, 02 May 2008 09:59:29 -0700 (PDT)
Received: by 10.110.52.10 with HTTP; Fri, 2 May 2008 09:59:29 -0700 (PDT)
In-Reply-To: <7vtzhhxwep.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81012>

On Fri, May 2, 2008 at 8:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>  The option to -M<num>, -C<num>, -B<num>/<num> are "raise or lower the
>  similarity threshold to <num> / 10^N" where N is the number of digits in
>  <num>.  IOW, you will always be expressing number between 0 and 1.

Thanks.  The only mention of this I find (now) is in a file called
diffcore.txt, which appears to exist only in the HTML documentation,
but not in the "man" pages anywhere, as of 1.5.5.

[ I pulled a few hairs out trying to find it in the man pages :-) ]

I'd submit a patch, but a guy who takes the easy way out even to get
the documentation (essentially doing a checkout of the "man" branch)
would certainly not be able to test it :-(
