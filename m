From: Chris Shenton <chris@koansys.com>
Subject: git svn "error": RA layer request failed: MERGE of [path]: 200 OK
Date: Mon, 29 Mar 2010 08:29:42 -0400
Message-ID: <D73B7319-8005-4AFD-AEB4-7EF9A446D869@koansys.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 29 14:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwECc-00083C-R6
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 14:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab0C2MgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 08:36:17 -0400
Received: from koansys.com ([71.246.241.106]:64789 "EHLO shenton.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab0C2MgQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Mar 2010 08:36:16 -0400
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2010 08:36:16 EDT
Received: from mackeral.shenton.org (Mackeral.shenton.org [192.168.255.202])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: chris)
	by Boqueria.shenton.org (Postfix) with ESMTPSA id 5E5086A
	for <git@vger.kernel.org>; Mon, 29 Mar 2010 08:29:42 -0400 (EDT)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143463>

I'm using git svn to talk to an SVN repo accessed by https.  When I try to dcommit a change I get something which appears to be an error, but if I understand the reponse code it's talking about, it seems OK:

> $ git svn dcommit
> Committing to https://koansys.com/svn/dha/buildout/branches/buildout_xdv ...
> 	M	buildout.cfg
> RA layer request failed: MERGE of '/Svn/dha/buildout/branches/buildout_xdv': 200 OK (https://koansys.com) at /usr/local/Cellar/git/1.6.6.1/libexec/git-core/git-svn line 564

I thought this one had failed, and tried again, but it indicated doing so was a merge conflict:
> 
> $ git svn dcommit
> Committing to https://koansys.com/svn/dha/buildout/branches/buildout_xdv ...
> Merge conflict during commit: File or directory 'buildout.cfg' is out of date; try updating: resource out of date; try updating at /usr/local/Cellar/git/1.6.6.1/libexec/git-core/git-svn line 564

Can anyone explain the first message? Is it a git problem, an svn problem, or something else?

Thanks.
