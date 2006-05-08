From: Pavel Roskin <proski@gnu.org>
Subject: Re: Implementing branch attributes in git config
Date: Mon, 08 May 2006 11:15:45 -0400
Message-ID: <1147101345.27362.15.camel@dv>
References: <1147037659.25090.25.camel@dv>
	 <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	 <Pine.LNX.4.64.0605071718440.3718@g5.osdl.org>
	 <Pine.LNX.4.63.0605080303410.13588@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1147051300.17371.32.camel@dv>
	 <Pine.LNX.4.63.0605080327490.13794@wbgn013.biozentrum.uni-wuerzburg.de>
	 <1147053329.17371.52.camel@dv>  <7vody8howu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 17:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd7TX-0003vU-Sm
	for gcvg-git@gmane.org; Mon, 08 May 2006 17:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWEHPQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 11:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbWEHPQ1
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 11:16:27 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:39324 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932378AbWEHPQO
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 8 May 2006 11:16:14 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fd7Ss-00070z-IR
	for git@vger.kernel.org; Mon, 08 May 2006 11:16:11 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fd7Sb-0007i2-Nx; Mon, 08 May 2006 11:15:45 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vody8howu.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19768>

On Mon, 2006-05-08 at 02:00 -0700, Junio C Hamano wrote:
> Stating what you do not like about something is a good first
> step to improve that something.  It should not be too hard to
> extend the parser to grok:
> 
> 	repo-config --get branchdata.description '\(.*\) for netdev$'
> 
> and when the value_regex has a capture return what matches
> instead of the entire value.  I think that would do what you
> want.

OK, that would be acceptable.

I still don't like the "for" conversion because it masquerades syntax
(note that text to right of "for" must be unique) as plain text, but
it's a matter of taste, so it's hard for me to argue about it.

-- 
Regards,
Pavel Roskin
