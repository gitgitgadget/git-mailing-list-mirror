From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: How to do with access control per repo with a smart http git server?
Date: Wed, 24 Nov 2010 10:13:28 +0000 (UTC)
Message-ID: <loom.20101124T110708-253@post.gmane.org>
References: <loom.20101124T035911-773@post.gmane.org> <20101124045025.GA12399@LK-Perkele-V2.elisa-laajakaista.fi> <loom.20101124T060650-817@post.gmane.org> <20101124060813.GA12949@LK-Perkele-V2.elisa-laajakaista.fi> <loom.20101124T082340-444@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 11:13:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLCMG-00007k-UQ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 11:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab0KXKNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 05:13:43 -0500
Received: from lo.gmane.org ([80.91.229.12]:47798 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723Ab0KXKNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 05:13:42 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PLCM9-0008VK-EZ
	for git@vger.kernel.org; Wed, 24 Nov 2010 11:13:41 +0100
Received: from 119.233.251.15 ([119.233.251.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 11:13:41 +0100
Received: from zhangchunlin by 119.233.251.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 11:13:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 119.233.251.15 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162057>

Chunlin Zhang <zhangchunlin <at> gmail.com> writes:

> I am trying to write some python script to do access control work using apache
> mod_wsgi now.

I have just finished some python scripts working in apache+mod_wsgi
environment,authentication part using ldap(in my win32 server case I use to auth
with Active Directory server),and configure the acl using a acl file just like
the file svn use(
http://svnbook.red-bean.com/en/1.4/svn.serverconfig.pathbasedauthz.html ),but
not Path-Based,just repo-based.

If it is useful to someone else,can email me and I will share it.

> 
