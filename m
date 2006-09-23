From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Consolidate escaping/validation of query string
Date: Sun, 24 Sep 2006 00:41:43 +0200
Organization: At home
Message-ID: <ef4d6v$7vk$3@sea.gmane.org>
References: <20060923221841.18063.56589.stgit@rover> <ef4csl$7vk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 24 00:45:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRGFL-00045N-GO
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 00:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWIWWpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 18:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWIWWpJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 18:45:09 -0400
Received: from main.gmane.org ([80.91.229.2]:19367 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750849AbWIWWpG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 18:45:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GRGF3-00041e-Tk
	for git@vger.kernel.org; Sun, 24 Sep 2006 00:45:01 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 00:45:01 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 00:45:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27638>

Jakub Narebski wrote:

> I'd rather have new esc_param() or esc_param_value() quote like escape
> subroutine from CGI::Util, with the esception of _not_ escaping '/'
> (it makes funny bookmark, and lot less readable query string), and rename
> current esc_param() to esc_query_string() or esc_params().

Or just esc_url()
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
