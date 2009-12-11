From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/6] GITWEB - Makefile changes
Date: Fri, 11 Dec 2009 06:28:31 -0800 (PST)
Message-ID: <m3pr6ld1p2.fsf@localhost.localdomain>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
	<1260488743-25855-2-git-send-email-warthog9@kernel.org>
	<1260488743-25855-3-git-send-email-warthog9@kernel.org>
	<1260488743-25855-4-git-send-email-warthog9@kernel.org>
	<1260488743-25855-5-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 15:28:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ6U5-0003RC-3R
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 15:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbZLKO22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 09:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757466AbZLKO21
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 09:28:27 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64252 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756639AbZLKO21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 09:28:27 -0500
Received: by bwz27 with SMTP id 27so628690bwz.21
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 06:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ywl7xyZM1XyHfPCGkEjQlBYHvYV2nW0JWjKlSNmiDs0=;
        b=BOr+A5J6QEvXXm2poqpgYluX6lJoOijP3MIOee5O5IeYrLvVX2iXHdmVxcvkoQlVKN
         FBEQDBgOo9PwKNovdLQprdQOMoK/U99gLHTqSr4AosQGvHr/vd7SU211q41DqtYRRlH5
         TDvHIg55V609jayTnS16IvEhoR/qC4L2vYzEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SOv7CQqtYh7CdXag5t4YO1GEin9X4RwjueqFKA4jyZ8yGcJwpN3PMr1tyKYSkQ1Diu
         8W2UDUzcWjVY0CYcNTSRkA4p+x86rLa6jOCU8gjZKxbAjMjRMKpx6eMERhfBRILZrbeE
         Cd5c67NzIM+yvCLWLKzyaFQYc7kfDqHP+zRHY=
Received: by 10.204.48.210 with SMTP id s18mr796473bkf.162.1260541711947;
        Fri, 11 Dec 2009 06:28:31 -0800 (PST)
Received: from localhost.localdomain (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id 15sm524941bwz.4.2009.12.11.06.28.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 06:28:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBBETLIp005090;
	Fri, 11 Dec 2009 15:29:31 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBBESv4M005086;
	Fri, 11 Dec 2009 15:28:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1260488743-25855-5-git-send-email-warthog9@kernel.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135089>

"John 'Warthog9' Hawley" <warthog9@kernel.org> writes:

Below are _proposed_ changes to make commit message easier to read, in
my opinion.  But they are not _necessary_ changes.

> This adjust the makefiles so that you can do such things as

Add "gitweb" target to main Makefile so you would be able to simply
use

> 
> 	make gitweb
> 
> from the top level make tree,

instead of requiring to spell it in full

	make gitweb/gitweb.cgi

>                               or if your in the gitweb directory
> itself typing

Add Makefile in gitweb subdirectory so one can simply run
> 
> 	make

when in gitweb subdirectory,

> 
> will call back up to the main Makefile and build gitweb
> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

Signoff mismatch.

> ---
>  Makefile        |    4 +++-
>  gitweb/Makefile |   14 ++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletions(-)
>  create mode 100644 gitweb/Makefile

IMPORTANT!

A note about this change: I think it would be better to move creating
gitweb.cgi (and optionally gitweb.min.js) to gitweb/Makefile, and make
main Makefile call gitweb/Makefile, and not vice versa like in your
solution.

If it is possible.
 
> diff --git a/Makefile b/Makefile
> index 4a1e5bc..8db9d01 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1509,6 +1509,8 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
>  	chmod +x $@+ && \
>  	mv $@+ $@
>  
> +.PHONY: gitweb

Why it is here, and not with the .PHONY block at line 1924 of
Makefile?  It would be nice to have comment supporting this choice in
email with this patch (or in commit message).

> +gitweb: gitweb/gitweb.cgi
>  ifdef JSMIN
>  OTHER_PROGRAMS += gitweb/gitweb.cgi   gitweb/gitweb.min.js
>  gitweb/gitweb.cgi: gitweb/gitweb.perl gitweb/gitweb.min.js
> @@ -1537,7 +1539,7 @@ endif
>  	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
>  	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
>  	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
> -	    $< >$@+ && \
> +	    $(patsubst %.cgi,%.perl,$@) >$@+ && \

Why this change?

>  	chmod +x $@+ && \
>  	mv $@+ $@
>  
> diff --git a/gitweb/Makefile b/gitweb/Makefile
> new file mode 100644
> index 0000000..8d318b3
> --- /dev/null
> +++ b/gitweb/Makefile
> @@ -0,0 +1,14 @@
> +SHELL = /bin/bash

Why is this needed?

> +
> +FILES = gitweb.cgi
> +
> +.PHONY: $(FILES)

Why .PHONY?  $(FILES) are created.

> +
> +all: $(FILES)
> +
> +$(FILES):
> +	$(MAKE) $(MFLAGS) -C ../ -f Makefile gitweb/$@
> +
> +clean:
> +	rm -rf $(FILES)
> +

-- 
Jakub Narebski
Poland
ShadeHawk on #git
