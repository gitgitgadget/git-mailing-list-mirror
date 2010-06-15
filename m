From: Petr Baudis <pasky@suse.cz>
Subject: Re: [GSoC update] Splitting gitweb & developing write
 functionalities
Date: Tue, 15 Jun 2010 22:17:20 +0200
Message-ID: <20100615201720.GI3109@machine.or.cz>
References: <AANLkTikapZa0N7xroxhdlmm7LUvlNp-7GZy7XeG-zprC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 22:17:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOcZh-00088q-IK
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 22:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762Ab0FOUR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 16:17:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:39535 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab0FOUR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 16:17:27 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6CA4F86208F; Tue, 15 Jun 2010 22:17:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikapZa0N7xroxhdlmm7LUvlNp-7GZy7XeG-zprC@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149221>

Hi!

On Wed, Jun 16, 2010 at 01:33:30AM +0530, Pavan Kumar Sunkara wrote:
> gitweb: Use @diff_opts while using format-patch [master]
> 
> gitweb: Move static files into seperate subdirectory [next]
> gitweb: Set default destination directory for installing gitweb [next]
> git-instaweb: Put httpd logs in a "$httpd_only" subdirectory [next]
> git-instaweb: Configure it to work with new gitweb structure [next]
> git-web--browse: Add support for google chrome and chromium [next]
> Makefile: Use $(sharedir)/gitweb for target 'install-gitweb' [next]
> git-instaweb: Add option to reuse previous config file [next]

Good job!

> gitweb: Create Gitweb::Git module [Work in Progress]
> gitweb: Create Gitweb::Config module [Work in Progress]
> gitweb: Create Gitweb::Request module [Work in Progress]
> gitweb: Create Gitweb::Escape module [Work in Progress]
> gitweb: Create Gitweb::View module [Work in Progress]

(Is this the Gitweb::HTML module? Why have you renamed it?)

> gitweb: Create Gitweb::Util module [Work in Progress]
> gitweb: Create Gitweb::RepoConfig module [Work in Progress]
> gitweb: Create Gitweb::Format module [Work in Progress]
> gitweb: Create Gitweb::Parse module [Work in Progress]

Ok, so we seem to be behind a bit now compared to the timeline? Perhaps
no big deal but we should be careful; maybe you will have to also start
brewing some write-support patches while the structure and details of
the split modules is still undergoing discussion.

Keep up the good work!

-- 
				Petr "Pasky" Baudis
The true meaning of life is to plant a tree under whose shade
you will never sit.
