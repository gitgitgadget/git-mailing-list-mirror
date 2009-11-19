From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] gitweb.js: fix null object exception in initials 
	calculation
Date: Thu, 19 Nov 2009 14:48:50 -0800
Message-ID: <780e0a6b0911191448p4c0f5e97j2c2a4cdc0ad9193d@mail.gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> 
	<1258659887-5244-2-git-send-email-bebarino@gmail.com> <200911192240.27743.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 23:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBFoW-0004rh-I5
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 23:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562AbZKSWtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 17:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757275AbZKSWtG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 17:49:06 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:44585 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757028AbZKSWtF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 17:49:05 -0500
Received: by pzk1 with SMTP id 1so1956074pzk.33
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 14:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=mqaOvH7gYOqvZ9YczlyhLU7Fiq8IfLJY6l1Wrrkuick=;
        b=bTacd1mB3oCkYOm8+5jUN1XYXfPcffWXQ2TRWrdEo6C4MBuKjSqwkbpTBIkY7jsrFJ
         qWFzLzdxV7hHH6/o9gXlyDXTuwg2BAE3U3w+Hge1eYcypQJORgglkMhBnF7SWLNJaB1G
         QIOz6ZXU9JPVSa6jJB/w5nEWi/VU8/wSE2qkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Hgaur2R06BhMNNqmUpGbnn62WF37SIpT6CSR0l1DRfuuQb33Di+nw28Jdj1jP/qnw3
         aoaBzCtwzySxiz58+PUoq00hmRfcNjihDSoqOkxbvglaa2os0qjdBanvrLL9fpY0aVcJ
         1QbNRSvqxRhwGJDpKkWCASiq+tSIA4xeVpo18=
Received: by 10.143.26.38 with SMTP id d38mr59934wfj.216.1258670950725; Thu, 
	19 Nov 2009 14:49:10 -0800 (PST)
In-Reply-To: <200911192240.27743.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133265>

2009/11/19 Jakub Narebski <jnareb@gmail.com>:
>
> Hmmm... gitweb/gitweb.perl *was* one of files I have tested
> 'blame_incremental' view on, but I have not experienced any
> crashes.
>
> Perhaps it was the matter of different JavaScript engine (Mozilla 1.7.12
> with Gecko/20050923 engine, Konqueror 3.5.3-0.2.fc4), or different
> starting point for blame.
>
> I assume that crashing lead simply to not working blame, not to browser
> crash?

Yes. The blame stops at 20% or something but the browser is fine.
