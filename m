From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: update Git homepage URL
Date: Sun, 12 Jul 2009 17:28:09 +0200
Message-ID: <200907121728.10559.jnareb@gmail.com>
References: <1247401888-27185-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 17:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQ0yb-0007py-Aj
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 17:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbZGLP2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 11:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754243AbZGLP2U
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 11:28:20 -0400
Received: from ey-out-1920.google.com ([74.125.78.145]:7054 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055AbZGLP2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 11:28:20 -0400
Received: by ey-out-1920.google.com with SMTP id 3so345736eyh.36
        for <git@vger.kernel.org>; Sun, 12 Jul 2009 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=KyoNqhgvA869qNPsswW1F8xjqN6eWcfdwT5oy/64eH0=;
        b=LRcH78Hb1F10ljJ8WMAWZsFyX7Gq/xDPunE8GB72jGBbrA5mVwJew/tvTUuiGrXdQh
         BwqMsoNCX7PRbplJj7ml5iKN6pVPOjgji+ndqrYv6us0G1cRqKM8x3jijwQoW4ZF1YDU
         AbXPOjQ9g9/JnCAB4gf2EmaMbSc8OfitdcVDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=flgOLKVtDlWLN6AOhGNj7SGrqiNPxMQWNV/PlXqkgsJmFZYjvjHHigaj6N6egGkHwc
         bm4nmW7JtTGFJ4lKkrDC89w7ts8mN2Q9BTRRzhAoJzKDja0TdVf5AEZAQrhrqk50Mxwz
         VmmjPAKCCQLSF4NJtR1O2AwTnsiCdW/dgyQmM=
Received: by 10.210.63.18 with SMTP id l18mr5090753eba.11.1247412498568;
        Sun, 12 Jul 2009 08:28:18 -0700 (PDT)
Received: from ?192.168.1.13? (abwk125.neoplus.adsl.tpnet.pl [83.8.234.125])
        by mx.google.com with ESMTPS id 5sm7585430eyf.34.2009.07.12.08.28.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Jul 2009 08:28:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1247401888-27185-1-git-send-email-win@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123153>

On Sun, 12 July 2009, Wincent Colaiuta wrote:

> git-scm.com is now the "official" Git project page, having taken over
> from git.or.cz, so update the default link accordingly. This saves a
> redirect when people hit git.or.cz.
> 
> Signed-off-by: Wincent Colaiuta <win@wincent.com>

Good catch!  For what is worth (not that I think such trivial patch
needs it) ACK from me.

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6a1b5b5..7fbd5ff 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -94,7 +94,7 @@ our $favicon = "++GITWEB_FAVICON++";
>  # URI and label (title) of GIT logo link
>  #our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
>  #our $logo_label = "git documentation";
> -our $logo_url = "http://git.or.cz/";
> +our $logo_url = "http://git-scm.com/";
>  our $logo_label = "git homepage";
>  
>  # source of projects list
> -- 

Perhaps we can squash also this fix to README?  Or should
it be a separate patch/commit?

diff --git i/README w/README
index c932ab3..67cfeb2 100644
--- i/README
+++ w/README
@@ -37,7 +37,7 @@ CVS users may also want to read Documentation/gitcvs-migration.txt
 ("man gitcvs-migration" or "git help cvs-migration" if git is
 installed).
 
-Many Git online resources are accessible from http://git.or.cz/
+Many Git online resources are accessible from http://git-scm.com/
 including full documentation and Git related tools.
 
 The user discussion and development of Git take place on the Git
