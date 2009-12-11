From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/6] GITWEB - Missmatching git w/ gitweb
Date: Fri, 11 Dec 2009 02:52:43 -0800 (PST)
Message-ID: <m3y6l9dbop.fsf@localhost.localdomain>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
	<1260488743-25855-2-git-send-email-warthog9@kernel.org>
	<1260488743-25855-3-git-send-email-warthog9@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: "John 'Warthog9' Hawley" <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 11:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJ37D-0001QT-BP
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 11:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760950AbZLKKwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 05:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbZLKKwj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 05:52:39 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33028 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbZLKKwi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 05:52:38 -0500
Received: by bwz27 with SMTP id 27so501749bwz.21
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 02:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=hNxJtYD/VWtZ/y3db9hpqDqIXZqxZwGngp4JSvnaezo=;
        b=M2xAtcnZRkNu40YOAVjYLMNtPOyRoSIMFJUgMnLBqDhcIQRqVaB4nNmXlcxDebe2cz
         RIgnWxVHMFAW7y3v0vFg18d7ubw5uEdJizzPbAvq6QnJw3QLGIsVVN4wSAbeI/G1QCvD
         u3LdYwuWffHntpp4ZFq+LeCQwKMOx9amly48o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=L0yRPsNB4IjHmicf8PqPs9yEFmU2Tpz6Y4GVD70juIKMAQmqjgMtwHTMvAZl25+dVX
         iYeEeDZeTmUNcWQDOoJcJUa8DZ2UzyE6RKouFv7DuGxPu0hx3gcbSuZ2ElKTZAUriuCu
         EdQUUTrfH//6b1e4Zs4ewAbDeoIjOwgTHnmnI=
Received: by 10.204.11.3 with SMTP id r3mr635997bkr.107.1260528763786;
        Fri, 11 Dec 2009 02:52:43 -0800 (PST)
Received: from localhost.localdomain (abvh202.neoplus.adsl.tpnet.pl [83.8.205.202])
        by mx.google.com with ESMTPS id 14sm476454bwz.13.2009.12.11.02.52.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Dec 2009 02:52:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nBBArWs3002213;
	Fri, 11 Dec 2009 11:53:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nBBArBOY002209;
	Fri, 11 Dec 2009 11:53:11 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1260488743-25855-3-git-send-email-warthog9@kernel.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135077>

"John 'Warthog9' Hawley" <warthog9@kernel.org> writes:

> This adds $missmatch_git so that gitweb can run with a miss-matched
> git install.  Gitweb, generally, runs fine on a very broad range of
> git versions, but it's not always practicle or useful to upgrade it
> every time you upgrade git.
> 
> This allows the administrator to realize they are miss-matched, and
> should they be so inclined, disable the check entirely and run in
> a miss-matched fasion.
> 
> This is more here to give an obvious warning as to whats going on
> vs. silently failing.

First, why one would want to require that gitweb version (version at
the time of build) and runtime git version (version of git used to run
commands) match?

Second, it is mismatch, not missmatch (one 's', not double 's').

Third, in my opinion it would be better to name variable in question
e.g. $versions_must_match and also flip its meaning (true means check
that versions match, and show an error otherwise).

>
> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

signoff mismatch

> ---
>  gitweb/gitweb.perl |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 813e48f..d84f4c0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -221,6 +221,9 @@ our %avatar_size = (
>  	'double'  => 32
>  );
>  
> +# This is here to allow for missmatch git & gitweb versions
> +our $missmatch_git = '';
> +

First, 'undef' is false, so it could have been written as

+our $missmatch_git;

Or if you prefer explicit false-ish value as default, 0 would be I
think better than empty string '':

+our $missmatch_git = 0;


Second, there is question whether default should be to allow
mismatched versions (current behaviour, more lenient...) or deny (or
warn about) mismatched version, i.e. should it be $versions_must_match
false by default, or $allow_versions_mismatch false by default.

>  # Used to set the maximum load that we will still respond to gitweb queries.
>  # if we exceed this than we do the processing to figure out if there's a mirror
>  # and redirect to it, or to just return 503 server busy
> @@ -579,6 +582,25 @@ if (get_loadavg() > $maxload) {
>  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
>  $number_of_git_cmds++;
>  
> +# There's a pretty serious flaw that we silently fail if git doesn't find something it needs
> +# a quick and simple check is to have gitweb do a simple check - are we running on the same
> +# version of git that we shipped with - if not, throw up an error so that people doing
> +# first installs don't have to debug perl to figure out whats going on

Could you please clean up language in above comment?  It is very
convoluted.  Please also limit line width of above comment to 76 / 80
columns.

> +if (
> +	$git_version ne $version
> +	&&
> +	$missmatch_git eq ''
> +){

Style

+if (!$allow_versions_mismatch &&
+    $git_version ne $version) {

Do not compare $missmatch_git / $allow_versions_mismatch against '':
it is a boolean value!

> +	git_header_html();

Shouldn't this be "500 Internal Server Error" or something (using the
optional parameter to git_header_html())?

> +	print "<p><b>*** Warning ***</b></p>\n";
> +	print "<p>\n";
> +	print "This version of gitweb was compiled for <b>$version</b> however git version <b>$git_version</b> was found<br/>\n";
> +	print "If you are sure this version of git works with this version of gitweb - please define <b>\$missmatch_git</b> to a non empty string in your git config file.\n";

Too long lines.  Here-doc could be better here.

> +	print "</p>\n";
> +	git_footer_html();
> +	exit;
> +}
> +
>  $projects_list ||= $projectroot;
>  
>  # ======================================================================

-- 
Jakub Narebski
Poland
ShadeHawk on #git
