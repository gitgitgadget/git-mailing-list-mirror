From: Joey Hess <joey@kitenet.net>
Subject: Re: 'commit -a' safety
Date: Sat, 24 Apr 2010 10:28:48 -0400
Message-ID: <20100424142848.GA4461@gnu.kitenet.net>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
 <m3633hdw9u.fsf_-_@localhost.localdomain>
 <AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com>
 <201004241348.49397.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 16:36:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5gTB-0005E2-2r
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 16:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818Ab0DXOg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 10:36:27 -0400
Received: from wren.kitenet.net ([80.68.85.49]:34985 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab0DXOg0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 10:36:26 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Apr 2010 10:36:26 EDT
Received: from gnu.kitenet.net (fttu-216-41-255-233.btes.tv [216.41.255.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 616A1119056
	for <git@vger.kernel.org>; Sat, 24 Apr 2010 10:28:50 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 4860E49A1C; Sat, 24 Apr 2010 10:28:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <201004241348.49397.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145681>

Jakub Narebski wrote:
> What you cant recover by undoing commit is the state of index before
> accidental 'git commit -a' instead of 'git commit'.

Has a reflog equivilant for the index, to allow resetting it to a
previous state, ever been discussed? 

I don't grok its data structure -- could that be done efficiently?

-- 
see shy jo
