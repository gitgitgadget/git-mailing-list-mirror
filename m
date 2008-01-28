From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Configuration overrides via environment variable
Date: Tue, 29 Jan 2008 10:11:05 +1100
Message-ID: <ee77f5c20801281511md7bdeeme383a140fdc854ec@mail.gmail.com>
References: <ee77f5c20801271708k124dc9d7n942b3c95299cb7fb@mail.gmail.com>
	 <20080128205837.GB5788@efreet.light.src>
	 <m3tzkx8smg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>, "Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 00:12:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJd9K-0006GC-JG
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 00:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764116AbYA1XLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 18:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763283AbYA1XLK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 18:11:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:22073 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762261AbYA1XLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 18:11:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1836819rvb.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 15:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7D0XTgauJGJvpRBLjVq0JOudmkPjiWUdzDTTEcn/bic=;
        b=nXNxmd8lV9/iTYMSJGUKx3JTwCb6ZF6x7+zNt0cJWftuM/wEyJkhJsP5D5+fa7YhuY9ZMrzEnCCbi9Rho1aUdU1Aqroc0uZoEASPTVoeFvlblwwvNIL6qBd6P1CjBe0KI1EL8UJRfrZhf2/IizL/FRjOQncCLSmU6mPPgXKNOtk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iAOCPQEd9qyKA5+Zn/Fooy3IGuc+w2Np06LZgw4daTPNFMX3J8C8b3iSTfncNc5kJscCmlb569Prk+e8PmPXqd1MJcLaHEg97UQ7/g20P9xVWe9Y+s7f/H8ulgFDh8U3dwFbwIlTo6gfWMQpoZswkhtSNen5Jc+NehDhxa45G74=
Received: by 10.141.37.8 with SMTP id p8mr3859777rvj.150.1201561865472;
        Mon, 28 Jan 2008 15:11:05 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Mon, 28 Jan 2008 15:11:05 -0800 (PST)
In-Reply-To: <m3tzkx8smg.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71907>

On Jan 29, 2008 9:58 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Jan Hudec <bulb@ucw.cz> writes:
>
> > On Mon, Jan 28, 2008 at 12:08:10 +1100, David Symonds wrote:
> > >
> > > I'm using Git in some scripts, and wanted to get its colorised output
> > > even when it is not going to a tty. I don't want to permanently change
> > > ~/.gitconfig or the per-repo config; I just want to set color.status
> > > (and perhaps others) to "always" for a one-off run. I suppose I could
> > > munge the config files, storing the previous value and restoring it
> > > later, but that's messy.
>
> Cannot you just use --color option?

My version of Git (1.5.3.8) doesn't have a --color option for
git-status, and I can't find support for it in 'next', either. It
would be ideal if there was a --color option, though.


Dave.
