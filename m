From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/3] git-bundle.txt: Clarify rev-list-args restrictions
Date: Mon, 23 Aug 2010 14:01:25 +0200
Message-ID: <201008231401.26329.trast@student.ethz.ch>
References: <cover.1282553585.git.git@drmicha.warpmail.net> <4a2d0ecb46d274f6143caab6982535bfb678d10e.1282553586.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 23 14:01:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnVia-00063r-QB
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 14:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab0HWMBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 08:01:32 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:51670 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab0HWMBb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 08:01:31 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 23 Aug
 2010 14:01:32 +0200
Received: from thomas.site (129.132.246.171) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 23 Aug
 2010 14:01:27 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <4a2d0ecb46d274f6143caab6982535bfb678d10e.1282553586.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154220>

Michael J Gruber wrote:
> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 3cdbc72..38e59af 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -59,7 +59,8 @@ unbundle <file>::
>  
>  <git-rev-list-args>::
>  	A list of arguments, acceptable to 'git rev-parse' and
> -	'git rev-list', that specifies the specific objects and references
> +	'git rev-list' (and containg a named ref, see SPECIFYING REFERENCES
> +	below), that specifies the specific objects and references
>  	to transport.  For example, `master{tilde}10..master` causes the
>  	current master reference to be packaged along with all objects
>  	added since its 10th ancestor commit.  There is no explicit

Ack on this, too; having it point at "Specifying References" is a good
thing.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
