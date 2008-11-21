From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: git-status for submodules
Date: Fri, 21 Nov 2008 16:56:08 -0500
Message-ID: <20081121215608.GA27049@foursquare.net>
References: <20081120033615.GA21128@foursquare.net> <7vabbtqga8.fsf@gitster.siamese.dyndns.org> <200811211627.10637.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 22:57:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3e0X-0000xv-NU
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 22:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbYKUV4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 16:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbYKUV4X
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 16:56:23 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:52340 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbYKUV4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 16:56:22 -0500
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id mALLu8ll029670;
	Fri, 21 Nov 2008 16:56:09 -0500
Content-Disposition: inline
In-Reply-To: <200811211627.10637.johan@herland.net>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101543>

On Fri, Nov 21, 2008 at 04:27:10PM +0100, Johan Herland wrote:
> Chris' workflow is farily easily supported by running git-status within 
> each submodule, like this:
> 
> git submodule foreach "git status; true"
> 
> If the above is too cumbersome to type, one can easily wrap an alias 
> around it:
> 
> git config alias.substatus 'submodule foreach "git status; true"'
> git substatus

Fascinating. :-)  This is not yet released, I see, but thanks very much.

Looking at the git sources, submodule foreach doesn't seem to recurse,
for the nested submodule case Junio mentioned.  It's still a good start.

- Chris
