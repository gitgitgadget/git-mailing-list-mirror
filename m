From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Fwd: Re: GiT and CentOS 5.2]
Date: Tue, 08 Jul 2008 12:12:48 -0700 (PDT)
Message-ID: <m3prpodwb9.fsf@localhost.localdomain>
References: <50493.216.185.71.22.1215543081.squirrel@webmail.harte-lyne.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "James B. Byrne" <byrnejb@harte-lyne.ca>
X-From: git-owner@vger.kernel.org Tue Jul 08 21:13:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGIdK-0006A9-4p
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 21:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbYGHTMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 15:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752441AbYGHTMv
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 15:12:51 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:16824 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYGHTMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 15:12:51 -0400
Received: by an-out-0708.google.com with SMTP id d40so536971and.103
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=CRD0W4UKZNSv443enQvNPnCJFWualS9zLunaMTzdS1o=;
        b=jQlxiF0+actgV9epzApDZDF9Ug4VYqOsCzrLue/l8djTZ6srnkYlywfZjngjB8vH3O
         nMVhSeEI9uiFE0qInqduOhnGq/fVpQkxenv45dy2bu2TaXiWfkXTuYtcJrrCq0c61sLo
         37gJduzkmAYeWCNegNHJZ2qqRIX+NbCBOwp2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ukUtdAYp75/Jt1W3Slo+Hd8UWm3y4gBnjpbgsjqdK5aI/MUNX8h38HP+5mDCW8HKxJ
         drXaBepcM5IyBcmlC27yJWo5ULZke598dOWuy1872JoXcLE6Md57350xCdu5Rpz+hAJC
         Lg4lj2OeOHDs9PamQ1H8MNML6wspP6VWKQEbc=
Received: by 10.100.143.12 with SMTP id q12mr5523873and.19.1215544369878;
        Tue, 08 Jul 2008 12:12:49 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.205.145])
        by mx.google.com with ESMTPS id d36sm4592340and.8.2008.07.08.12.12.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Jul 2008 12:12:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m68JCkbU018093;
	Tue, 8 Jul 2008 21:12:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m68JChYf018087;
	Tue, 8 Jul 2008 21:12:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <50493.216.185.71.22.1215543081.squirrel@webmail.harte-lyne.ca>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87786>

"James B. Byrne" <byrnejb@harte-lyne.ca> writes:

> On Tue, July 8, 2008 14:37, Mike Hommey wrote: 
> >
> > This only means the rpms in the yum repository at kernel.org were built
> > on a system more recent than yours, and that run-time dependencies (as
> > opposed to build dependencies) require some libraries to be newer than
> > what your system provides.
> 
> I understand the meaning of the error messages.  What I am asking is
> whether or not any of these dependencies is substantive.  If they are then
> I am stuck at the immediately previous release of Git. If not then I have
> the option to either build from source or force an rpm update.  If I force
> then I can no long use yum but at least I have the applicate managed by
> rpm.  If I build from source then I lose that as well.
> 
> So, my question still remains: are these dependencies only artifacts of
> the build environment or do they supply actual features that the latest
> release of Git depends upon and which are not available in the earlier
> version of the software?

They are artifact of the build environment (which picks up the
libraries that they are here); till 1.5.6.1 I have compiled git
and used git succesfully on Fedora Core 4 based dostribution
(Aurox 11.1).

I am now compiling[1] 1.5.6.2, and so far don't have any problems
(now it is at building documentation; it would be nice to be
able to use pre-build documentation from SRPM).

[1] $ rpmbuild --rebuild git-1.5.6.2-1.fc9.src.rpm
-- 
Jakub Narebski
Poland
ShadeHawk on #git
