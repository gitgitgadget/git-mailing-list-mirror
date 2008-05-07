From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: How can I specify multiple refs on one line in the config file?
Date: Wed, 7 May 2008 23:38:09 +0100
Message-ID: <18071eea0805071538w1e898ebalf4166b08fe7cfac3@mail.gmail.com>
References: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com>
	 <18071eea0805071433j5bde8868w305d9a80c00bd2bd@mail.gmail.com>
	 <588192970805071519i76c23367ue497e37445fa7c74@mail.gmail.com>
	 <20080507222751.GC23672@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Steve Hoelzer" <shoelzer@gmail.com>,
	"Thomas Adam" <thomas.adam22@gmail.com>,
	"git mailing list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 08 00:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtsIQ-0004HP-CS
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759041AbYEGWiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758354AbYEGWiW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:38:22 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:2059 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763872AbYEGWiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:38:15 -0400
Received: by fk-out-0910.google.com with SMTP id 18so511503fkq.5
        for <git@vger.kernel.org>; Wed, 07 May 2008 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=puQQUg0zWVeZFQadWksdlBfzWrMGcRu8gdxLvzxs1jE=;
        b=XKGnu5YNdi+D7eitOAsYZbsh0QLB3rKO/JZLYa3T4iewVK/gKSIi14GPfNCUz3whsit/7Z5Cg+hvsW3fOcjZbtpKW8UtzVnIIU6gnEbRnoJInVxO3UxKvxNsdmp6Gzt70qSqYuc5FfGqaCj2RLc6dhZUo2IcUHWuraX2vjGRrog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t1RcRBzxcYeNllp/rc0RNVhp8BcXmHG1TPaTAEaKS6meb0/+jtHWI7RYnt5xcOUKAuG5fuvF6gyWcBprOycjK64YrsGspkvNlRLytLqbB2Zs1oEMt2VQi+kvBpTNvqJhQtO+K/TkSMRTCTYSrIGCDjDD3ngkgFyWSa+hoCvnU6s=
Received: by 10.82.126.5 with SMTP id y5mr325368buc.89.1210199889456;
        Wed, 07 May 2008 15:38:09 -0700 (PDT)
Received: by 10.82.170.5 with HTTP; Wed, 7 May 2008 15:38:09 -0700 (PDT)
In-Reply-To: <20080507222751.GC23672@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81488>

2008/5/7 Miklos Vajna <vmiklos@frugalware.org>:
>
> On Wed, May 07, 2008 at 05:19:30PM -0500, Steve Hoelzer <shoelzer@gmail.com> wrote:
>  > On Wed, May 7, 2008 at 4:33 PM, Thomas Adam <thomas.adam22@gmail.com> wrote:
>  > > I might be misunderstanding you, but to push tags, there's:
>  > >
>  > > git push --tags
>  >
>  > True, but I only want to type "git push". No, it's not _really_
>  > necessary, but I'd like to set it up that way so I don't have to
>  > depend on my coworkers (new git users) remembering "--tags".
>
>  are you sure pushing tags by default is a good idea? people regularly
>  create local tags to mark a commit before a rebase, to mark a commit as
>  a fix for a given bug, etc. those tags aren't interesting for others.
>  tags which should be pushed usually rare. then you can use git push
>  origin tag v1.0, since you know which tag you really want to push.

Probably not, which is why '--tags' exists in the first place.  But
then if you're working from a shared repository (which I am -- as are
many, no doubt in a corporate environment) it's rather useful.  I
would find local tags though to be odd.

-- Thomas Adam
