From: Daniel Cheng <j16sdiz+freenet@gmail.com>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Sat, 16 May 2009 00:00:02 +0800
Message-ID: <guk3i3$dri$1@ger.gmane.org>
References: <op.utv93sdo1e62zd@merlin.emma.line.org> <op.utwdsutn1e62zd@merlin.emma.line.org> <7v8wl01iev.fsf@alter.siamese.dyndns.org> <op.utwyczlf1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 18:00:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4zpm-0001Ww-Ac
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 18:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759848AbZEOQAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 12:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758966AbZEOQAU
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 12:00:20 -0400
Received: from main.gmane.org ([80.91.229.2]:59990 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758863AbZEOQAT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 12:00:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M4zpY-0005pB-CZ
	for git@vger.kernel.org; Fri, 15 May 2009 16:00:16 +0000
Received: from n1164940235.netvigator.com ([116.49.40.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2009 16:00:16 +0000
Received: from j16sdiz+freenet by n1164940235.netvigator.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 May 2009 16:00:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: n1164940235.netvigator.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1b3pre) Gecko/20090223 Thunderbird/3.0b2
In-Reply-To: <op.utwyczlf1e62zd@merlin.emma.line.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119260>

On 14/5/2009 17:37, Matthias Andree wrote:
[...]
> #2: related: git tag -d cannot reliably delete tag objects
>
> Same here: if another tag object references the tag object I'm deleting,
> we only delete the ref, but not the tag object.

> It doesn't (cannot)  become dangling.

This show you have no idea how git works internally.

[...]
