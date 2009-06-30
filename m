From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 2/7] gitweb: uniform author info for commit and commitdiff
Date: Tue, 30 Jun 2009 22:04:53 +0200
Message-ID: <200906302204.53485.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-2-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:28:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjvo-0005qX-2t
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:27:56 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjf0-0002It-UN
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:34 +0200
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjf0-0002Iq-TS
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:34 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjf0-0000aN-6r
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbZF3UKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755476AbZF3UKQ
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:10:16 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:34224 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531AbZF3UKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:10:12 -0400
Received: by fxm18 with SMTP id 18so387986fxm.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=tlLG/RiiNC9SBwSPQJfCW6bhNb1oZQzncr8vuQYQ4zw=;
        b=QUAg8gkX2lESboEeh6kSkyKxtkN1xlmhFrfxQB4cKgGdvhyeAApsSuACQGVHdCYn3H
         g5/aZrvC5hQNFzRSQ7PVEUfYOyTczA0HCbuCVkct6rngpjaBjzbJ7kMRlhnclal8tdKM
         rXSeA+/DFGtrqjmeMVy9DradKYcK/oSwHPsqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=mBRF7SylbTWO2Kmq6vd/k98KHEq1JF7BzPToj2xG+qkUsfSuMdF7epXUGf6hbN24PT
         YrMmXBo63m8yxxK9ieR5yES7aGe8WpqX1n5rH2IUvlpPa9IbjCeMN1VL/6Hd78d5GF9z
         19bSKdz30uKJJVMMDe5rWl/dq1P4NKURx2szE=
Received: by 10.103.6.14 with SMTP id j14mr5108322mui.48.1246392614195;
        Tue, 30 Jun 2009 13:10:14 -0700 (PDT)
Received: from ?192.168.1.13? (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id u9sm2040704muf.37.2009.06.30.13.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 13:10:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: E7213651DCD36EF37F80A53FAE2F97D97DE0D885
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 48 total 2548625 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122533>

On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:

> Switch from 'log'-like layout
> 
>     A U Thor <email@example.com> [date time]
> 
> to 'commit'-like layout
> 
>     author    A U Thor <email@example.com>
>               date time
>     committer C O Mitter <other.email@example.com>
>               committer date time
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I am (as I have said earlier) a bit ambivalent about this issue.
But I like this patch from technical point of view.

I also like the fact that this feature is put in separate patch,
so it can be accepted or rejected (or reverted) independently.
Good work on refactoring!

Techically-Acked-By: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7fd53f6..9a8d775 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5596,7 +5596,11 @@ sub git_commitdiff {
>  		git_header_html(undef, $expires);
>  		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, 
$formats_nav);
>  		git_print_header_div('commit', esc_html($co{'title'}) . $ref, 
$hash);
> -		git_print_authorship(\%co, -localtime => 1);
> +		print "<div class=\"title_text\">\n" .
> +		      "<table class=\"object_header\">\n";
> +		git_print_authorship_rows(\%co);
> +		print "</table>".
> +		      "</div>\n";
>  		print "<div class=\"page_body\">\n";
>  		if (@{$co{'comment'}} > 1) {
>  			print "<div class=\"log\">\n";
> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
