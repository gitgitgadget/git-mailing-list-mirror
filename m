From: "Mike Gant" <mwgant@gmail.com>
Subject: Re: git clone operation
Date: Tue, 19 Aug 2008 20:27:18 -0600
Message-ID: <8f282e3b0808191927t7c202a2dvdff678bcec60d87f@mail.gmail.com>
References: <20080817184443.GA11782@mg1.gantsfort.com>
	 <m3wsifsawl.fsf@localhost.localdomain>
	 <20080817193833.GA29469@atjola.homenet>
	 <8f282e3b0808191923w18001cc6sef828d94b35e40c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 04:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVdQv-0003on-OW
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 04:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYHTC1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 22:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753580AbYHTC1U
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 22:27:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:30693 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbYHTC1T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 22:27:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so255215rvb.1
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 19:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=M99/Tc4oxRTUDg796oFELJDJb0j5du09cr2yYTi6F3w=;
        b=Vbt5pOcq6IW0jIAAavuEe8kiJges/syrLWSvNv/j7P1lFWHdQ3uWtfJ+aWc9gLz6TT
         aiVN8EzTAXKNXwJwMYcyl4Voy8cw2ClI65VlyspTMn83v6vHPNDS5Y1cbSe1a9eNUbqd
         PPBSa59CPr6G6zetG0WLfGMnafyEHXddU7Y3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IabbPYxgJZjdvtytfnQ1eUJroRJIQpd9CZ+MqkkPwEUY2DXo4QVVLdPLNZoue27AFe
         0S52+BJ/GaMxbAXDiyybge/n/r2XkzwqOEuoLuDcSfrRnRpUqSwVzoGCbdQf75su6m0D
         diZEHcG4LhyyiHEw7esLNsJy8IDzVHfeScBsU=
Received: by 10.114.177.1 with SMTP id z1mr7442504wae.226.1219199238787;
        Tue, 19 Aug 2008 19:27:18 -0700 (PDT)
Received: by 10.115.108.8 with HTTP; Tue, 19 Aug 2008 19:27:18 -0700 (PDT)
In-Reply-To: <8f282e3b0808191923w18001cc6sef828d94b35e40c6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92951>

> Thanks for your responses. I appreciate you guys taking the time to answer.
>
> After thinking about this, I still don't understand when I clone a
> repo why I will
> get the equivalent of whatever branch is active at the time of cloning? What
> was the process that led to this design decision?
>
> So that also got me thinking about work flows with git. Because of the way clone
> works it seems that you wouldn't want someone to clone your every day "work"
> repository? So do developers generally have a separate repository that they push
> to and others can clone? This repository may have only a 'master' branch (but
> probably others I seem to recall Junio describing other branches in the main git
> repository). Is this a 'normal' work flow?
>
> Thanks,
> Mike Gant
>

Also, I meant to add if the above work flow is the git way of
development, is this
the purpose of a bare repository?
