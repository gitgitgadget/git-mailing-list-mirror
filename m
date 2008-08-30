From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Replace "git-" with "git " in *.[ch] comments and notifications
Date: Sat, 30 Aug 2008 13:29:46 +0200
Message-ID: <200808301329.46226.chriscool@tuxfamily.org>
References: <20080829234751.GA2396@zakalwe.fi> <20080830011509.GA16289@zakalwe.fi> <7vr6872qv1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Heikki Orsila <heikki.orsila@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 13:27:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZObn-00054d-94
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 13:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbYH3L0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 07:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbYH3L0F
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 07:26:05 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:49838 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017AbYH3L0E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 07:26:04 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id CDB9512B6FD;
	Sat, 30 Aug 2008 13:26:00 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 9258112B6F6;
	Sat, 30 Aug 2008 13:26:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vr6872qv1.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94375>

Le samedi 30 ao=FBt 2008, Junio C Hamano a =E9crit :
> One thing you might be able to do would be to separate user visible
> strings and in-comment strings.  Frankly, when a comment talks about =
a
> git subprogram, blindly replacing s/-/ / makes it _far worse_ and the
> resulting text is harder to read for git hackers (who are primary
> audiences of comments).  E.g. taking one random example from your pat=
ch:
>
> diff --git a/builtin-init-db.c b/builtin-init-db.c
> index baf0d09..81aa822 100644
> --- a/builtin-init-db.c
> +++ b/builtin-init-db.c
> @@ -37,7 +37,7 @@ static void copy_templates_1(char *path, int basele=
n,
>
>  	/* Note: if ".git/hooks" file exists in the repository being
>  	 * re-initialized, /etc/core-git/templates/hooks/update would
> -	 * cause git-init to fail here.  I think this is sane but
> +	 * cause git init to fail here.  I think this is sane but
>  	 * it means that the set of templates we ship by default, along
>  	 * with the way the namespace under .git/ is organized, should
>  	 * be really carefully chosen.
>
> I do not think this is an improvement.  We are talking about a single
> subprogram, not what the user types from the command line.  Either of
> these two would be easier to read:
>
> 	... would cause git-init to fail here...
>         ... would cause "init" to fail here...

I think "git init" is even better, as "init" could be ambiguous.

> than:
>
>         ... would cause git init to fail here...
>
> Among these three, I think the second one is the most readable.  Perh=
aps
> dropping "git-" prefix when we are talking about a git subprogram, an=
d
> quoting the word to make it stand out, could be a good approach , tha=
n
> replacing it with "git " prefix.

Regards,
Christian.
