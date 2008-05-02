From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Make words boundary for --color-words configurable
Date: Fri, 2 May 2008 17:23:10 +0800
Message-ID: <46dff0320805020223g497bee82o7bd21d530df9f6de@mail.gmail.com>
References: <1209699564-2800-1-git-send-email-pkufranky@gmail.com>
	 <alpine.DEB.1.00.0805020839200.2691@eeepc-johanness>
	 <20080502081408.GA11420@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri May 02 11:24:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrrUy-0007qM-5a
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 11:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758888AbYEBJXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 05:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758816AbYEBJXN
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 05:23:13 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:38758 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbYEBJXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 05:23:12 -0400
Received: by an-out-0708.google.com with SMTP id d40so291035and.103
        for <git@vger.kernel.org>; Fri, 02 May 2008 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=SOTfv26dAdDlnSqYSfSAXK15xm33aTcK5LoyBUbW+W8=;
        b=xmGgHPxl8qFvakUT+Q1yohQh93tgPcqnmzJPRhKW2qoriPkFAkyjeQQ1B9zoi1ONWUza6P6CFUO/+ChUxjPP2kCHW4bCZcQR9jEEC/Uiv7iARBUNsfEi08oFYZMVSaG00BcuScyj3sHwUf+6mrZvdiO2mjowxbD/6kdDfhbFguc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F0giPdwQIFs00GnH+fXALnU1AHnpzdwfSOH02BotIXiFbVfm0KYP+5PB7g5QQ4dCVGQ87BB/FVhhtNCfkcjrEmRFs4oc3oMaOyN/hVAr9M/Kz5T7vCr1qAMeaSjbv1thV+cXBXx7MvXDk/eRwA1QjPUV7TREGUTN6TThRJDzzvY=
Received: by 10.100.134.10 with SMTP id h10mr4272602and.117.1209720190555;
        Fri, 02 May 2008 02:23:10 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 2 May 2008 02:23:10 -0700 (PDT)
In-Reply-To: <20080502081408.GA11420@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80971>

On Fri, May 2, 2008 at 4:14 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> Johannes Schindelin wrote (2008-05-02 08:45 +0100):
>

>  In general, my opinion is that with international text it's better to
>  define word boundary characters than trying to maintain a _huge_ list of
>  characters used within words in different human languages.
>

Agreed, there is no easy way to designate such a huge list of
non-ascii characters. Even if we figure out one way, the user may
still be scared by such a huge list or the character class syntax.

I think doing this complex both the implementation and the representation.

Instead, if using non word characters, the user only needs specify a
small list of characters (ascii or wide character). instead of the
nearly whole set.


-- 
Ping Yin
