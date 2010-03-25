From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Subversion integration with git
Date: Thu, 25 Mar 2010 23:22:17 +0530
Message-ID: <f3271551003251052j5863af46i3066f0f42788ba3b@mail.gmail.com>
References: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com> 
	<40aa078e1003250731y2c900605k9c681475621a1ff2@mail.gmail.com> 
	<E560EF9A-AF07-4316-9047-6D1A1802F743@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 18:52:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NurEe-0004HI-OC
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 18:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab0CYRwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 13:52:43 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:34905 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab0CYRwm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 13:52:42 -0400
Received: by iwn40 with SMTP id 40so1268617iwn.1
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=xVJN+mISQVN5GuF+0+5hPTBnJG8bR8v3jLnwoFntG/g=;
        b=t353yqhpqqvgUXekX7/yBU2SO771tbMOt5HUfgxwumARuYqP3aaqKpLY8Tp0D3XbMp
         B4PhXqPrxCOafTVGG+jeev3Go5p8RI5G8DvuYe1yu1w09A+cNZ0wxOUMOJeYOsqAgby/
         4DRsgBQ1ix39cb+oJCxA4UJUOSyWFVrh7RQcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=EXP+s5oWlGua8AheI/9WyhLrRRoEjmAv1FMvGdVqQ7+awY7louUMHrtT+lCtT/Rx52
         POTKJjGtbdn8jzYBOEPFU++Arrj6NWvy08JUSYHmaunZSkfgCZEOft2PVFNCR3JvxOiQ
         zq/AJaEFKL5beCAwUSKBw/4ZeDy52HIuSssDA=
Received: by 10.142.247.20 with SMTP id u20mr5467358wfh.209.1269539561262; 
	Thu, 25 Mar 2010 10:52:41 -0700 (PDT)
In-Reply-To: <E560EF9A-AF07-4316-9047-6D1A1802F743@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143187>

Hi,

> I think it falls very close to the native-git-svn Google SoC
> project[1], and if you are able to share what you have I'm sure
> Ramkumar (I hope you don't mind me CC'ing you, and that I spelled your
> name right) would appreciate having a look.

Yes. Thank you for CC'ing me, Erik.

> Is it worthwhile to start a new project - or would it be better to grok the internals of existing projects and try to make them scale?

Honestly, I've just started looking into this issue, so I'll wait for
someone else to comment on this. As far as interest is concerned, yes-
a lot of people seem to be pretty excited about my GSoC project
proposal [1]. My proposal has more to do with getting native support
working, than building a fantastic SVN importer. I certainly have
neither the time or experience to build an SVN importer that's any
better than git-svn.perl in the summer term, and I'm clear that I
don't intend to do this. However, if my proposal gets accepted, I
could work with you to get it integrated into the remote helper that
I'll be building. Depending on the complexity of your project, this
might only be possible at the end of my GSoC term.

[1] http://thread.gmane.org/gmane.comp.version-control.git/142623

-- Ram
