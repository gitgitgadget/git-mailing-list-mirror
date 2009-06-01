From: Nikos Chantziaras <realnc@arcor.de>
Subject: Re: "exclude" and ".gitignore" for everyone
Date: Mon, 01 Jun 2009 17:16:04 +0300
Organization: Lucas Barks
Message-ID: <h00nqe$mj4$1@ger.gmane.org>
References: <h00m32$gs0$2@ger.gmane.org> <E6F58E6B-4ECF-4A55-9249-9A8BBFBDBC24@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 16:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB8JB-0006ci-UH
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 16:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbZFAOQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 10:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbZFAOQE
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 10:16:04 -0400
Received: from main.gmane.org ([80.91.229.2]:46032 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbZFAOQD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 10:16:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MB8Ix-0004eK-Us
	for git@vger.kernel.org; Mon, 01 Jun 2009 14:15:59 +0000
Received: from athedsl-388897.home.otenet.gr ([79.131.71.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 14:15:59 +0000
Received: from realnc by athedsl-388897.home.otenet.gr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Jun 2009 14:15:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: athedsl-388897.home.otenet.gr
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <E6F58E6B-4ECF-4A55-9249-9A8BBFBDBC24@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120471>

Brian Gernhardt wrote:
> On Jun 1, 2009, at 9:46 AM, Nikos Chantziaras wrote:
>> [...]
>> For example I've put "*.[oa]" and "*~" in ./git/info/exclude.  
>> However, the rest of the persons doing commits in the public 
>> repository might not have those entries.  Is everyone required to put 
>> those entries in "exclude" themselves or does Git allow for those to 
>> be automatically added next time they do a "git pull"?
> 
> If you commit a .gitignore, it will be used by everyone.  
> .git/info/exclude is for your personal excludes.  Generally, I'd suggest 
> putting build products in .gitignore and your editor's garbage in 
> exclude.
> [...]
> If you add and commit the .gitignore file it will be picked up by 
> everyone, while whatever backups, temp files, notes, or whatever you use 
> can be kept private in your exclude file.

Thanks, Brian!
