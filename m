From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: CVS <--> GIT workflow...
Date: Wed, 01 Jul 2009 13:00:39 -0700 (PDT)
Message-ID: <m3d48kw4uz.fsf@localhost.localdomain>
References: <ac3d41850907011132q8e19b37ofa10813258a97555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 22:00:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM5z9-0005ax-QX
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 22:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbZGAUAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 16:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753201AbZGAUAi
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 16:00:38 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35709 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbZGAUAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 16:00:37 -0400
Received: by fxm18 with SMTP id 18so1048266fxm.37
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NQHOlmFasgT7G4JUnuATq1viF2lLwJMZ+KgUJ/y8Cvo=;
        b=vl96kr23Cx0Ezs79PH6gOQQidS1071tp97HzUisGnZibhPoK9UzIcnZwt6JP6p6cDI
         hUZ28a82NxoVao0WOzR7RR5c9c0cZH/+H/66Dgz2JqCaIVnavdlqFRvzMFt6Suu+LKzF
         +GLn4uLy9OFYqijBe5jWgQI0mFIYvNacsUnUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=D9Q+Jl65vSLWArGb20hgCPwad2auR/LnhSyZYSGHWZBpdmr0rS99UnNTf9EU9Hg/Pq
         2UNn4q2J+06P06KLgm2dCn8MInjlc5z0OkQteLI4XaDef71XR2uTaLYoczMfxj41L7ZQ
         1JYCeIIONP9WGSkDJVwcfsndPgW2/z+0u5bx4=
Received: by 10.86.96.17 with SMTP id t17mr4074998fgb.20.1246478440169;
        Wed, 01 Jul 2009 13:00:40 -0700 (PDT)
Received: from localhost.localdomain (abwo245.neoplus.adsl.tpnet.pl [83.8.238.245])
        by mx.google.com with ESMTPS id e20sm12186606fga.10.2009.07.01.13.00.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Jul 2009 13:00:39 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n61K0cKd018781;
	Wed, 1 Jul 2009 22:00:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n61K0bMu018778;
	Wed, 1 Jul 2009 22:00:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ac3d41850907011132q8e19b37ofa10813258a97555@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122596>

David Chanters <david.chanters@googlemail.com> writes:

> I am wondering if there's any best practises/howtos on using CVS and
> Git together.  I have a project which is currently residing in CVS;
> people actively use it to add changes, etc.  Which is fine -- and for
> a variety of reasons we're unable to simply switch away from using CVS
> to Git.
> 
> So... the question is, can I use Git locally to manage all my work in
> -- create topic branches, merge them, etc., and then commit that back
> out to the CVS repository?   Likewise, I would need to keep my Git
> repository in synch with any changes to the CVS repository -- is that
> possible?  Has anyone else done something like this?  What I am
> effectively wanting to do is Git for my entire development on this
> project and just forget it even uses CVS.
> 
> I've read up on git-cvsimport which seems to explain how to convert a
> current CVS repo over to Git -- is that right?  Any information you
> can point me to would be very welcome.  I am not adverse to reading,
> providing it's useful to me.  :)

I think from all CVS importers (git-cvsimport, parsecvs, git mode of
cvs2svn aka. cvs2git) only git-cvsimport has incremental mode.

As for exporting to CVS there is git-cvsexportcommit and git-cvsserver
(which functions like cvsserver, but conects to git repository;
although it has its own limitations).


But you should really hope that your fellow CVS committers use good
practice; because it is quite easy to create very messy CVS repository
(so that for example it would be hard to extract changesets).

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
