From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: fix default regex settings on Darwin
Date: Fri, 10 May 2013 23:31:32 -0700
Message-ID: <20130511063132.GF3394@elie>
References: <1368248913-95188-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 08:31:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub3LK-00055c-AI
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 08:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571Ab3EKGbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 02:31:38 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:55684 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab3EKGbi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 02:31:38 -0400
Received: by mail-ea0-f180.google.com with SMTP id g10so1229102eak.25
        for <git@vger.kernel.org>; Fri, 10 May 2013 23:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WjLuSBawJdsY0nVO8SShMSNJAFXWBbeoZvQ6mn4cfk4=;
        b=xMyEQ4p3iWfZFyPm3EXUnbCtppGXVHhvovlakx0AbnfHsyEMquqBooEgKmK2XDnKKS
         QHPkaYNw9f8TAI6fjgNpNelY75Jh1XLQI4rFs5ttFAKs3Kb1aoASmGAuQLhSIDdnWW1f
         Zq/+tWn6KVuDHFxcI1H+nwHnrqff38XIRj+b19C165crjUXNa2A0WJMKurGZIRp9zk48
         dsTVY1F5jldTQ2U5FIV1y3gkvDqwHQxyAISpDmLdy/p7P+ZwMSV6zuuBpoRIx3V8PcPE
         DZi2WXKCLSOT8yMUGCGMxJUX/NfhseRveninhp9MINHQvABOJzDezUhEfVxJuCdnp/JD
         gNjg==
X-Received: by 10.14.69.138 with SMTP id n10mr49609749eed.32.1368253896961;
        Fri, 10 May 2013 23:31:36 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id bp51sm8033441eeb.5.2013.05.10.23.31.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 23:31:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368248913-95188-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223934>

David Aguilar wrote:

> t0070-fundamental.sh fails on Mac OS X 10.8 by default.
> Fix it by using Git's regex library.

Can you say more about the failure?  What does

	./t0070-fundamental.sh -v

say?

Curious,
Jonathan
