From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Documentation: fix a few typos in git-notes.txt
Date: Thu, 4 Mar 2010 18:08:45 +0100
Message-ID: <201003041808.45482.johan@herland.net>
References: <4a44449489fa80dd3e7d04b7de6c69797f91f422.1267712760.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 04 18:19:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnEiF-00065D-6W
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 18:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120Ab0CDRTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 12:19:46 -0500
Received: from smtp.opera.com ([213.236.208.81]:51308 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078Ab0CDRTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 12:19:45 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o24H8jgZ017277
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Mar 2010 17:08:51 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4a44449489fa80dd3e7d04b7de6c69797f91f422.1267712760.git.git@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141534>

On Thursday 04 March 2010, Michael J Gruber wrote:
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

Acked-by: Johan Herland <johan@herland.net>


...Johan

> ---
> This is based on next and is orthogonal to tr/notes-display in pu.
>
>  Documentation/git-notes.txt |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-notes.txt
> b/Documentation/git-notes.txt index 14f73b9..bef2f39 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -46,13 +46,13 @@ list::
>
>  add::
>  	Add notes for a given object (defaults to HEAD). Abort if the
> -	object already has notes, abort. (use `-f` to overwrite an
> +	object already has notes (use `-f` to overwrite an
>  	existing note).
>
>  copy::
>  	Copy the notes for the first object onto the second object.
>  	Abort if the second object already has notes, or if the first
> -	objects has none. (use -f to overwrite existing notes to the
> +	object has none (use -f to overwrite existing notes to the
>  	second object). This subcommand is equivalent to:
>  	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`



-- 
Johan Herland, <johan@herland.net>
www.herland.net
