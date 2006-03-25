From: James Cloos <cloos@jhcloos.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Sat, 25 Mar 2006 04:10:16 -0500
Message-ID: <m31wwqritj.fsf@lugabout.jhcloos.org>
References: <20060322133337.GU20746@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 10:10:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN4n7-0007nY-UN
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 10:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbWCYJK3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 04:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWCYJK3
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 04:10:29 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:16902 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S1751113AbWCYJK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 04:10:28 -0500
Received: from lugabout.jhcloos.org (host-69-48-11-225.roc.choiceone.net [69.48.11.225])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lugabout.jhcloos.org", Issuer "ca.jhcloos.com" (verified OK))
	by ore.jhcloos.com (Postfix) with ESMTP
	id E44871C2EE; Sat, 25 Mar 2006 03:10:21 -0600 (CST)
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 6B2374DCB; Sat, 25 Mar 2006 09:10:16 +0000 (GMT)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060322133337.GU20746@lug-owl.de> (Jan-Benedict Glaw's message
	of "Wed, 22 Mar 2006 14:33:37 +0100")
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:060325:jbglaw@lug-owl.de::AkDCjZWjeaL2IPdP:00000000000000000000000000000000000000000000DTop
X-Hashcash: 1:23:060325:git@vger.kernel.org::/kO7QxstsO0urTr2:000000000000000000000000000000000000000000v2V6
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17965>

Isn't gcc in svn nowadays?

I'd try something like:

rsync://gcc.gnu.org/gcc-svn gcc-svn
git-svnimport -C gcc-git -i -v file:///$(pwd)/gcc-svn

unless you have write access, in which case you may prefer:

mkdir gcc-svn && cd gcc-svn
git-svn init svn+ssh://username@gcc.gnu.org/svn/gcc/trunk
git-svn fetch

-JimC
-- 
James H. Cloos, Jr. <cloos@jhcloos.com>
