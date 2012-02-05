From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Installing git-svn on Linux without root
Date: Sun, 5 Feb 2012 11:11:59 +0100
Message-ID: <201202051112.00392.jnareb@gmail.com>
References: <35EF289A-1408-4B70-A25F-8194A8884A4D@kellerfarm.com> <m3mx8yltq9.fsf@localhost.localdomain> <AD682311-372A-4AED-B575-E77EB862ABD8@kellerfarm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Keller <andrew@kellerfarm.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 11:12:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rtz4q-0001pN-55
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 11:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab2BEKMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 05:12:03 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50538 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab2BEKMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 05:12:00 -0500
Received: by eaah12 with SMTP id h12so2087977eaa.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=YcFA0SHf4WAcxrYWNxR09eKyFZR3K9yglTfeQNqhoVc=;
        b=WkNYDRVSpSle2khTlNoxO7/DG4tfSq3ifY+QbeGXXdmR+CwGYZj5bYwerYi6Gyhky+
         is7Hm4XnigGF6xEVNUWKzzvBsMMjoRlIVLrY0Ay7ROFDeJIh5CzaeBuZUX0DhzwTuT2T
         Q9Ijp6ugJaoP7QNnon3SRJgf3txGtigfWuq9s=
Received: by 10.213.2.142 with SMTP id 14mr2243137ebj.15.1328436719831;
        Sun, 05 Feb 2012 02:11:59 -0800 (PST)
Received: from [192.168.1.13] (abwp204.neoplus.adsl.tpnet.pl. [83.8.239.204])
        by mx.google.com with ESMTPS id c16sm46288474eei.1.2012.02.05.02.11.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 02:11:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AD682311-372A-4AED-B575-E77EB862ABD8@kellerfarm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189937>

Andrew Keller wrote:
> On Feb 4, 2012, at 6:32 AM, Jakub Narebski wrote:
> > Andrew Keller <andrew@kellerfarm.com> writes:

> > > So, the module does exist, but not in a location included by @INC.
> > 
> > From the above error message it looks like
> > 
> >  /homedirs/kelleran/local/lib/perl5/site_perl/5.8.8
> > 
> > is in @INC, but
> >  /homedirs/kelleran/local/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/
> > 
> > is not.  Strange.
> > 
> > Do you use local::lib?
> 
> No - Where should I use it?

local::lib is a way to install Perl modules / packages e.g. in your
home directory.  Please read and follow the instructions on local::lib
manpage ("The bootstrapping technique" section):

  http://search.cpan.org/~apeiron/local-lib-1.008004/lib/local/lib.pm

Then you can install Alien::SVN (or any other Perl package) using
'cpan' client (or intstall 'cpanm' / 'App::cpanminus').

HTH
-- 
Jakub Narebski
Poland
