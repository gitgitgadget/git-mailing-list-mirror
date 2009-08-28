From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Fri, 28 Aug 2009 15:51:07 +0200
Message-ID: <vpqpragt5bo.fsf@bauges.imag.fr>
References: <4A979690.1050601@gnu.org> <20090827203402.GC7168@kisimul>
	<vpqk50pasek.fsf@bauges.imag.fr> <20090827203402.GC7168@kisimul>
	<9b18b3110908271521w764684cfg3b009f6960ee5dc4@mail.gmail.com>
	<20090827203402.GC7168@kisimul>
	<7v1vmxq6nw.fsf@alter.siamese.dyndns.org>
	<20090827203402.GC7168@kisimul>
	<fabb9a1e0908271341o3a558eedq85541e68875ab77f@mail.gmail.com>
	<20090827203402.GC7168@kisimul> <20090828133708.GA11146@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: seanh <seanh.nospam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 15:51:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh1rj-0004NC-Rx
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 15:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbZH1NvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 09:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZH1NvM
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 09:51:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39688 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbZH1NvL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 09:51:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7SDltPu014211
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 Aug 2009 15:47:55 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mh1r9-0001K2-8o; Fri, 28 Aug 2009 15:51:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mh1r9-0000Qj-7U; Fri, 28 Aug 2009 15:51:07 +0200
In-Reply-To: <20090828133708.GA11146@kisimul> (seanh's message of "Fri\, 28 Aug 2009 14\:37\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 28 Aug 2009 15:47:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7SDltPu014211
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252072075.94672@Sq6AaxM5BinvYWngc0RUmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127297>

seanh <seanh.nospam@gmail.com> writes:

> In response to Matthieu and Paolo, I'm not sure I understand the git 
> internals involved in the discussion around merge --squash, I had a 
> feeling this would produce a 'merge' that git in some sense would 'not 
> know about',

Yes, that's it. Git does a merge, and immediately forgets it was a
merge. The consequence is when you merge again later, Git will not be
able to use the merge information to be clever about merging. Somehow,
Git will be as bad as SVN for merging if you don't know what you're
doing ;-).

> since it sounds complex and I don't understand it I don't think I
> want to go there.

Well, it's fun also to learn Git notions in more details ;-).

-- 
Matthieu
