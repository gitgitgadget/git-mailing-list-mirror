From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: SEGV in git-merge recursive:
Date: Thu, 29 Mar 2007 10:18:14 +0200
Message-ID: <81b0412b0703290118q3e602a7bx650ac41241855546@mail.gmail.com>
References: <20070329075010.GA3493@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 10:18:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWppr-0001TR-Ab
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934048AbXC2ISP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934050AbXC2ISP
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:18:15 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:31157 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934048AbXC2ISO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:18:14 -0400
Received: by an-out-0708.google.com with SMTP id b33so101396ana
        for <git@vger.kernel.org>; Thu, 29 Mar 2007 01:18:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VV9Cq7luz7rtR0KMaRXcaibNtpfGSXwwCQllZTYUfXpbKI0dL++j3WJqJhgzRifAfsFMfOU9BN/BNocuNIKz6+8h18GtZ3rxOAuWvaUWgMLRo4FuGuACnh3W2vU4vqK8ndO5j9hBnytdcJfQK8sofUvAookfgDbvYyLONpn3y9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BefCh4cZKRqLQ2T/4wEIqh4AEmhwWS8t/etbWSSQi6v/7PFarK48lindSQje89nYmron6cF3gA0QeH5Q64uRhY9pKndjLm4QCFmSKDA6yyRYnk7XB82xhC7q6iSoEfqLL1ln9XqQyp3zfaXO9jDsJl3mtXxEINHzFE6OCaZQks0=
Received: by 10.100.13.12 with SMTP id 12mr181159anm.1175156294198;
        Thu, 29 Mar 2007 01:18:14 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Thu, 29 Mar 2007 01:18:14 -0700 (PDT)
In-Reply-To: <20070329075010.GA3493@hermes>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43411>

On 3/29/07, Tom Prince <tom.prince@ualberta.net> wrote:
> I have been keeping my Maildir in git, a non-trivial merge that causes a
> segfault in git-merge-recursive.

Can you try and get a stack trace? Do, for example, GIT_TRACE=1 git merge ...
... find the call to git-merge-recursive and start that in gdb.
Wait until it crash.
