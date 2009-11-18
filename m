From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: git-svn of both trunk and tags while having no access to the
 'parent' of those
Date: Wed, 18 Nov 2009 08:32:05 -0500
Message-ID: <20091118133205.GB17964@onerussian.com>
References: <20091117025945.GE17964@onerussian.com>
 <4B03B7D3.8050905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:32:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkdp-00062l-4o
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040AbZKRNcA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757035AbZKRNcA
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:32:00 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:54043 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033AbZKRNb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 08:31:59 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NAkdh-0002wx-D0; Wed, 18 Nov 2009 08:32:05 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1NAkdh-0002wu-7n; Wed, 18 Nov 2009 08:32:05 -0500
Content-Disposition: inline
In-Reply-To: <4B03B7D3.8050905@drmicha.warpmail.net>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@drmicha.warpmail.net, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133172>


On Wed, 18 Nov 2009, Michael J Gruber wrote:

> > git svn clone --prefix=upstream-svn/ -T trunk -t releases http://domain.com/svnrepo svnrepo.gitsvn

> Your problem description seems to match perfectly with the description
> of the "--no-minimize-url" option in git svn's man page. I'm sure it's
> worth a try.

;-) oh I did I did ;)
I've used

git svn clone --no-minimize-url --prefix=upstream-svn/ -T trunk -t releases  http://domain.com/svnrepo/trunk svnrepo.gitsvn

that initialized repository, went through a lengthy list of 

trace: built-in: git 'config' 'svn-remote.svn.tags-maxRev' '...'

with last command reported

trace: built-in: git 'gc' '--auto'

and resulted in nothing being cloned/checked out or even a single ref.
The only file under .git besides the ones created by git init

./svn/refs/remotes/upstream-svn/trunk/.rev_map.33fb83da-1015-0410-9b9b-96027f9a4af8

and if I omitted trunk/ from url -- the same story of needed
authentication

-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
