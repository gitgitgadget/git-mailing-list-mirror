From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] imap-send: Support SSL using GnuTLS
Date: Wed, 10 Nov 2010 01:39:04 -0600
Message-ID: <20101110073904.GB9211@burratino>
References: <AANLkTim=hL6ONwu1i+xN=N0vJaF21g5PSj5wdjqoEm5c@mail.gmail.com>
 <20101109150941.GD18960@burratino>
 <1289355416.3762.67.camel@tesla>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Miller <mtmiller@ieee.org>
X-From: git-owner@vger.kernel.org Wed Nov 10 08:40:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG5IZ-0006xm-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 08:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab0KJHjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 02:39:24 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56754 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab0KJHjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 02:39:24 -0500
Received: by gwj21 with SMTP id 21so156641gwj.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 23:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JcTy4vjL8r6sDiqs5YpwNyv4rE1MNWT5IbfUNHm7XRk=;
        b=V/XcUvHpnerT9/4VXDhf05hlihgO8EgVUbr6ceCFNDajQNmOa+RRB7y2aYFUyTEntA
         1dricitQWMCvwS2Hun+xsHx227x0FQumvY9JjNeQAGBtA1ce7N1I3mN58/A+z9Z29Dzg
         i7GGYEfsdBnHuSm5ipKzTdihIJcnQqvJduuhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UmsCBNQ8FhEncZkgVHVKQsDo926+amOVrFCQTNBsQGVOyUbaK2JXnEDYl1n5yx5Za2
         Vzk16M5TV2dujvijGHNLHgClkXg6cShncPRgC7pxADZMMcuitMPnaYib/9FSTmwl+ZSg
         4QaeX/4KcqWUuEEqGKeDbJJGIAGV+gsf4qrDI=
Received: by 10.151.150.11 with SMTP id c11mr3831246ybo.413.1289374763027;
        Tue, 09 Nov 2010 23:39:23 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r18sm349945yba.15.2010.11.09.23.39.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 23:39:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289355416.3762.67.camel@tesla>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161133>

Hi Mike,

Mike Miller wrote:

>           I'm definitely willing to pull out the relevant parts and
> forward them to the respective projects to keep this moving.

That's great to hear.  FWIW, although feedback from that direction
would indeed help keep this moving, there is no need to wait for a
release including your changes before moving forward on the git side.
It might not be a bad idea to include workarounds in git until
upstream changes have had some years to percolate to user systems
anyway.

Cheers,
Jonathan
