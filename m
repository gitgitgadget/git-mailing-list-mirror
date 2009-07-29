From: Oswald Buddenhagen <oswald.buddenhagen@nokia.com>
Subject: Re: [PATCH] Allow author names with just two letters.
Date: Wed, 29 Jul 2009 16:55:18 +0200
Message-ID: <20090729145518.GA8743@troll08.nokia.trolltech.de>
References: <20090710200134.GA30032@troll08.nokia.trolltech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 16:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWAYw-0006Vv-Eb
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 16:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZG2OzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 10:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbZG2OzS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 10:55:18 -0400
Received: from ktown.kde.org ([131.246.120.250]:37877 "HELO ktown.kde.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751447AbZG2OzR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 10:55:17 -0400
Received: (qmail 23069 invoked from network); 29 Jul 2009 14:55:15 -0000
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Jul 2009 14:55:15 -0000
Received: from obuddenh by troll08.nokia.trolltech.de with local
 (masqmail 0.2.21) id 1MWAYo-2LA-00 for <git@vger.kernel.org>; Wed, 29
 Jul 2009 16:55:18 +0200
Content-Disposition: inline
In-Reply-To: <20090710200134.GA30032@troll08.nokia.trolltech.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124356>

moin,

just in case this wasn't clear: the patch below is a request to merge,
or at least an rfc. you see, i have a rather bad standing in getting my
colleagues to use rebase if git mangles their commits in the process. ;)
thanks

greetings


On Fri, Jul 10, 2009 at 10:01:34PM +0200, Oswald Buddenhagen wrote:
> Some at Qt Software use aliases which may have only two letters.
> 
> One could argue that just one letter should be permitted as well,
> but that's none of my concerns. :)
> ---
>  builtin-mailinfo.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 1eeeb4d..1adbebd 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -35,7 +35,7 @@ static void cleanup_space(struct strbuf *sb);
>  static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf *email)
>  {
>  	struct strbuf *src = name;
> -	if (name->len < 3 || 60 < name->len || strchr(name->buf, '@') ||
> +	if (name->len < 2 || 60 < name->len || strchr(name->buf, '@') ||
>  		strchr(name->buf, '<') || strchr(name->buf, '>'))
>  		src = email;
>  	else if (name == out)
> -- 
> 1.6.3.3.18.g49902.dirty
> 
