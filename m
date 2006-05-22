From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] tutorial: expanded discussion of commit history
Date: Mon, 22 May 2006 11:01:20 +0200
Organization: At home
Message-ID: <e4ruku$5uk$1@sea.gmane.org>
References: <1148255528.61d5d241.0@fieldses.org> <1148255528.61d5d241.1@fieldses.org> <e4rsef$v34$1@sea.gmane.org> <7vzmhacuso.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 22 11:01:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi6IJ-0001MB-Qh
	for gcvg-git@gmane.org; Mon, 22 May 2006 11:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWEVJBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 05:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWEVJBd
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 05:01:33 -0400
Received: from main.gmane.org ([80.91.229.2]:55702 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750740AbWEVJBc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 05:01:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fi6I1-0001Jo-UU
	for git@vger.kernel.org; Mon, 22 May 2006 11:01:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 May 2006 11:01:25 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 May 2006 11:01:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20492>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> J. Bruce Fields wrote:
>>
>>> +Finally, most commands that take filenames will optionally allow you
>>> +to precede any filename by a commit, to specify a particular version
>>> +fo the file:
>>> +
>>> +-------------------------------------
>>> +$ git diff v2.5:Makefile HEAD:Makefile.in
>>> +-------------------------------------
>>
>> Why not mention also :<stage>:<filename>, or would <stage> be not defined
in
>> this place of tutorial?
> 
> I do not think being able to do diff with arbitrary stage is
> often used in practice.  By definition, you would want to do
> diff with a stage during a conflicted merge, and most of the
> time the default combined diff without any colon form should
> give you the most useful results.  Also, ":<path>" to mean the
> entry in the index is often equivalent to "git diff --cached".
> 
> IOW, these are obscure special purpose notation, and I do not
> think tutorial is a good place to cover them.

Hmmm... perhaps in tutorial-3.txt, covering merges and how to resolve
conflicted merge, cherry picking, reverting and rebasing. And of course
some git workflows covering usage of branches (including pull/push,
fast-forward and "union" branches like 'pu' branch in git).

Well, perhaps not tutorial, but Git Cookbook, or Git Receipies, 
or Git Usage Examples,...

-- 
Jakub Narebski
Warsaw, Poland
