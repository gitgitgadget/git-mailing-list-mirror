From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 17:15:23 +0100
Message-ID: <hdc3ir$k81$1@ger.gmane.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <20091109183404.GI27126@dpotapov.dyndns.org> <loom.20091110T092404-595@post.gmane.org> <20091110134540.GK27126@dpotapov.dyndns.org> <loom.20091110T150242-922@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 17:16:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7tO3-0006qj-Q5
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 17:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757128AbZKJQPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 11:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756994AbZKJQPv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 11:15:51 -0500
Received: from lo.gmane.org ([80.91.229.12]:43660 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756939AbZKJQPt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 11:15:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7tNl-0006rr-4z
	for git@vger.kernel.org; Tue, 10 Nov 2009 17:15:49 +0100
Received: from 93-34-221-20.ip51.fastwebnet.it ([93.34.221.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:15:49 +0100
Received: from bonzini by 93-34-221-20.ip51.fastwebnet.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:15:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 93-34-221-20.ip51.fastwebnet.it
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <loom.20091110T150242-922@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132573>


> Perhaps, I have to explain why fix/test cycle is so long. I'm working on mobile
> platform development. It is not so modular, so I need to build the whole image,
> then flash the mobile and test it in a real network. This takes much time and
> need much disk space (about 2GB of source files. In fact, significant number of
> these files are not needed for the build, but it is too hard to force CM
> engineers to fix this :-) )

In that case I think using multiple working trees, but sharing the pack 
files is a good idea.

Paolo
