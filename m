From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH] gitweb: Fix "next" link on bottom of page
Date: Mon, 2 Jun 2008 17:02:19 +0000
Message-ID: <20080602170219.8487.qmail@86b125e51c7491.315fe32.mid.smarden.org>
References: <m3y75s1a9v.fsf@localhost.localdomain> <20080602095348.16843.24351.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kai Blin <kai.blin@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 19:03:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3DRW-0001eb-PO
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 19:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYFBRCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 13:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbYFBRCX
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 13:02:23 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:57741 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751885AbYFBRCX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 13:02:23 -0400
Received: (qmail 8488 invoked by uid 1000); 2 Jun 2008 17:02:19 -0000
Content-Disposition: inline
In-Reply-To: <20080602095348.16843.24351.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83543>

On Mon, Jun 02, 2008 at 11:54:41AM +0200, Jakub Narebski wrote:
> This bug was caused by the fact that git_header_html() modified
> parameters in $cgi->param(...) when generating search form, and
> href(-replay, ...) uses paramemeters values from $cgi, not saved in
> variables (although it could).
> 
> This fixes mentioned bug, not only in the case of 'log' view, but in
> all cases (although it is possible that this bug doesn't occur for
> other pages).

>  gitweb/gitweb.perl |   13 +++++--------
>  1 files changed, 5 insertions(+), 8 deletions(-)

Hi, this fixes the bottom 'next' link in the log view for me, so

Tested-by: Gerrit Pape <pape@smarden.org>

Thanks, Gerrit.
