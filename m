From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 3/7] gitweb: use git_print_authorship_rows in 'tag' view too
Date: Tue, 30 Jun 2009 22:10:09 +0200
Message-ID: <200906302210.10280.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-3-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:28:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjvo-0005qX-1p
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:27:56 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjf2-0002J4-2V
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:36 +0200
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjf2-0002J1-1T
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:36 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLjf1-0000aN-4E
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793AbZF3UKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbZF3UKS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:10:18 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:60795 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505AbZF3UKM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:10:12 -0400
Received: by fxm18 with SMTP id 18so388008fxm.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HYjoxMfqTu/ZiegYsyYAn7Kt85dnkpAd76ieKW4gs/M=;
        b=C1GiYpyDdgClT1EXEdk1EnUBW2pan+6tt+lpfkcamna4SPWL1BXYpmtqo8pseByyXa
         Qg/geLl9hVtTtv9LhA4PaC7lFklk90O9GdUwFtKdgyPzztZWvQU18Ud16NI1hmekp5zC
         f4emHgYP7X7BCSG0qr7n+Au0gIDOp/gz415CA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=cFXeAfKZPsvXVs6CCTgQ5eALQJs/tmoef9BRNqZNkQMuK7i3zSUllYLqm0EA8H/Vkk
         KTWR4AQ7B7DfwHyajsXUYyb1OTJf7EBLYtSBSbaF+hPhQZ4v/ssJgrhmY/kJ6pd6xeQc
         okG9xxf9KabCPX8iTYgpXWN+rqnZCS6CaVNwY=
Received: by 10.103.224.17 with SMTP id b17mr5128816mur.61.1246392615261;
        Tue, 30 Jun 2009 13:10:15 -0700 (PDT)
Received: from ?192.168.1.13? (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id u9sm2040704muf.37.2009.06.30.13.10.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 13:10:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246312854-3365-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: C5B479695FD5EF77409DC20B8183CD3A5DD68A7E
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 49 total 2548626 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122534>

On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:

> parse_tag must be adapted to use the hash keys expected by
> git_print_authorship_rows. This is not a problem since git_tag is the
> only user of this sub.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Very nice unification (of hash key names for parse_tag and
parse_commit_text), and nice refactoring of common code.

Acked-by: Jakub Narebski <jnareb@gmail.com>

[...]
> @@ -2409,8 +2409,14 @@ sub parse_tag {
>  			$tag{'name'} = $1;
>  		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
>  			$tag{'author'} = $1;
> -			$tag{'epoch'} = $2;
> -			$tag{'tz'} = $3;
> +			$tag{'author_epoch'} = $2;
> +			$tag{'author_tz'} = $3;
> +			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
> +				$tag{'author_name'}  = $1;
> +				$tag{'author_email'} = $2;
> +			} else {
> +				$tag{'author_name'} = $tag{'author'};
> +			}

Unrelated sidenote: I wonder if it would work correctly on
malformed 'tagger' headers which sometimes happen... Probably
not.  But this is not an issue with this patch, but with gitweb
in general.

-- 
Jakub Narebski
Poland
