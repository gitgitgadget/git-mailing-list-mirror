From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support the rel=vcs microformat
Date: Fri, 09 Jan 2009 16:01:59 -0800 (PST)
Message-ID: <m3k594111k.fsf@localhost.localdomain>
References: <20090107042518.GB24735@gnu.kitenet.net>
	<gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net>
	<cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com>
	<20090107184113.GA31795@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 01:04:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLRK8-0000Qg-6O
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 01:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757803AbZAJACI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 19:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbZAJACG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 19:02:06 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:54321 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757754AbZAJACE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 19:02:04 -0500
Received: by ewy10 with SMTP id 10so10507796ewy.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 16:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=GT1Ah6A2/X3I4SICwYKQ6uzQrm2zQH7UQA/Gbr5h6lY=;
        b=eL2FA46pi4sae3EMnh+j0LWJWrhShrMqCykZeRmPWzjUd8aR7Y18JTQDFG0r/RYwIW
         K+u/3Rgth9EaKq2JWjAiQypwttnD1P7S2m6kdWTIsUhj41ljI29L03mFe/d2FJAfvKw1
         tVeKd8dj+tnV1NoA4TajNmb3+ThCRT3IKKS5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=VpeQD2xK3YjzIPLKBK4reSv4LZBVI3ad0cRUrsL3Q1qwVMSV4BZqxM5thavK4jK0rT
         Fhg8VHI+HEYoNaBldzvIpZ6sBMb6q6mIC/dKKeT4+Bj31jxq4rXPVl5YMMH7R/rvqBvB
         N4hQmmLdc9oSXsS1vlEN48JV6H5K8uIWF4ZTI=
Received: by 10.210.71.11 with SMTP id t11mr30918987eba.26.1231545721105;
        Fri, 09 Jan 2009 16:02:01 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id b33sm6635832ika.17.2009.01.09.16.01.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 16:01:59 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n0A020aM028267;
	Sat, 10 Jan 2009 01:02:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n0A01xAP028264;
	Sat, 10 Jan 2009 01:01:59 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090107184113.GA31795@gnu.kitenet.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105048>

Joey Hess <joey@kitenet.net> writes:
> Giuseppe Bilotta wrote:
> > Joey Hess <joey@kitenet.net> writes:

> > > Thanks for the feedback. There are some changes happening to the
> > > microformat that should make gitweb's job slightly easier, I'll respin
> > > the patch soon.
> > 
> > Let me know about this too, I very much like the idea of this microformat.
> 
> FYI, I've updated the microformat's page with the changes. The
> significant one for gitweb is that it can now be applied to <a> links.
> So on the project page, the display of the git URL could be converted to
> a link using the microformat, and there's no need to get the info
> earlier to put it in the header. Unfortunatly, the same can't be done to
> the project list page, unless it's changed to have "git" links as seen
> on vger.kernel.org's gitweb.

I'm not sure if making repository URLs to be hyperlinks is a good
idea.  You cannot (should not) click on those in ordinary web browser;
they are to be used by git (that is also additional reason why I am
not so sure about 'git' link on projects_list page idea).

Besides LINK elements in page HEAD are meant mainly for machine; I
think it might be more important to add them for machine there, even
if they are as A elements (links) or just plain text URLs somewhere
else.  For example we have LINK elements with alternate versions,
among others OPML for projectless pages, and RSS/Atom for project
pages, aven though those links are also in page body.

So I'd rather have them LINKs...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
