From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: Whitespace cleanup - tabs are for indent, spaces are for align (2)
Date: Sun, 22 Oct 2006 23:27:01 +0200
Message-ID: <200610222327.01840.jnareb@gmail.com>
References: <200610211750.49188.jnareb@gmail.com> <200610222236.45414.jnareb@gmail.com> <Pine.LNX.4.64.0610221359090.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 23:26:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbkqI-0001r6-6Q
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 23:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWJVV0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 17:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJVV0q
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 17:26:46 -0400
Received: from hu-out-0506.google.com ([72.14.214.237]:6988 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750751AbWJVV0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 17:26:46 -0400
Received: by hu-out-0506.google.com with SMTP id 28so892416hub
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 14:26:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=k3ttoeVmj9P6i5ghcRiYOv23wKj8g1qkpElL/smkVJRivAxF1JX9TRdmekHVkZ4MfVRqOZSpcx1eDF8EIqo8lvDvYPwpeZ4z4utkVVZ7mJF3NpaZnC+DnuqSKFIL7tOz+Tz0cC3YBfS9donEf2iSjD12KSxYrrIYzJxl3dgrgpI=
Received: by 10.67.103.7 with SMTP id f7mr6135123ugm;
        Sun, 22 Oct 2006 14:26:44 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 5sm1443968ugc.2006.10.22.14.26.44;
        Sun, 22 Oct 2006 14:26:44 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0610221359090.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29795>

Linus Torvalds wrote:
> 
> On Sun, 22 Oct 2006, Jakub Narebski wrote:
> > 
> > To be true I do those "whitespace cleanup" patches when I notice
> > that something is mis-aligned for _my_ tab width (2 spaces).
> 
> Oh, wow.
> 
> You have clearly been damaged by some nasty GNU coding style or similar.
> 
> Please immediately turn tabs into 8 character hard-tabs, and read the 
> kernel Documentation/CodingStyle document.

2 character wide spaces are minimal width indent one can work with.
And to reduce line width I use the minimal indent with. Yes, I know
that I should correct coding style instead...

Using 2 characters wide tabs for gitweb stems also from the fact
that I could not configure Emacs and cperl-mode to automatically
indent with tabs (probably because many Emacsers think that
TabsAreEvil); I should probably set some indent/offset variable
to the tab-width value, or something...
-- 
Jakub Narebski
Poland
