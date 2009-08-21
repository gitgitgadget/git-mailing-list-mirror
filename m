From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git-daemon via launchd
Date: Fri, 21 Aug 2009 22:24:23 +0200
Message-ID: <81b0412b0908211324h25f6a2c0sda6da17b43488925@mail.gmail.com>
References: <D49DB51B-4D25-44CC-B09C-2598EC7FCEE9@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Meaf5-0002ED-SV
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 22:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbZHUUYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 16:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbZHUUYX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 16:24:23 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:50008 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbZHUUYW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 16:24:22 -0400
Received: by ewy3 with SMTP id 3so944383ewy.18
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zL94B3VlaXBHLRVxUMZVu1E9H1fQRS5ehtaw1Qsp/wo=;
        b=Tq6X0SrUw9dprSEA0HoxefvRRNbS477gX7eNw2QsZ3b5TxCyCd+RZjr8luUGbs+FhO
         SrS9umE3GiMrSjLObtEiXYsk18qnE0ZlKN30HRYXsRmFZTOvRl5ILd1gOpcBxCgesaMW
         HuI8nGphplYRBLYqSipoG1OOkvgVJBkOrbbOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bS+vJeFwSQJxX1XMizZrKJsAT1fcr/1VfdQmf76Gj/XH68v/i/b/jt8Q6M5m6ykoZH
         N0316LHVPuy9ytmELF0XWEFVHoaPUnacNgTG8ni63Xj3hUi52DmwPs7kRj8Suo1XdKy/
         7VGKXow2SewDU5Cknb9XH5xeJcUJMokWmkJNE=
Received: by 10.210.134.20 with SMTP id h20mr1656233ebd.41.1250886263555; Fri, 
	21 Aug 2009 13:24:23 -0700 (PDT)
In-Reply-To: <D49DB51B-4D25-44CC-B09C-2598EC7FCEE9@kellerfarm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126749>

On Fri, Aug 21, 2009 at 19:40, Andrew Keller<andrew@kellerfarm.com> wrote:
> Is it possible to configure launchd to run git-daemon based on an incoming
> connection, rather than having git-daemon listen for connections?

Yes, see inetd and xinetd examples in Documentation/everyday.txt
