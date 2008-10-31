From: 7rans <transfire@gmail.com>
Subject: Re: commit type
Date: Fri, 31 Oct 2008 19:20:57 +0000 (UTC)
Message-ID: <loom.20081031T191102-81@post.gmane.org>
References: <loom.20081031T174821-603@post.gmane.org> <ee77f5c20810311104m6044bf70r1d9d405fa04454e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 20:22:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvzZh-0002B9-Cl
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbYJaTVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 15:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbYJaTVM
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:21:12 -0400
Received: from main.gmane.org ([80.91.229.2]:44009 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbYJaTVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 15:21:12 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KvzYP-0005dK-V1
	for git@vger.kernel.org; Fri, 31 Oct 2008 19:21:05 +0000
Received: from 216.241.118.70.cfl.res.rr.com ([70.118.241.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 19:21:05 +0000
Received: from transfire by 216.241.118.70.cfl.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 19:21:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 70.118.241.216 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99624>

David Symonds <dsymonds <at> gmail.com> writes:

> 
> On Fri, Oct 31, 2008 at 10:58 AM, 7rans <transfire <at> gmail.com> wrote:
> 
> > Currently I achieve this by adding "[type]" to the end of my commit messages.
> > But of course that's less than optimal.
> 
> Why is that less than optimal? It seems a lot less intrusive than what
> you suggest.

Because it becomes formalized. Which means people can write tools other people
can use to work with them.

Having the type embedded in commit message not only clutters up the commit
messages, but different people would do it differently, using different brackets
or putting it the start or the end of the message, etc. 

And of course it would be easier to ask git to list certain types of commits if
it knew about them.

7rans.
