From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Something is broken in repack
Date: Fri, 14 Dec 2007 07:14:14 +0100
Message-ID: <fjt6vm$n7d$1@ger.gmane.org>
References: <alpine.LFD.0.99999.0712120743040.555@xanadu.home> <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com> <fjrj9k$n6k$1@ger.gmane.org> <47616044.7070504@viscovery.net> <fjskqt$eap$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gcc@gcc.gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 07:15:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J33p8-0007jj-3Q
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbXLNGOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 01:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752724AbXLNGOj
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:14:39 -0500
Received: from main.gmane.org ([80.91.229.2]:38889 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995AbXLNGOj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:14:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J33oh-0006wz-Ae
	for git@vger.kernel.org; Fri, 14 Dec 2007 06:14:35 +0000
Received: from 213-140-22-65.fastres.net ([213.140.22.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 06:14:35 +0000
Received: from bonzini by 213-140-22-65.fastres.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 06:14:35 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 213-140-22-65.fastres.net
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <fjskqt$eap$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68233>

> Hmmm... it is even documented in git-gc(1)... and git-index-pack(1) of
> all things.

I found that the .keep file is not transmitted over the network (at 
least I tried with git+ssh:// and http:// protocols), however.

Paolo
