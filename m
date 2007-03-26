From: Nicolas Vilz <niv@iaglans.de>
Subject: Re: git-send-email and aliases
Date: Mon, 26 Mar 2007 12:08:49 +0200
Message-ID: <20070326100849.GA5822@fry.bender.fht>
References: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 12:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVmRy-00011h-A0
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 12:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbXCZK25 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 06:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753634AbXCZK25
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 06:28:57 -0400
Received: from mail.hs-esslingen.de ([134.108.32.78]:51557 "EHLO
	mail.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbXCZK24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 06:28:56 -0400
X-Greylist: delayed 1199 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Mar 2007 06:28:56 EDT
Received: from localhost (mail.hs-esslingen.de [134.108.32.78])
	by mail.hs-esslingen.de (Postfix) with ESMTP id F02EB13EEB;
	Mon, 26 Mar 2007 12:08:54 +0200 (CEST)
Received: from mail.hs-esslingen.de ([134.108.32.78])
	by localhost (rslx211 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27590-10; Mon, 26 Mar 2007 12:08:51 +0200 (CEST)
Received: from localhost (ovpn66102.hs-esslingen.de [134.108.66.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.hs-esslingen.de (Postfix) with ESMTP id BF90E13EF1;
	Mon, 26 Mar 2007 12:08:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <38b2ab8a0703260239j3f3f0be2teee70fc502f6f7c1@mail.gmail.com>
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at hs-esslingen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43149>

On Mon, Mar 26, 2007 at 11:39:52AM +0200, Francis Moreau wrote:
> Hi,
> 
> I'm trying to make an alias for 'git send-email' as following but it's
> not working:
> 
> [alias]
> 	send-email = send-email --no-signed-off-cc --suppress-from
> 
> Is it failing because git-send-email is an external command ?

i remember that if this command exists in git (built-in or script), then
the built-in is used, for not breaking any scripts. I think, if you set
sm or s-m or something like that, it would work.

Sincerly
Nicolas
