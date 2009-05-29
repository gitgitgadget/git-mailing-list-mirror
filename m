From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Managing submodules on large multi-user projects
Date: Fri, 29 May 2009 15:53:26 -0400
Message-ID: <32541b130905291253k3fa1d675yde1dddb5e8090ef9@mail.gmail.com>
References: <20090529184125.GE11222@starfruit.corp.slide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Fri May 29 21:53:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA89M-0002u6-BS
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 21:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbZE2Txq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 15:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752899AbZE2Txp
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 15:53:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:8773 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142AbZE2Txp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 15:53:45 -0400
Received: by yx-out-2324.google.com with SMTP id 3so3461557yxj.1
        for <git@vger.kernel.org>; Fri, 29 May 2009 12:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=e9+GMPWSpGSvWKNxGtuxkXrq3/a6j1cNwL5lnSB//RE=;
        b=eahUrnblps/aTOaVxQvAKspiAqaX9bHPMTSz2KUU+dvr9XQHwkLzp0gsbe7UeMJTMT
         mfXj6EQPP2HcbtZF2ikEX2pOdo3pc/4Qb/bYSGUEjnUodgEaA68QuIhrwEWp0c9+u4gr
         /OomtcLeoUa9fwrEcLTAXFiMpd0uyeN62MEyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=djk+K+WNLAnx3MCQc5OF2OS0UNJ8WFlYoCIwDB1xStVEz6vrQBivzh8PJS9zmDFEte
         bDrq38tF2mDwrqwz7EmKn5ciqnPWttg9FkUJDd1X+jpX6cxVEf6k/DeZNHvMDv0ouQKD
         5h/F8YITgMCz2gF6qaQI4Ha8GUraKXJ17Diz0=
Received: by 10.151.119.12 with SMTP id w12mr5838383ybm.191.1243626826106; 
	Fri, 29 May 2009 12:53:46 -0700 (PDT)
In-Reply-To: <20090529184125.GE11222@starfruit.corp.slide.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120307>

On Fri, May 29, 2009 at 2:41 PM, R. Tyler Ballance <tyler@slide.com> wrote:
> As some of you may recall from my last swath of emails to the list
> regarding memory usage and repository size, we have quite a large
> repository. About a month ago, I added a submodule to the primary repo
> in an effort to start to segment where possible, particularly around
> third party modules.
>
> I've noticed that keeping submodules updated is an absolute pain,
> particularly with a large multiuser setup with *lots* of branches.

Just so I understand, is the reason you're splitting into submodules
*just* to avoid memory usage / repository size issues?  I can sort of
understand the memory usage issues - sort of - but how does it reduce
repository size if you need to need to check out all the submodule
repositories along with the main project anyway?

Just looking to clarify for myself.  (I'm continuing my work on
git-subtree, which is getting more and more positive feedback.  It
solves all the *other* problems that you listed vs. submodules, but it
certainly doesn't resolve any repository size issues.)

Have fun,

Avery
