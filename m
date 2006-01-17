From: Gerrit Pape <pape@smarden.org>
Subject: Re: [ANNOUNCE] Cogito-0.16.3
Date: Tue, 17 Jan 2006 08:07:36 +0000
Message-ID: <20060117080736.12033.qmail@4af7d036c9451c.315fe32.mid.smarden.org>
References: <20060116015141.GG28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 17 09:07:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EylsC-0004gr-2L
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 09:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWAQIHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 03:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWAQIHU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 03:07:20 -0500
Received: from a.mx.smarden.org ([212.21.76.77]:18394 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751306AbWAQIHT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 03:07:19 -0500
Received: (qmail 12034 invoked by uid 1000); 17 Jan 2006 08:07:36 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060116015141.GG28365@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14785>

On Mon, Jan 16, 2006 at 02:51:41AM +0100, Petr Baudis wrote:
>   Hello,
> 
>   this is Cogito version 0.16.3, the next stable release of the
> human-friendly version control UI for the Linus' GIT tool. Share
> and enjoy at:
> 
> 	http://www.kernel.org/pub/software/scm/cogito/

Hi, the cg-clone program in the tarball has permissions 666, breaking
the selftest t9105, unless you have another cg-clone program in PATH;
and if so, the other cg-clone is tested instead of the new one.

 $ wget -q -O- kernel.org/pub/software/scm/cogito/cogito-0.16.3.tar.gz | 
   tar tzvf - cogito-0.16.3/cg-clone
 -rw-rw-rw- git/git        2483 2006-01-16 01:39:11 cogito-0.16.3/cg-clone
 
Regards, Gerrit.
