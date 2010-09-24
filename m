From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH V3] git-send-email.perl: Add --to-cmd
Date: Fri, 24 Sep 2010 08:32:25 -0700 (PDT)
Message-ID: <m3lj6rgnub.fsf@localhost.localdomain>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	<AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	<1285227413.7286.47.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	<20100923090931.GA29789@albatros> <20100923120024.GA26715@albatros>
	<1285253867.31572.13.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	<1285262237.31572.18.camel@Joe-Laptop>
	<AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
	<1285263993.31572.25.camel@Joe-Laptop>
	<AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
	<1285267520.31572.34.camel@Joe-Laptop>
	<7v62xwqe7i.fsf@alter.siamese.dyndns.org>
	<1285291098.25928.220.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Julia Lawall <julia@diku.dk>, git@vger.kernel.org,
	Vasiliy Kulikov <segooon@gmail.com>,
	Matt Mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 17:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAGJ-00010H-Bi
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 17:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756744Ab0IXPc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 11:32:29 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34155 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab0IXPc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 11:32:28 -0400
Received: by wwd20 with SMTP id 20so99924wwd.1
        for <multiple recipients>; Fri, 24 Sep 2010 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=haEyM8ymAVxkXYpV5L/j8ekzuort9U0EywmbrRxCHu0=;
        b=RsoA+mipQ356WZ6vvzcTDp9qP5BIESAc8IbSnJFsdfuI1Y6vthXte9xvSyG9TeXGmZ
         Ys/cFRSf8LRKYSVf8FCgf58BxVDJxuTPPZcMzFJFakGgYZJJL8Ueesndf97Rx1KS00pR
         pIkG8fvo5bhdU6VFHItI34+2G95OWx1r85zJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=XmiBxhONfgbD+CyXtoRv41fAWeOO3eqB24dp/9HPWnpaxpHlw3ARxlVuCIhlQtPzxn
         YZXjgViqsW+8EFZpBWl+qj1sPyUPgXkKD9A+qEk/mwzGRODJuWssyqUWC7RqqGDsgP9g
         Ggy0xUH7KPAlL0vvRJaw2iErFPnnIAreWDYDE=
Received: by 10.216.6.149 with SMTP id 21mr9585346wen.101.1285342346986;
        Fri, 24 Sep 2010 08:32:26 -0700 (PDT)
Received: from localhost.localdomain (abwq206.neoplus.adsl.tpnet.pl [83.8.240.206])
        by mx.google.com with ESMTPS id n40sm1412794weq.5.2010.09.24.08.32.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 08:32:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8OFVpoP032719;
	Fri, 24 Sep 2010 17:32:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8OFVPfs032714;
	Fri, 24 Sep 2010 17:31:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1285291098.25928.220.camel@Joe-Laptop>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156998>

Joe Perches <joe@perches.com> writes:

> +# Execute a command (ie: $to_cmd) to get a list of email addresses
> +# and return a results array
> +sub recipients_cmd(@) {

Do not use subroutine prototypes: they do not do what you think they
do.  In this case using prototype is unnecessary and can be dangerous.

> +	my ($prefix, $what, $cmd, $file) = @_;
> +
> +	my $sanitized_sender = sanitize_address($sender);
> +	my @addresses = ();
> +	open(F, "$cmd \Q$file\E |")

For the future: use lexical filehandles instead of globals

  +	open(my $fh, "$cmd \Q$file\E |")


> +	    or die "($prefix) Could not execute '$cmd'";

You should use quote_command from gitweb/gitweb.perl (should probably
make it into Git.pm):

  # quote the given arguments for passing them to the shell
  # quote_command("command", "arg 1", "arg with ' and ! characters")
  # => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
  # Try to avoid using this function wherever possible.
  sub quote_command {
  	return join(' ',
  		map { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
  }

Or use String::ShellQuote :-)

But that is for a cleanup patch; you are using what it is already
there.

> +	while(<F>) {
> +		my $address = $_;
> +		$address =~ s/^\s*//g;
> +		$address =~ s/\n$//g;

Hmmm... why does it remove leading, but not trailing whitespace?

> +		$address = sanitize_address($address);
> +		next if ($address eq $sanitized_sender and $suppress_from);
> +		push @addresses, $address;
> +		printf("($prefix) Adding %s: %s from: '%s'\n",
> +		       $what, $address, $cmd) unless $quiet;
> +		}
> +	close F
> +	    or die "($prefix) failed to close pipe to '$cmd'";
> +	return @addresses;
> +}

-- 
Jakub Narebski
Poland
ShadeHawk on #git
