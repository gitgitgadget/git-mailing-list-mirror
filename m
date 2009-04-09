From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH RFC 1/6] Re: send-email: Add --delay for separating emails
Date: Thu, 9 Apr 2009 19:45:47 +0200
Message-ID: <20090409174547.GA15767@vidovic>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com> <20090409161756.GA12910@vidovic> <b4087cc50904091027l4656a6adv6a72bad0a747cdc1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 19:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LryLY-0000OV-Uu
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 19:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935231AbZDIRp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 13:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765446AbZDIRpy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 13:45:54 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:44162 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758534AbZDIRpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 13:45:53 -0400
Received: by bwz17 with SMTP id 17so703807bwz.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 10:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=183h/GKO/cmB38guiJNKeZvdF38oGcdLGbVGqW7JjZ4=;
        b=s6gtGKYM5aYFkDJcDgcYjL1yew2ptRrLW3bHpVjUT5B9wMitsewS35DsUDBDcae5Gs
         otsnaUwAmeY59WdbyMOXoNIPeKgS9VXhH7kggK3W4G4XYCTAyGMuz4jf6LMOQc6+g19T
         3518Iakw3Oi+bf1+9UbFLk+FCpbEi34PmbsPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hAsy+n2x7jyCyv21EN5C1NI5MfZuvcDDQG3wXpN9L5x6HMgVUy4zNXpVrIW1ImYvBG
         NefxU49uvpp29Ou3HeGkIXspgXnKNhQbNAFsB4xTa5mTnKid5TtMEWIsjQCPSP7XGGXb
         MDi3ekN+f+nkQaoGF7pAmXSoBaZ5Pd1HQsjbM=
Received: by 10.103.240.5 with SMTP id s5mr1380103mur.133.1239299150776;
        Thu, 09 Apr 2009 10:45:50 -0700 (PDT)
Received: from @ (91-165-136-189.rev.libertysurf.net [91.165.136.189])
        by mx.google.com with ESMTPS id 25sm1019165mul.21.2009.04.09.10.45.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 10:45:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b4087cc50904091027l4656a6adv6a72bad0a747cdc1@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116189>

On Thu, Apr 09, 2009 at 12:27:18PM -0500, Michael Witten wrote:
> 
> On Thu, Apr 9, 2009 at 11:17, Nicolas Sebrecht
> <nicolas.s-dev@laposte.net> wrote:
> >
> > The --delay option may have an undesirable side effect. In case of
> > non-chained emails, unrelated mails could be insterted between patches
> > where *all* MUA would be affected. It's not only true for very high
> > volume message mailing-lists (million monkeys receiving...). FMPOV, it's
> > worse than all display issues we already know or have with the current
> > behaviour.
> 
> But it's already impossible to protect against this scenario.

But we could forbid the use of --delay with non-chained emails, no? Or
at least, warn it should not be used.

-- 
Nicolas Sebrecht
