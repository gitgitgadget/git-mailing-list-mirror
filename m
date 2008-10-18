From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git graph on GitHub
Date: Sat, 18 Oct 2008 13:56:13 -0700 (PDT)
Message-ID: <m3zll1ipw6.fsf@localhost.localdomain>
References: <530345950810150047v75bfbf9clebbb8a406b172c4c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tom Werner" <pubsub@rubyisawesome.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 22:57:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrIrh-00039Z-CJ
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 22:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbYJRU4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 16:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYJRU4S
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 16:56:18 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:41327 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbYJRU4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 16:56:17 -0400
Received: by ey-out-2122.google.com with SMTP id 6so390461eyi.37
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=9+XVtKxEoHYJi1wSdGD9h43ZbAD5QlFEa1z17CzA3dE=;
        b=hhepU+wdNtYRJuR3Q8phrNh9fDtDE2omu7CEjG2HAhLn0wS/o9srnwLg7Bq71BElb3
         SvNMq1e5mqzsj2Yl8OylKltAFHry+gbVXKB4MMwFc2pVmsaIZj8kCWdTiq+5pnUSnvsV
         shq83XfSmJpBjZGRceAWwFUBeWoGuRrgd4KvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ox12Foa4VEhP91bCCOkrjVOutCvLrD6z3IAkml7Ey3nDdhEpRZy9BwuSGmuMFyqOUI
         P2bu4Ut9URUhDfPA4+4dEZ59Ynnf74On558fDjNiNhuJfPqHoEGNlzSczwqoD5psxjX9
         XYyWLJCItD6mRwcMEXOsyv5y40oXFF42BvGUc=
Received: by 10.210.120.17 with SMTP id s17mr6412016ebc.167.1224363374946;
        Sat, 18 Oct 2008 13:56:14 -0700 (PDT)
Received: from localhost.localdomain (abwr242.neoplus.adsl.tpnet.pl [83.8.241.242])
        by mx.google.com with ESMTPS id 10sm6953676eyd.6.2008.10.18.13.56.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Oct 2008 13:56:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9IKuCaG014657;
	Sat, 18 Oct 2008 22:56:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9IKuAeJ014654;
	Sat, 18 Oct 2008 22:56:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <530345950810150047v75bfbf9clebbb8a406b172c4c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98573>

"Tom Werner" <pubsub@rubyisawesome.com> writes:

> We've just pushed out an update to the Network Graph on GitHub this
> evening that finally allows us to draw very large repositories
> (including Git). We're mirroring the Git repo on the site and I
> thought it might be interesting for people to see this visualization.
> Enjoy!
> 
> http://github.com/git/git/network
> 
> Let me know if you have any ideas for improvements on the graph. I'm
> always looking for ways to enhance it.

First, I wonder a bit why did you choose horizontal layout of revision
graph, instead of displaying it vertically alongside log (log like
view) like graphical history viewers and other web interfaces offering
graphical log, e.g.
  http://lwn.net/Articles/140350/  (gitk screenshoot)
  http://repo.or.cz/git-browser/by-commit.html?r=alt-git.git
  http://people.proekspert.ee/peeter/git/git.php?p=git-git.git
I guess it is because you can show complicated history better, and
because of the "network" feature which is simply not visible for
git.git repository. On the other hand in vertical view you can display
commit subject alongside graph.

Second, the "go to commit" on click doesn't work for me, but perhaps
that is just I have to update my ancient web browser (Mozilla 1.17.2
for Linux, with Shockwave Flash 9.0 r124).  I would expect that after
clicking on commit I would get _whole_ commit message, not only commit
subject (first line / first paragraph of commit message).  Or at least
have some option (keyboard shortcut?) to toggle viewing full commit
message.  BTW. what does having commit sha-1 there give you?  You
can't select it for copy'n'paste, can you?

Third, it is nice to have refs markers for branches, but I wonder why
I cannot see refs markers for _tags_ (so one can easily see what is in
released version, and what isn't).  I also wonder why in commit
description box visible on mouseover you don't have refs markers there
(even if they are turned off for graph, for example for better
visibility because they obscure some line).

By the way, it might be not relevant because while (if I understand
correctly) graphs are ordered by commit date they are not aligned on
time axis, but the timeline of commits for given author on Ohloh looks
quite nice.  (Unfortunately this part of Ohloh is not open source,
although AFAIK it is also in Ruby).  Example:
  https://www.ohloh.net/projects/git/contributors/1194000913727
(but it doesn't use Flash).


Thank you for your work on GitHub  
-- 
Jakub Narebski
Poland
ShadeHawk on #git
