From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.16.4
Date: Tue, 17 Jan 2006 20:48:21 +0100
Message-ID: <20060117194821.GJ28365@pasky.or.cz>
References: <20060116015141.GG28365@pasky.or.cz> <20060117080736.12033.qmail@4af7d036c9451c.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Feb 01 09:28:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-relay.eunet.no ([193.71.71.242])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4DLL-0002Y2-3Y
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 09:27:59 +0100
Received: from vger.kernel.org (vger.kernel.org [209.132.176.167])
	by mail-relay.eunet.no (8.13.1/8.13.1/GN) with ESMTP id k0HJmWX6070703
	for <gcvg-git@gmane.org>; Tue, 17 Jan 2006 20:48:39 +0100 (CET)
	(envelope-from git-owner@vger.kernel.org)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWAQTrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 14:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWAQTrM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 14:47:12 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35226 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932413AbWAQTrL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 14:47:11 -0500
Received: (qmail 8082 invoked by uid 2001); 17 Jan 2006 20:48:21 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060117080736.12033.qmail@4af7d036c9451c.315fe32.mid.smarden.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15394>

Dear diary, on Tue, Jan 17, 2006 at 09:07:36AM CET, I got a letter
where Gerrit Pape <pape@smarden.org> said that...
> On Mon, Jan 16, 2006 at 02:51:41AM +0100, Petr Baudis wrote:
> >   Hello,
> > 
> >   this is Cogito version 0.16.3, the next stable release of the
> > human-friendly version control UI for the Linus' GIT tool. Share
> > and enjoy at:
> > 
> > 	http://www.kernel.org/pub/software/scm/cogito/
> 
> Hi, the cg-clone program in the tarball has permissions 666, breaking
> the selftest t9105, unless you have another cg-clone program in PATH;
> and if so, the other cg-clone is tested instead of the new one.
> 
>  $ wget -q -O- kernel.org/pub/software/scm/cogito/cogito-0.16.3.tar.gz | 
>    tar tzvf - cogito-0.16.3/cg-clone
>  -rw-rw-rw- git/git        2483 2006-01-16 01:39:11 cogito-0.16.3/cg-clone

Good catch, thanks. I've just released a quickfix Cogito version 0.16.4,
fixing this and a spurious read when committing a squash merge reported
by Jonas Fonseca.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
