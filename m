From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 01/12] git-grep: read config
Date: Fri, 25 Jul 2008 02:03:59 +0700
Message-ID: <fcaeb9bf0807241203yd57e675j964594c501ce59a2@mail.gmail.com>
References: <20080723145535.GA29053@laptop>
	 <20080724171519.GA21043@sigill.intra.peff.net>
	 <fcaeb9bf0807241145y16bb5f94q9f7e3c09c3184782@mail.gmail.com>
	 <bd6139dc0807241153v5055e922p69a176b5b706f98e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Jul 24 21:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM67d-0004Qd-KR
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 21:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbYGXTEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 15:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbYGXTED
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 15:04:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:53162 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbYGXTEB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 15:04:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1475567fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=JjzQsmibjMIvnRrQMKXvoPIqF2yFshHg4pJb/OvZ0iA=;
        b=x5Jgf8bCOfdZ9krg/YmXk1WaVugqVPBO18ewDyDXMqaVCieNzZvoPv8r99/qOfKk2m
         HiPUeoK4QHrA4AL642bM4LoqZWuazHayZNjnPZrmgJTYxHGZ+dL7+YM+izTG1kty4lxd
         u4PNGB8Rq3ebpy2H54fYPUB+8f7ViHHiDRfYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UewsHC4LVomXjnLXQ31PeQFAxNibTU2VVC1zzWhl+dksInC1g6qFUzje2Y/pCmbIxI
         rRkDKG9EqvaEJVzxquNoVTZvttgk59DQwVyPeElUwuyb4xnFjETDTprWvMPIsIdM2ctL
         sCeM8TM1Qy63lnB4mShP3kRo9O38lpncuFfJc=
Received: by 10.86.82.16 with SMTP id f16mr1169011fgb.9.1216926239214;
        Thu, 24 Jul 2008 12:03:59 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 12:03:59 -0700 (PDT)
In-Reply-To: <bd6139dc0807241153v5055e922p69a176b5b706f98e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89944>

On 7/25/08, Sverre Rabbelier <alturin@gmail.com> wrote:
> On Thu, Jul 24, 2008 at 8:45 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>  >
>
>  Something went wrong replying here possibly? Or is it just me who is
>  receiving empty messages? (At least the 3rd empty mail I see.)

I blame gmail MTA or my name's having non-ascii chars in it. Combining
those two, it produces base64-encoded messages, which are usually
refused by vger.
-- 
Duy
