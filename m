From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 8/8] gitweb: add avatar in signoff lines
Date: Sat, 27 Jun 2009 11:26:37 +0200
Message-ID: <200906271126.38757.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-9-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 11:26:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKUBS-0000q4-OZ
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 11:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbZF0J0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 05:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbZF0J0m
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 05:26:42 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:51003 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZF0J0l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 05:26:41 -0400
Received: by fxm18 with SMTP id 18so119545fxm.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 02:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Tb+lP9AHTXK3LvoAaTjGkiXEYQkmj5iqgj2dwj4EmFY=;
        b=wLTmXrgAHFUVPb7PolZaJ09LGv8L7ewhqAwcTsPwOm2WZLdAPtdGMO38XLbwf0kb4x
         0sb0kRWJeI6ag81xy+XdXx6oLAXE7mJYZi+yOwPgvLWzXzn4coJncNjD6f6rN6ofaz5C
         kCax8X/q7fHvrt0lyt29kaWBNYncHTROQ7WU0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=nZdjGX8QOUX78GPXsjPB5/4bSQkH89tNmxVWjrOAojVxgi2wnsfkNprovdlPRXFPmp
         OrglvfH3Y9pN0OhelnxwzkUDP8B4bWEwSs8xA7DUm8epuV1agfyqLB44ZTuXldsTfkIL
         MDpjB+TCcHrwg1ntnln30Ya4XU5yw6HB7y9wA=
Received: by 10.103.1.17 with SMTP id d17mr2798966mui.60.1246094802941;
        Sat, 27 Jun 2009 02:26:42 -0700 (PDT)
Received: from ?192.168.1.13? (abwd106.neoplus.adsl.tpnet.pl [83.8.227.106])
        by mx.google.com with ESMTPS id s10sm20391093muh.57.2009.06.27.02.26.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Jun 2009 02:26:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-9-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122350>

On Thu, 25 June 2009, Giuseppe Bilotta wrote:

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

BTW. if it is an RFC, it should be marked as RFC in subject
("[RFC PATCHv6 8/8] gitweb: add avatar in signoff lines").

And I guess this issue should be left for later.

> ---
> 
> I can't say I'm really satisfied with the layout given by this patch.
> A significant improvement could be obtained by turning the signoff
> line block into a table with three/four columns (signoff, name,
> email/avatar). 

First, I think adding (gr)avatars to signoff lines might be not worth
it.  Neither GitHub nor Gitorious show gravatars for signoff lines
(note that they use larger images, and therefore easier to view).

Second, it is not the only possible layout.  Let's use one of existing
commits (e1d3793) in git repository as example:

  completion: add --thread=deep/shallow to format-patch

  [1] Signed-off-by: Stephen Boyd <bebarino@gmail.com> [2]          [3]            [4]|
  [1] Trivially-Acked-By: Shawn O. Pearce <spearce@spearce.org> [2] [3]            [4]|
  [1] Signed-off-by: Junio C Hamano <gitster@pobox.com> [2]         [3]            [4]|

Even without changing layout of signoff lines (so they look exactly
like they look in git-show or git-log output, modulo highlighting
and (gr)avatars), there are more possibilities:

 1. On the left side of signoff lines
 2. Current version: on the right side of signoff lines, just after
 3. On the right hand side, aligned; would probably need table
 4. On the right hand side, flushed (floated) right

There is also more complicated solution of having (gr)avatars appear
only on mouseover, either all avatars on hover over signoff block,
or single (and perhaps larger size) avatar on hover over signoff line.
This can be done using pure CSS, without JavaScript[1]

[1] http://meyerweb.com/eric/css/edge/popups/demo2.html

> But we cannot guarantee that signoff lines come all
> together in a block, so this would be more complex to implement.

Actually I think we can assume that signoff lines come all together
in single block at the very end of commit message; we should take
into account possibility of spurious empty lines between signoff
lines, though (it did happen, see e.g. 8dfb17e1).

> 
>  gitweb/gitweb.perl |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7ca115f..d385f55 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3407,7 +3407,10 @@ sub git_print_log {
>  			$signoff = 1;
>  			$empty = 0;
>  			if (! $opts{'-remove_signoff'}) {
> -				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
> +				my ($email) = $line =~ /<(\S+@\S+)>/;
> +				print "<span class=\"signoff\">" . esc_html($line) . "</span>";
> +				print git_get_avatar($email, 'pad_before' => 1) if $email;
> +				print "<br/>\n";
>  				next;
>  			} else {
>  				# remove signoff lines
> -- 

And here is version with (gr)avatar on the left side of signoff lines
(take a look if it is not better layout):

diff --git c/gitweb/gitweb.perl w/gitweb/gitweb.perl
index 301bdd8..7701bac 100755
--- c/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -3407,6 +3407,8 @@ sub git_print_log {
 			$signoff = 1;
 			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
+				my ($email) = $line =~ /<(\S+@\S+)>/;
+				print git_get_avatar($email, 'pad_after' => 1) if $email;
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 				next;
 			} else {


-- 
Jakub Narebski
Poland
