From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit state
Date: Thu, 15 Jan 2009 14:56:22 +0100
Message-ID: <bd6139dc0901150556q674faf80w8891b50addc982@mail.gmail.com>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	 <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de>
	 <496EE74F.6000205@viscovery.net>
	 <200901151101.53441.johan@herland.net>
	 <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com>
	 <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
	 <bd6139dc0901150445l51f3b861n5bbd85bb6d1382b6@mail.gmail.com>
	 <alpine.DEB.1.00.0901151442230.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Anders Melchiorsen" <mail@cup.kalibalik.dk>, gitster@pobox.com
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:58:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSji-0001Na-UG
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbZAON42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757720AbZAON4Z
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:56:25 -0500
Received: from mail-gx0-f21.google.com ([209.85.217.21]:45353 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbZAON4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:56:24 -0500
X-Greylist: delayed 4236 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jan 2009 08:56:24 EST
Received: by gxk14 with SMTP id 14so969700gxk.13
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 05:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=F8ESLvfBnHg2MRKZq8FMjsBkr4p67aWIldVzmiIx0Fw=;
        b=mgAPNT02v6PhH9KQaq8um9xjdy2IR1aM03V7rjhCeRNoC5D3MJh7Qo05/kis8wCJSG
         ej1zLpIJQAb8tDZJkJDDsf8YDMdxv0C/lackQRhvuBUV76SrzzuS1JDh9XXXYsBaYIN0
         t75i2nJ+EtoEnNrRLaA6m4SOBZaS7WksoWGlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=ujCWu5iwmEDHwVfoBJwoo/FFKIpF7qeM+gvmzwyu/bU5UYhzedvt1ypcoBNM3yJ8Ez
         xhvMeogQHgHxbECu2l1d8x++O3iJ8g0jXSD1kzIbAt5+RxoraRBs1JzUktYcP8MlC4Ot
         vxHAQvMYHFfjF7fgmZtouUeZM0ggs6Ev5PI90=
Received: by 10.151.12.1 with SMTP id p1mr4070231ybi.68.1232027782426;
        Thu, 15 Jan 2009 05:56:22 -0800 (PST)
Received: by 10.150.121.4 with HTTP; Thu, 15 Jan 2009 05:56:22 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901151442230.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: 88b481a8fb9918ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105809>

On Thu, Jan 15, 2009 at 14:42, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> So if you want to look but don't touch it, you can do exactly that.
> Brilliant, isn't it?

Yes, ofcourse, but the current edit does allow you to modify (with
'git commit --amend')...
I agree with Johan Herland though, Bikeshedding ftw :).

-- 
Cheers,

Sverre Rabbelier
