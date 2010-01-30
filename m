From: Petr Baudis <pasky@suse.cz>
Subject: Re: FEATURE REQUEST: Allow SSH style URLS (with extra colon)
Date: Sat, 30 Jan 2010 23:21:57 +0100
Message-ID: <20100130222157.GI9553@machine.or.cz>
References: <87tyu3cyy3.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 23:22:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLhg-0004qK-K5
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab0A3WWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002Ab0A3WWA
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:22:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37184 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669Ab0A3WWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:22:00 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7FB3C86202A; Sat, 30 Jan 2010 23:21:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87tyu3cyy3.fsf@jondo.cante.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138502>

On Sat, Jan 30, 2010 at 06:57:56PM +0200, Jari Aalto wrote:
> 
> According to git-clone[1] the SSH protocol is specied as:
> 
>     ssh://[user@]host.xz[:port]/path
> 
> It woudl be nice if the ":" were allowed, so that the familiar SSH style
> patch notation could be used, making the spec:
> 
>     ssh://[user@]host.xz[:[port]]/path
> 
> An example:
> 
>     ssh://foo@examplecom:/path
>                         |
>                         Allowed

But that's not an URL anymore. If you want to use ssh pathspec, write it
as a pathspec, not an URL. Just foo@example.com:/path works fine. ;-)

				Petr "Pasky" Baudis
