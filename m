From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: [RFC] git integrated bugtracking
Date: Tue, 12 Jun 2007 10:54:36 +0200
Message-ID: <8b65902a0706120154n410c1bdbp744198aef070e3f5@mail.gmail.com>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
	 <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
	 <7v4plgb6t6.fsf@assigned-by-dhcp.cox.net>
	 <20070610085044.GD4084@efreet.light.src>
	 <1181587892.3380.37.camel@ld0161-tx32>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 12 10:54:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy29G-0006LS-45
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 10:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbXFLIyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 04:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbXFLIyi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 04:54:38 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:57039 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbXFLIyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 04:54:37 -0400
Received: by an-out-0708.google.com with SMTP id d31so446502and
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 01:54:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dH7+8ggtgqSNGv1U6XjmGmT3CUxfZ9j6AAJD17zbQujD7JDeW27MNhI+XrWIbFCo0walcUv4btrODMAc3hdrXQZqFeb5j0ZN0weeYFvyx3ArNwXHPApL16CqmVhhjhh9dvrs6YQ0QQ62wiq9ZdfFDYpu77ps/MgddDbcJAnDTAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qcjhBCBhR28JhCeWOaUfu57e4YSQkkw99taZrPGM6RjRaVrBT8geXcDcLKv4ibAUB9XcVaid+ZjJcZuWxmG2GCAHzP/GxmLe1NPZUDv1iWKE//fdsFailYpNtI96zpvotrQhEQlStJn+9+qZL8rhJUiP2nMQ3123tYYYKY6yZXU=
Received: by 10.101.14.16 with SMTP id r16mr3856124ani.1181638476758;
        Tue, 12 Jun 2007 01:54:36 -0700 (PDT)
Received: by 10.100.46.11 with HTTP; Tue, 12 Jun 2007 01:54:36 -0700 (PDT)
In-Reply-To: <1181587892.3380.37.camel@ld0161-tx32>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49937>

Hi,

This subject is quite interesting. I read that one of the main
expected goal of integrating SCM and BT is to help release manager in
its task.

In my point of view, we have to keep in mind that it's not because a
commit solved a problem, that all the following commits will always
solve the problem. Development ALWAYS suffers regression. The really
way to avoid this is to have an organisation of code that allows
automatic tests. So it needs something greater than the SCM: you have
to be organized for this.

One interesting project to have a look for is aegis (
http://aegis.sourceforge.net/ ).
It proposes a sort of SCM, that integrates process to ensure quality
of code. One of them is that the /SCM/ will control the non regression
before commiting.

I hope these informations will help defining how we can design a
system that integrates SCM and BT in a distributed manner.
-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
