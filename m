From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: CGit and repository list
Date: Fri, 12 Sep 2008 09:00:06 -0700
Message-ID: <20080912160006.GI22960@spearce.org>
References: <19449377.post@talk.nabble.com> <8c5c35580809120736x4170b2dbq3438bd619326ae00@mail.gmail.com> <20080912145804.GF10544@machine.or.cz> <200809121754.30277.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:01:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeB5A-0002tq-33
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYILQAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbYILQAH
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:00:07 -0400
Received: from george.spearce.org ([209.20.77.23]:40602 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbYILQAG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 12:00:06 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1845E3835C; Fri, 12 Sep 2008 16:00:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809121754.30277.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95743>

Jakub Narebski <jnareb@gmail.com> wrote:
> Petr Baudis wrote:
> > 
> >   this finally tripped me over and I wanted to quickly add cgit as an
> > alternate viewing interface at repo.or.cz. [...]
> 
> Or you can wait a little while for "smart" HTTP server, which I guess
> also generates automatically or/and on the fly objects/info/packs and
> info/refs required by "dumb" protocols clients (including old HTTP
> clients).

The automatic generation of objects/info/packs and info/refs is
planned for support in the smart CGI, but it doesn't help the
"gitweb URL is same as clone URL" concept.  For that you need your
HTTP server to know how to issue some requests to gitweb and others
to the smart CGI or to the filesystem.
 
> P.S. Could you please gather some statistics to compare the period
> before and after installing "smart" HTTP server (and after smart
> clients became widespread).

Well, it would help if there was a working implementation of the
"smart" HTTP server.  ;-)

Right now I haven't been able to touch the project for two weeks
straight.  I'm hoping to be able to put 2 full days into it next
week.  Lets see how that plan works.

-- 
Shawn.
