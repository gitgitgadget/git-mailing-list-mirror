From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Do not use C++-style comments
Date: Mon, 22 Aug 2011 13:55:51 +0200
Message-ID: <201108221355.52269.johan@herland.net>
References: <1314009232-6194-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 22 13:56:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvT6y-0004uM-NK
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 13:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab1HVL4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 07:56:08 -0400
Received: from smtp.opera.com ([213.236.208.81]:35196 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623Ab1HVL4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 07:56:05 -0400
Received: from johanh.localnet (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p7MBtrXK021779
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Aug 2011 11:55:54 GMT
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-Reply-To: <1314009232-6194-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179855>

On Monday 22. August 2011, Michael Haggerty wrote:
> Detected by "gcc -std=iso9899:1990 ...".  This patch applies against
> "maint".
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  notes.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/notes.c b/notes.c
> index f6ce848..93e9868 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -1105,7 +1105,7 @@ int remove_note(struct notes_tree *t, const
> unsigned char *object_sha1) hashcpy(l.key_sha1, object_sha1);
>  	hashclr(l.val_sha1);
>  	note_tree_remove(t, t->root, 0, &l);
> -	if (is_null_sha1(l.val_sha1)) // no note was removed
> +	if (is_null_sha1(l.val_sha1)) /* no note was removed */

ACK!


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
