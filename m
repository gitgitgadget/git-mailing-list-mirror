From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH/RFC] Teach git-clean optional <paths>... parameters.
Date: Mon, 08 May 2006 18:42:14 -0400
Message-ID: <1147128134.3353.13.camel@dv>
References: <7v1wv4gx0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 00:42:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdEQt-000447-8i
	for gcvg-git@gmane.org; Tue, 09 May 2006 00:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWEHWmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 18:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWEHWmY
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 18:42:24 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:42725 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750740AbWEHWmY
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 May 2006 18:42:24 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FdEQp-0000Y5-1P
	for git@vger.kernel.org; Mon, 08 May 2006 18:42:23 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FdEQh-0000uo-3W; Mon, 08 May 2006 18:42:15 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wv4gx0r.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19779>

On Mon, 2006-05-08 at 12:02 -0700, Junio C Hamano wrote:
> When optional paths arguments are given, git-clean passes them
> to underlying git-ls-files; with this, you can say:
> 
> 	git clean 'temp-*'
> 
> to clean only the garbage files whose names begin with 'temp-'.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
Signed-off-by: Pavel Roskin <proski@gnu.org>

>  * I usually do not use clean myself, so I am not sure if this
>    is the kind of thing people who do use 'clean' regularly
>    would generally want, hence this RFC.

I'm not likely to use this feature, but I think it's OK to have it.

It would be nice to have "--" support (see e.g. git-commit).

> +	-X	remove only ignored files as well

That's my stupid error, "as well" should be removed.

-- 
Regards,
Pavel Roskin
