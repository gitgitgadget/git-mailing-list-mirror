From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 3/3] New send-email option smtpserveroption.
Date: Sun, 05 Sep 2010 14:49:15 -0700 (PDT)
Message-ID: <m3lj7fn9oy.fsf@localhost.localdomain>
References: <1283708940-2172-1-git-send-email-pascal@obry.net>
	<1283708940-2172-4-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sun Sep 05 23:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsN5Y-0001JX-QF
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 23:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab0IEVtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 17:49:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58021 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab0IEVtR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 17:49:17 -0400
Received: by mail-fx0-f46.google.com with SMTP id 13so2212827fxm.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=vUqkOlND2xEQCghTXN2tAKxLwYM8jqOV8dsEQaHv9BI=;
        b=Zzk1Sw5BNuLVnLQmdCHwEAhJS7nJfKRqlvGH02I8o9yLHSwypdfRO1lokmRt/TaisL
         IwQzY2PUnmYCTVJzuE4iF1CUZrSZK0PGA08+gwugNw/qdY/3ETTP8zcLFQO/Zve2S9NM
         /8OquSExcOzC/8EXCSg4z1F+ybh1Zak1482Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=pjo26zcJ7t+cpOh1WS3y48WADFRLkylpob0BZtz7LjVb1sgPmImWwVmlFZhuvp9oOi
         tR/1whQdM22MYMMEH0aZ0jf/8a01aDyKcUOFkaIfRoFWca4k749UZ8brHvx1B4iUa1rU
         oAXeIF7+wfTd/O1WO+rob9iCh7Mv2oUxwIdWk=
Received: by 10.223.109.15 with SMTP id h15mr1449330fap.46.1283723356815;
        Sun, 05 Sep 2010 14:49:16 -0700 (PDT)
Received: from localhost.localdomain (abuz71.neoplus.adsl.tpnet.pl [83.8.197.71])
        by mx.google.com with ESMTPS id k25sm2045673fac.17.2010.09.05.14.49.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 14:49:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o85Lmk9D000453;
	Sun, 5 Sep 2010 23:48:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o85LmTtY000443;
	Sun, 5 Sep 2010 23:48:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1283708940-2172-4-git-send-email-pascal@obry.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155493>

Pascal Obry <pascal@obry.net> writes:

> The new command line parameter --smtp-server-option or default
> configuration sendemail.smtpserveroption can be used to pass
> specific options to the SMTP server. Update the documentation
> accordingly.

Sign-off?  (See Documentation/SubmittingPatches).

> ---
>  Documentation/git-send-email.txt |    8 ++++++++
>  git-send-email.perl              |    8 +++++++-
>  2 files changed, 15 insertions(+), 1 deletions(-)

Needs update to Documentation/config.txt, adding line about
sendemail.smtpserveroption.

> 
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index c283084..5af05bc 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -157,6 +157,14 @@ user is prompted for a password while the input is masked for privacy.
>  	`/usr/lib/sendmail` if such program is available, or
>  	`localhost` otherwise.
>  
> +--smtp-server-option=<option>::
> +	If set, specifies the outgoing SMTP server option to use.
> +	Default value can be specified by the 'sendemail.smtpserveroption'
> +	configuration option.
> ++
> +The --smtp-server-option option must be repeated for each option you want
> +to pass to the server.

Just a nitpick.

How do multiple options are supported with sendemail.smtpserveroption?
This also needs to be described, I think.

> +
>  --smtp-server-port=<port>::
>  	Specifies a port different from the default port (SMTP
>  	servers typically listen to smtp port 25, but may also listen to
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 39cb5af..47989fe 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -60,6 +60,7 @@ git send-email [options] <file | directory | rev-list options >
>      --envelope-sender       <str>  * Email envelope sender.
>      --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
>                                       is optional. Default 'localhost'.
> +    --smtp-server-option    <str>  * Outgoing SMTP server option to use.
>      --smtp-server-port      <int>  * Outgoing SMTP server port.
>      --smtp-user             <str>  * Username for SMTP-AUTH.
>      --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
> @@ -188,7 +189,8 @@ sub do_edit {
>  
>  # Variables with corresponding config settings
>  my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
> -my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
> +my ($smtp_server, $smtp_server_port, @smtp_server_options);
> +my ($smtp_authuser, $smtp_encryption);
>  my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
>  my ($validate, $confirm);
>  my (@suppress_cc);
> @@ -210,6 +212,7 @@ my %config_bool_settings = (
>  my %config_settings = (
>      "smtpserver" => \$smtp_server,
>      "smtpserverport" => \$smtp_server_port,
> +    "smtpserveroption" => \@smtp_server_options,
>      "smtpuser" => \$smtp_authuser,
>      "smtppass" => \$smtp_authpass,
>      "smtpdomain" => \$smtp_domain,
> @@ -279,6 +282,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
>  		    "no-bcc" => \$no_bcc,
>  		    "chain-reply-to!" => \$chain_reply_to,
>  		    "smtp-server=s" => \$smtp_server,
> +		    "smtp-server-option=s" => \@smtp_server_options,
>  		    "smtp-server-port=s" => \$smtp_server_port,
>  		    "smtp-user=s" => \$smtp_authuser,
>  		    "smtp-pass:s" => \$smtp_authpass,
> @@ -1015,6 +1019,8 @@ X-Mailer: git-send-email $gitversion
>  		}
>  	}
>  
> +	unshift (@sendmail_parameters, @smtp_server_options);
> +

I guess that you are following strange style that other 'unshift'
invocation uses, but there should be no space between function and
opening parentheses beginning its arguments, e.g.

  join("\n", @xh)

not

  join ("\n", @xh)

>  	if ($dry_run) {
>  		# We don't want to send the email.
>  	} elsif ($smtp_server =~ m#^/#) {
> -- 
> 1.7.2.3.316.ga4c47
> 
> 
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
