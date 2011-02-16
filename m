From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 08:18:18 +0000
Message-ID: <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net> <20110216032047.GA2858@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 09:19:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpcbL-00050i-RI
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 09:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab1BPITB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 03:19:01 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54138 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab1BPITA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 03:19:00 -0500
Received: by ywo7 with SMTP id 7so484768ywo.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 00:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=aSeROXrX6AxhrArn38meJlBRwJi0TifVHA2VXOsr/ac=;
        b=qcguqpcHkpDLq+AC6qs1bWP93W7FZf9YSQcMY9nApMqsEfNcDNqa660kI3FAxvc5Gx
         Z+hkxK9fLaCuhXFQCd4zC6zGU6gJfmLuIZKUGSL0Fy8Tg0nKQh5T0g6pTup1Kv/bL19e
         eP7ptPmCy7+zF/KRZbXU/HJmv2DXotnIdmksQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uUrvDGbtXuGzJZI3+f/sKmaOJmcMafGJs2b9O/X5WoPBx4+unlF5bqia7yMzYx/+Am
         Uarsiu1BKtAmyQLVZVRZEP6TmDabmBan1QaXmgG/MTTzr8s5lH3V9Urgg8/AunJMgLPr
         ZIavgGiAu555L6KzLBLeQ+zok8PlYt1Ndn37A=
Received: by 10.150.150.3 with SMTP id x3mr361462ybd.336.1297844339115; Wed,
 16 Feb 2011 00:18:59 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Wed, 16 Feb 2011 00:18:18 -0800 (PST)
In-Reply-To: <20110216032047.GA2858@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166929>

Heya,

On Wed, Feb 16, 2011 at 03:20, Jonathan Nieder <jrnieder@gmail.com> wrote:
> If I remember the discussion[1] correctly, by requiring a separate
> add -u step (or commit -f -a) if the "I don't trust my fingers"
> configuration is enabled.

That would definitely work for me. The question then is, should git
consider the index precious by default, or not? That is, should that
value default to true in 1.8?

-- 
Cheers,

Sverre Rabbelier
