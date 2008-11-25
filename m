From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 02:37:58 +0200
Message-ID: <20081125003758.GA6115@zakalwe.fi>
References: <962463.96236.qm@web37905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 01:59:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4mH4-000701-SD
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 01:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755446AbYKYA6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2008 19:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755167AbYKYA6G
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 19:58:06 -0500
Received: from zakalwe.fi ([80.83.5.154]:33605 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056AbYKYA6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 19:58:05 -0500
X-Greylist: delayed 1204 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Nov 2008 19:58:05 EST
Received: by zakalwe.fi (Postfix, from userid 1023)
	id E10FE2BBE8; Tue, 25 Nov 2008 02:37:58 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <962463.96236.qm@web37905.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101641>

On Mon, Nov 24, 2008 at 04:32:58PM -0800, Gary Yang wrote:
> 
> We have two repositories, one is /pub/git/dev/linux/kernel, another 
> is /pub/git/pub/linux/kernel. The /pub/git/pub/linux/kernel is open to 
> public for people to download released code. /pub/git/dev/linux/kernel 
> is used for our development. We would like to hide 
> /pub/git/dev/linux/kernel from public. How to do it?

Tell "git daemon" only to publish /pub/git/pub/linux/kernel.

-- 
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
