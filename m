From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: BUG?? INSTALL MAKEFILE
Date: Tue, 06 Jan 2009 14:44:23 -0500
Message-ID: <4963B497.4000104@tedpavlic.com>
References: <49635BF8.1010700@sadau-online.de> <vpqiqosa3fc.fsf@bauges.imag.fr> <49638625.3090109@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:45:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKHs7-0008Sf-3R
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 20:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbZAFTo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 14:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbZAFTo2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 14:44:28 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:34714 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751594AbZAFTo1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jan 2009 14:44:27 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 9CFE580D803F
	for <git@vger.kernel.org>; Tue,  6 Jan 2009 14:38:54 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qkh4DMb6KSN4 for <git@vger.kernel.org>;
	Tue,  6 Jan 2009 14:38:54 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.166.97])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 88C4B80D803B
	for <git@vger.kernel.org>; Tue,  6 Jan 2009 14:38:54 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <49638625.3090109@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104714>

> 	git clean -f

DOH. I meant to do

	git clean -fx

(or just a git ls-files). That config.mak.autogen is certainly not 
checked into the repo, and a quick test confirms that "make install" 
certainly does set prefix to the home directory.

That being said, I'm sure that in the recent past I had to use configure 
to install git into home directories.

--Ted


-- 
Ted Pavlic <ted@tedpavlic.com>
