From: Hugh Davenport <hugh@davenport.net.nz>
Subject: Possible git bug
Date: Wed, 14 Aug 2013 16:50:50 +1200
Message-ID: <9c9e5ea8a9d7e8ef37201cfb8ca9dcc3@davenport.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 14 06:58:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9TAb-000237-Np
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 06:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276Ab3HNE6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 00:58:46 -0400
Received: from 124-197-21-17.callplus.net.nz ([124.197.21.17]:41485 "EHLO
	elm.torus.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab3HNE6q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 00:58:46 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2013 00:58:46 EDT
Received: from mail.davenport.net.nz (ivy.torus.co.nz [10.0.0.4])
	by elm.torus.co.nz (Postfix) with ESMTPSA id 9ACD1202E7
	for <git@vger.kernel.org>; Wed, 14 Aug 2013 16:50:50 +1200 (NZST)
X-Sender: hugh@davenport.net.nz
User-Agent: Roundcube Webmail/0.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232258>

Hey,

Not sure if this is a bug or not. I commonly am finding myself wanting 
to
remove some recent commits, either all or just a select few. So I use 
rebase
in interactive mode for this. The problem I find is that when I do a 
rebase
and leave no commits to pick (where I would think that this would do the 
same
as a reset --hard) just tells me that there is nothing to be done.

So would that be a bug? Or maybe a feature? I would like it that when 
you do
a rebase and select no commits, it will rebase ontop of the commit you 
chose,
and remove all the commits not shown in the interactive listing (so 
all).

Any ideas are welcome.

Cheers,

Hugh
