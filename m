From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and unicode special characters
Date: Fri, 12 Dec 2008 14:09:05 -0800 (PST)
Message-ID: <m3y6ylf3mq.fsf@localhost.localdomain>
References: <3f2beab60812121033r5d41894t77acc271b7c6955c@mail.gmail.com>
	<m37i65gp6b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Santhosh Thottingal" <santhosh00@gmail.com>
To: "Praveen A" <pravi.a@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:10:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBGDO-0005j2-17
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 23:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbYLLWJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 17:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbYLLWJK
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 17:09:10 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:45739 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbYLLWJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 17:09:09 -0500
Received: by ewy10 with SMTP id 10so2002037ewy.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 14:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=MJ3FluraA0o31m0qJBzRZm+baw56xdb5tSgdTyogni8=;
        b=p2+Ktd6OFKXBN5OWuEJePGIpdjvaC/yI6mliS/B9mWM9amXouZgd5LUNHOG7/qoU0S
         8C27p9Lt4CjCZ6yV16HdOWiJNa4JDtkPLX2pIkfKSs6tABD6bn493gNIjX6VLS4mvICo
         eLheV6BTPGJmNnFRhQdysIq4QlHCy+QJaxN+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Jh4x8knIjmEQifLD2/qpwACu5mLLHXQVUP6w/lWbxULJy6QKWyxNirSQbjR8LGwE/0
         FKao9TuGpWnVE7HfZRst2XiukRBIFDUJIdmX3/x++IeAwGO/lTR9dOTgHj4CrLE3g2CL
         TmfcGPOf8P8pwQoR6XdlhU9fLgwOlV6AcRQpc=
Received: by 10.210.78.16 with SMTP id a16mr4680475ebb.122.1229119746598;
        Fri, 12 Dec 2008 14:09:06 -0800 (PST)
Received: from localhost.localdomain (abvt119.neoplus.adsl.tpnet.pl [83.8.217.119])
        by mx.google.com with ESMTPS id d25sm7485687nfh.25.2008.12.12.14.09.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Dec 2008 14:09:05 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBCM8e6e003660;
	Fri, 12 Dec 2008 23:08:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBCM8UB5003656;
	Fri, 12 Dec 2008 23:08:30 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m37i65gp6b.fsf@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102960>

Jakub Narebski <jnareb@gmail.com> writes:
> "Praveen A" <pravi.a@gmail.com> writes:
> 
> > Git currently does not handle unicode special characters ZWJ and ZWNJ,
> > both are heavily used in Malayalam and common in other languages
> > needing complex text layout like Sinhala and Arabic.
> > 
> > An example of this is shown in the commit message here
> > http://git.savannah.gnu.org/gitweb/?p=smc.git;a=commit;h=c3f368c60aabdc380c77608c614d91b0a628590a
> > 
> > \20014 and \20015 should have been ZWNJ and ZWJ respectively. You just
> > need to handle them as any other unicode character - especially it is
> > a commit message and expectation is normal pain text display.
> > 
> > I hope some one will fix this.
> 
> Well, I am bit stumped.  git_commit calls format_log_line_html, which
> in turn calls esc_html.  esc_html looks like this:
> 
>   sub esc_html ($;%) {
>   	my $str = shift;
>   	my %opts = @_;
>   
>   **	$str = to_utf8($str);
>   	$str = $cgi->escapeHTML($str);
>   	if ($opts{'-nbsp'}) {
>   		$str =~ s/ /&nbsp;/g;
>   	}
>   **	$str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
>   	return $str;
>   }
> 
> The two important lines are marked with '**'.
[...]

> So it looks like Perl treats \20014 and \20015 (ZWNJ and ZWJ) as
> belonging to '[:cntrl:]' class. I don't know if it is correct from the
> point of view of Unicode character classes, therefore if it is a bug
> in Perl, or just in gitweb.

I checked this, via this simple Perl script:

  #!/usr/bin/perl

  use charnames ":full";

  my $c = ord("\N{ZWNJ}");
  printf "oct=%o dec=%d hex=%x\n", $c, $c, $c;

  "\N{ZWNJ}" =~ /[[:cntrl:]]/ and print "is [:cntrl:]";

And the answer was:

  oct=20014 dex=8204 hex=200c
  is [:cntrl:]

'ZERO WIDTH NON-JOINER' _is_ control character... We probably should
use [^[:print:][:space:]] instead of [[:cntrl:]] here.

[...]
> P.S. Even that might not help much, as Savannah uses git and gitwev
> version 1.5.6.5, which is probably version released with some major
> distribution.  As of now we are at 1.6.0.5...

Which can be seen from the fact that gitweb uses octal escapes,
instead of hex escapes...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
