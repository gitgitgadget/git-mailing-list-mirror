From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/9] gitweb: change die_error to take "extra" argument for extended die information
Date: Fri, 15 Jan 2010 14:40:32 -0800 (PST)
Message-ID: <m3y6jzc7re.fsf@localhost.localdomain>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
	<1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:40:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVuqO-0000Ue-0U
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758426Ab0AOWkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758410Ab0AOWkg
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:40:36 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:38684 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758385Ab0AOWkf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:40:35 -0500
Received: by ewy19 with SMTP id 19so819669ewy.1
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zLw/YulqZhuk0Sh6zGgI5NaxS7TeIe2pE2GXeDi/uLs=;
        b=IvDWy3Wf0tJ3vXuFIM+FTXGjC9XHjDbL8LNTHuGmDqHFaCARoCz5c+yVIv/NCQ0uaj
         ZPUWvcOvitLtB4U7Is/CCibuJvogCgw6lQLto8UcBdT86vm2NOKXa6eyn03XhGvjWgsd
         7VcOWXrQyCYgA0I66DCcDeK515pZd14LMYSUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=C5zucStYcnwROlaArM/NIRYDPLC0RZ+/2L78kbOFKOjctp1l+t2cnLK0IQTTxjWEsJ
         D9TusvSAc1nM/DrHOn+yGDAAj0V2kbginfvHIGc4PdbxPtGwXmsF56fJP0vGnPZJrMec
         MRGj2qV4daCVxckXTgapRr4ETdvnJ+wYWkDRU=
Received: by 10.213.50.137 with SMTP id z9mr292686ebf.39.1263595233722;
        Fri, 15 Jan 2010 14:40:33 -0800 (PST)
Received: from localhost.localdomain ([72.14.240.162])
        by mx.google.com with ESMTPS id 28sm2399862eyg.44.2010.01.15.14.40.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 14:40:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0FMe8Vx030658;
	Fri, 15 Jan 2010 23:40:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0FMdn00030648;
	Fri, 15 Jan 2010 23:39:49 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137147>

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

Don't you want kernel.org address also for authorship?  Also commit
summary can be written in shorter way, see proposal below.

From: "John 'Warthog9' Hawley" <warthog9@kernel.org>
Subject: gitweb: Allow for longer error explanation in die_error()

> This is a small change that just adds a 3rd, optional, parameter to die_error
> that allows for extended error information to be output along with what the
> error was.

Singed-off-by: "John 'Warthog9' Hawley" <warthog9@kernel.org>
> ---
>  gitweb/gitweb.perl |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0a07d3a..8298de5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3391,6 +3391,7 @@ sub git_footer_html {
>  sub die_error {
>  	my $status = shift || 500;
>  	my $error = shift || "Internal server error";
> +	my $extra = shift;
>  
>  	my %http_responses = (
>  		400 => '400 Bad Request',
> @@ -3405,8 +3406,13 @@ sub die_error {
>  <br /><br />
>  $status - $error
>  <br />
> -</div>
>  EOF
> +	if (defined $extra) {
> +		print "<hr />\n" .
> +			"$extra\n";

Following gitweb whitespace convention (tab for indent, space for
align), it should be:

 +		print "<hr />\n" .
 +		      "$extra\n";

(6 x space in place of last tab).

> +	}
> +	print "</div>\n";
> +
>  	git_footer_html();
>  	exit;
>  }
> -- 
> 1.6.5.2
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
