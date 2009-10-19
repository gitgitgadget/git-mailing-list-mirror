From: Gabor Gombas <gombasg@sztaki.hu>
Subject: Re: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 20:36:55 +0200
Message-ID: <20091019183655.GC3630@boogie.lpds.sztaki.hu>
References: <loom.20091019T094924-194@post.gmane.org>
 <4ADC2D45.3020803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 20:44:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzxD7-0001wF-R1
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 20:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbZJSSnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 14:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbZJSSnv
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 14:43:51 -0400
Received: from boogie.lpds.sztaki.hu ([193.224.70.237]:58122 "EHLO
	boogie.lpds.sztaki.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbZJSSnv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 14:43:51 -0400
X-Greylist: delayed 418 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2009 14:43:51 EDT
Received: by boogie.lpds.sztaki.hu (Postfix, from userid 1000)
	id 69CE2C5AA9; Mon, 19 Oct 2009 20:36:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4ADC2D45.3020803@viscovery.net>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130724>

On Mon, Oct 19, 2009 at 11:11:33AM +0200, Johannes Sixt wrote:

> > Is there a means to have fsck to a truly full check on the sanity of a repo?
> 
> git fsck --full
> 
> RTFM, please.

That still does not catch everything. About a week ago I wanted to check
out a branch in a local repo and I got an error that it was corrupt. But
"git fsck --full" only complained about some dangling objects, it did
not notice the corruption. I used git version 1.6.4.3 (Debian unstable
at that time). It would be nice to have a
"git fsck --i-really-want-to-check-everything".

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
