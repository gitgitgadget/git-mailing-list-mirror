From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 07:22:59 -0700 (PDT)
Message-ID: <m3abhpqusj.fsf@localhost.localdomain>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Denis Bueno" <dbueno@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:24:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7AC8-0005Ks-Hn
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbYFMOXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbYFMOXE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:23:04 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:26612 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbYFMOXC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:23:02 -0400
Received: by ik-out-1112.google.com with SMTP id c28so3019355ika.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=7Xm1thM8GrnrMQnqdJh5iByqgng1ehTrZrQIAT0vBwQ=;
        b=OEdSvUzsMXimIb4zDYrHRQUjNgHa57C2ldI7ca652YtBdv2dzpuZnLuai0kOU5fT8y
         sRMnhSonajUwQScZL1hrGqh3j6qHELpEo185XMKE/qtvztIL6XCrVGeFPjsnv+fFusxZ
         A2E95/Hi8TuQLfqKH7sAdbZnEumgvK8j9/+Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=hExiUJLGazBPrywn3Q0gtiWm9MMryUEy6D48wFmvjDbdmT/UN1grLF/hVC6bcbVzVk
         W7RFaUt86tIZBLfzjXMOui8XOWEo/NTxsflCTrVlj7dsJJ3Tj/pagyrBM3Z7nefx/yLF
         yq8Vk2mm48uv80YPlISnDFoMqVgDH9D+fwjtE=
Received: by 10.210.90.10 with SMTP id n10mr2608558ebb.179.1213366980558;
        Fri, 13 Jun 2008 07:23:00 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.221.64])
        by mx.google.com with ESMTPS id z33sm3673146ikz.0.2008.06.13.07.22.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 07:22:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5DEMVHJ009472;
	Fri, 13 Jun 2008 16:22:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5DEMKRG009468;
	Fri, 13 Jun 2008 16:22:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84881>

"Denis Bueno" <dbueno@gmail.com> writes:

> I'm on OS X 10.4.11 on Intel using git 1.5.5.3.
> 
> I'd been trying to use the git-instaweb script (both with and without
> arguments) with lighttpd (which I installed through Macports) without
> success, seeing the following kind of bizarre error message:
> 
>     funsat[290] > git instaweb
>     /opt/local/bin/git-instaweb: line 6033: /usr/bin/env perl: No such
> file or directory
>     2008-06-13 09:09:31: (log.c.75) server started
> 
>     funsat[291] > 2008-06-13 09:09:31: (mod_cgi.c.998) CGI failed:
> Exec format error /Volumes/work/funsat/.git/gitweb/gitweb.cgi
>     mod_cgi.c.1001: aborted
>     2008-06-13 09:09:31: (mod_cgi.c.584) cgi died, pid: 23237
> 
> "/usr/bin/env perl: No such file or directory"? Huh?  I certainly have
> perl installed, so I don't know what that's about.
> 
> That line simply calls perl by the $PERL variable, which is set at the
> top of the script, like so:
> 
>     PERL='/usr/bin/env perl'

This depends on how git was build (on compile time configuration).
git-instaweb.sh (source of git-instaweb) has

        PERL='@@PERL@@'

which is set to value of $PERL_PATH (or, to be more exact, its squoted
version) during building git-instaweb.  So you can simply use

  $ make PERL_PATH=/usr/bin/perl
  # make PERL_PATH=/usr/bin/perl install

or whatever, or you can use ./configure script

  $ make configure
  $ ./configure --with-perl=/usr/bin/perl


On Linux for example the path to perl is set explicitely, instead of
using "/usr/bin/env perl" construct.  The 'env' construct has the
following disadvantages:
 - it uses first Perl find in your $PATH, so if git works for you or
   don't work depends on user's personal configuration
   (reproductability, convenience and security).
 - AFAIK it doesn't allow to pass switches to Perl


P.S. Check if you have new enough Perl (there are problems with
Unicode support in old Perl), and if you have CGI.pm new enough
installed for gitweb.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
