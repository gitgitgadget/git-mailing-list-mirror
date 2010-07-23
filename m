From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t3508: add check_head_differs_from() helper function
 and use it
Date: Thu, 22 Jul 2010 20:38:59 -0500
Message-ID: <20100723013859.GA28603@burratino>
References: <20100721042503.1948.5144.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 23 03:40:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc7FD-00021X-4m
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 03:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757217Ab0GWBkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 21:40:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50428 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756878Ab0GWBkB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 21:40:01 -0400
Received: by iwn7 with SMTP id 7so8409113iwn.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 18:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pVxAVODfnNdsauL0FChRWmyGbMXhVGSsaCIaLvMTEm0=;
        b=PsmlQ1BUj6ebJF/HX4E5SVyXDoPHd6SekfAhjrX9bQ42zSXglR+nuIlMabdlL1aqpj
         h6TdWvT4VGTLdH2O/xC4E96AKIewQ31ESbgeJRkiM3+vAkr5mb0F+YlnxwS0eabYK6nk
         syRijakAvo5Kg/ORxnGKTlSOTaCMj+pmZcsIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mdmnQjYJxW9SHXeg7rXKyLmDLy8nbtBJPQKUKeHQ95dn1QRCz5iDQQ+iv/StLc9qbY
         YmQirVnSv8RuuOb3UFij2H+zoMpzte5yThwOjH4jFuSqa2rseLddSmMcK0zAqr4EZbJf
         GsMh4F7KwNYXQqrwKLppewP4TyTAfFS+Q69tc=
Received: by 10.231.176.16 with SMTP id bc16mr2650159ibb.4.1279849200462;
        Thu, 22 Jul 2010 18:40:00 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm30508804ibb.14.2010.07.22.18.39.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 18:39:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100721042503.1948.5144.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151498>

Christian Couder wrote:

> So it is more robust to
> define and use the helper functions check_head_differs_from() and
> check_head_equals() as done by this patch.

It makes the test a little nicer to read, too.  Thanks.
