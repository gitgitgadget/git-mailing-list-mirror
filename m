From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Pass "-O xhtml" param to highlight instead of "-xhtml"
Date: Wed, 26 Jan 2011 13:34:32 -0800 (PST)
Message-ID: <m339ofbb9t.fsf@localhost.localdomain>
References: <20110126171118.GA867@traged.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Adam Tkac <atkac@redhat.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 22:34:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiD0k-0000Ts-7Y
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 22:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082Ab1AZVeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 16:34:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38448 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754064Ab1AZVeg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 16:34:36 -0500
Received: by wwa36 with SMTP id 36so1466502wwa.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 13:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=pFIiYvY9my3ImHJYv92vvq0LXNOvz8kV1AdNtnegQio=;
        b=hZwA7htMIcHnIh/cEMvp53LXEQPiFwEQnh0GROwJdOkaSAz5Y1rz1peX3yslAU3ugP
         ugHcZkV36k96k0kTneVQjbM6T4NBmN45s8I6M48yCsfDIXdhuj+PDBf4k3O/fwanzxSz
         MsPCQO4N8iVCfVBmpJlHOkO9sNGKrucR3cD6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=w5llUq1eBSlFWcV9CB/WX4vXrdaK6fr6CPlCAAgqJ0/rR1eD8JWaZUv1nvFCz1QsWi
         bKd93YBY3t/AFN87ZPsWYl2saEvO9Qh4r9Fc5UNppRGd0J8SQJHuRxJ5GeWVijKjDew5
         wgz2yUREM/8LAhNEOM9HS7hVrJ0H2twQl4EpE=
Received: by 10.227.155.83 with SMTP id r19mr97464wbw.137.1296077675032;
        Wed, 26 Jan 2011 13:34:35 -0800 (PST)
Received: from localhost.localdomain (abve138.neoplus.adsl.tpnet.pl [83.8.202.138])
        by mx.google.com with ESMTPS id w25sm224352wbd.5.2011.01.26.13.34.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 13:34:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0QLXuhc009490;
	Wed, 26 Jan 2011 22:34:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0QLXZGA009486;
	Wed, 26 Jan 2011 22:33:35 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110126171118.GA867@traged.englab.brq.redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165552>

Adam Tkac <atkac@redhat.com> writes:

> Hello,
> 
> attached patch fixes the gitweb.perl script.

Please don't send patches as attachements, but inline.
See Documentation/SubmittingPatches

> Current highlight utility doesn't recognize "--xhtml" parameter, it
> recognizes only "-O xhtml" parameter.
> 
> Reference: https://bugzilla.redhat.com/show_bug.cgi?id=672293

Shouldn't the above be in commit message?

> Subject: [PATCH] Pass "-O xhtml" parameter instead of "--xhtml" to hightlight in gitweb.

Why the mismatch between subject of email, and subject in attached
patch?

> Signed-off-by: Jochen Schmitt <jochen@herr-schmitt.de>
> Signed-off-by: Adam Tkac <atkac@redhat.com>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1025c2f..88556f4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3468,7 +3468,7 @@ sub run_highlighter {
>  	close $fd;
>  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
>  	          quote_command($highlight_bin).
> -	          " --xhtml --fragment --syntax $syntax |"
> +	          " -O xhtml --fragment --syntax $syntax |"
>  		or die_error(500, "Couldn't open file or run syntax highlighter");
>  	return $fd;
>  }

In highlight 2.4.5 '-O' means "name of output directory", i.e. --outdir.
There is no --out-format either.

WTF this backward incompatibile change in highlight... the only
solution that would make it work both for old and for new versions is
to rely on the fact that HTML is default output format, i.e.

  	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
  	          quote_command($highlight_bin).
 -	          " --xhtml --fragment --syntax $syntax |"
 +	          " --fragment --syntax $syntax |"
  		or die_error(500, "Couldn't open file or run syntax highlighter");


-- 
Jakub Narebski
Poland
ShadeHawk on #git
