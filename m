From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [spf:guess,iffy] Re: "Integrated Web Client for git" GSoC proposal
Date: Sat, 17 Apr 2010 05:50:57 -0700 (PDT)
Message-ID: <m3vdbqdz1b.fsf@localhost.localdomain>
References: <201004130403.42179.chriscool@tuxfamily.org>
	<201004150204.42813.jnareb@gmail.com>
	<1271293123.6248.147.camel@denix>
	<201004161118.32163.jnareb@gmail.com> <1271473792.3506.30.camel@denix>
	<loom.20100417T081957-371@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Petr Baudis <pasky@ucw.cz>,
	John Hawley <warthog9@eaglescrag.net>
To: Tatsuhiko Miyagawa <miyagawa@bulknews.net>
X-From: git-owner@vger.kernel.org Sat Apr 17 14:51:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O37UT-0000iZ-BD
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 14:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314Ab0DQMvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 08:51:00 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:35881 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab0DQMu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 08:50:59 -0400
Received: by wwb24 with SMTP id 24so1677668wwb.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7o+kPDXKhWduLwFehZsHLWst0TZMXBsbdIhVc3eSU4Q=;
        b=igWshngiXWLEcFPiLSEbJm0PruaNF9VLQWErGdkYxUrvxyqbWfVUXB7yLQwhQYLj+U
         K8rK/9Yy7bRgl+GHk2eRiZvF3VVm9GWTShXiJ8G1rMJqUsqezEAS1l/FpwPkVoaYAzxM
         NAdQNMJAFtg9farV8kPb2iFWSTuUkvfB7UXb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hYHvIHr4n38vgymm+nVtnmY8BLjwNC9H5kwofOJOwZQ91jc7HmHbSsA5rnwyhMMYQF
         FRG8JUQsjCosOSbz4bRTgArAxy1SgZPcyJ0rZxIxJgobhaocCflbZR9erYiCw67Cb4Vs
         6zUtXJgXcwYaymbMuhAPWjyBxOBCqONmP2OdA=
Received: by 10.216.85.198 with SMTP id u48mr3539086wee.225.1271508658101;
        Sat, 17 Apr 2010 05:50:58 -0700 (PDT)
Received: from localhost.localdomain (abvc197.neoplus.adsl.tpnet.pl [83.8.200.197])
        by mx.google.com with ESMTPS id t27sm30009668wbc.5.2010.04.17.05.50.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 05:50:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3HCo91L030550;
	Sat, 17 Apr 2010 14:50:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3HCnbvJ030536;
	Sat, 17 Apr 2010 14:49:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20100417T081957-371@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145143>

Restored some of Cc list...

Tatsuhiko Miyagawa <miyagawa@bulknews.net> writes:

> Sam Vilain <sam <at> vilain.net> writes:

> > It should be possible for the script to figure out what filesystem path it
> > is being run from, perhaps find a local lib/ dir and then add that to @INC.

FindBin, Dir::Self (or just relevant code from it), and then "use lib <dir>".

> > In shell scripts you just use FindBin, I don't know whether that is still
> > expected to work from eg mod_perl but there's bound to be a solution for
> > that.  So yeah I'd say just aim to ship lots of .pm files in a nearby dir
> > alongside the script...
> 
> Or use App::FatPacker.

But try to make this build-time dependency optional.  I wonder also
what is performance cost of using App::FatPacker trick.


It is a bit pity that PAR is not in core.  We could use 

  $ git archive --format=zip --output=gitweb.par --prefix=lib/ \
    HEAD -- gitweb/lib

to generate packfile, and then

  use PAR 'gitweb.par';

in gitweb.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
