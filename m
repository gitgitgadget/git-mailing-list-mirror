From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb and remote branches
Date: Fri, 31 Aug 2007 01:59:19 +0200
Message-ID: <cb7bb73a0708301659q6ccc1211w2c7ce315051a605e@mail.gmail.com>
References: <favitd$3ff$1@sea.gmane.org>
	 <7vbqco91fi.fsf@gitster.siamese.dyndns.org>
	 <cb7bb73a0708301609s330f8d6fna3755bff346452ab@mail.gmail.com>
	 <200708310153.29625.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 01:59:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQtvK-0006AS-Fg
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 01:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172AbXH3X7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 19:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757061AbXH3X7V
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 19:59:21 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:3044 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbXH3X7U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 19:59:20 -0400
Received: by py-out-1112.google.com with SMTP id u77so3153156pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 16:59:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mhJ1ue+fsG0oLyxbq3J9Vy8GMwosfuToTk339YmJXc7NioA7Mmy1ZlAMjpH0Ll5sQMWwFJfDL0PXp2bsHM9IdOrxFNlBSrXrwL150I5tdkC+x7DsSWCfjt+aJdf131ASs8Ko6xQflcLcWLKex6AySOhz6xdkwaCsgoCfDiQP/yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dl1hZVochc6pKpihESRPL0v7zOq+SSDD6woyKC0MlpDoAiEXQgQi3UVCsfEz0fEb2y069VlpDpKq12s/f/vwO2YosO0h1oRybHyDUQXezRLlzRtb+bvW92HCwRSNFIRIZZuxdHVMl9wSyHUKiI2TBI+qMS4EVdBbOdW41ykP2a4=
Received: by 10.35.62.19 with SMTP id p19mr1249296pyk.1188518359992;
        Thu, 30 Aug 2007 16:59:19 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Thu, 30 Aug 2007 16:59:19 -0700 (PDT)
In-Reply-To: <200708310153.29625.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57095>

On 8/31/07, Jakub Narebski <jnareb@gmail.com> wrote:
> On Fri, 31 August 2007, Giuseppe Bilotta wrote:
> > If I understand correctly, a detached HEAD is simply a checkout in the
> > middle of a branch, and thus not named. So what exactly are we looking
> > for when we talk about supporting a detached HEAD? Would it be enough
> > to display HEAD in the list of heads?
>
> I think we want display HEAD in the list of heads if it is detached,
> and also use it as a ref marker, while only marking (with undeline or
> bold style) current head as such if HEAD is not detached, i.e. is
> symref or symlink.

I thought so.

Of course, I've just discovered that for-each-ref ignores HEAD, so I
have to do it the hard route ...

-- 
Giuseppe "Oblomov" Bilotta
