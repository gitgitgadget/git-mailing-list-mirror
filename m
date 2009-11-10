From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 17:20:43 +0100
Message-ID: <hdc3ss$nnr$1@ger.gmane.org>
References: <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com> <20091109210631.GJ27126@dpotapov.dyndns.org> <loom.20091110T093334-810@post.gmane.org> <20091110140428.GL27126@dpotapov.dyndns.org> <loom.20091110T154312-665@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 17:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7tT9-0001ZD-7b
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 17:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756871AbZKJQVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 11:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756835AbZKJQVM
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 11:21:12 -0500
Received: from lo.gmane.org ([80.91.229.12]:47747 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756833AbZKJQVL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 11:21:11 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N7tSu-0001RK-Dy
	for git@vger.kernel.org; Tue, 10 Nov 2009 17:21:08 +0100
Received: from 93-34-221-20.ip51.fastwebnet.it ([93.34.221.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:21:08 +0100
Received: from bonzini by 93-34-221-20.ip51.fastwebnet.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:21:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 93-34-221-20.ip51.fastwebnet.it
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <loom.20091110T154312-665@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132575>

On 11/10/2009 03:54 PM, Dmitry Smirnov wrote:
> This is a cool feature, but it contradicts to my understanding of VCS.

Not really.  As long as the history is not public, nobody will notice.

It is basically the same as using a centralized svn repository 
(corresponding to public branches) and quilt for private patch queues. 
You can push and pop patches as much as you want in quilt, and you can 
rewrite history as much as you want in git private branches.

Now I'm not very proficient with quilt, but if I understood it right, 
git is much easier to do because you use only one tool and thus you can 
rely on the same algorithms for merging and conflict reporting also in 
the case of private branches.  I've certainly done some insane 
reordering of patches and it worked like a charm; also, git keeps a log 
of the states so it takes a single "git diff" invocation to check that 
the end result of a reorganization is the same as what you started from.

Paolo
