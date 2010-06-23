From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 8
Date: Wed, 23 Jun 2010 19:18:09 +0200
Message-ID: <AANLkTik1fV1yYZL5mKbVfGKOao7VjzMsg2D_7FkL8nR2@mail.gmail.com>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 19:18:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORTat-0007De-Vk
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 19:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab0FWRSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 13:18:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54488 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab0FWRSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 13:18:30 -0400
Received: by vws9 with SMTP id 9so1209239vws.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=u1vUtuHSuNpVGRVEX125LPyHfxoiL4Jdzk21allF0EU=;
        b=Hs3pwottvXRaLpl/1UnD3uSfuhU06vY5YmQYtb/Gb2ADlZ975UMm1SMTU1lysPQuqB
         5D2m0TmXfl71EZ4n1Eu1qsMpgfUTweqyVmBbLA7xj+Iuv6mTAv0jMphBsy8A6oAwayVr
         iJAdRvkbCiqUJpHUDu9VCfBQNkxXwqKSfSWHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iabWtE5uOmnOw7dvT+/RG5vEj+UAfioV+H4tiT2xw7yDas/O6OC5A6BgVhXOWWBd1F
         rUh5FxkXrwzkyj4iUSXD6Rg5MSaZAUQh8ihtSBK5BDIxhyhe9os06kUPU3tkw99w0l6W
         SgPRwc3au4fdX9Z95UuE/KZ9rvXoX1VKNHE4w=
Received: by 10.224.97.14 with SMTP id j14mr5192636qan.7.1277313509182; Wed, 
	23 Jun 2010 10:18:29 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Wed, 23 Jun 2010 10:18:09 -0700 (PDT)
In-Reply-To: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149520>

Hi,

I have another doubt. If the 6~8 part series is preferred, shall I
also include one patch that imports dump.c from the Subversion trunk
directly and another to strip off the unnecessary parts, clean up
whitespace and style? In other words, would you prefer to review the
dump.c taken from the Subversion trunk (and some style patches from
me) or my cleaned up version?

-- Ram
