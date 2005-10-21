From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: rsync update appears broken now
Date: 21 Oct 2005 06:49:48 -0700
Message-ID: <861x2fdloj.fsf@blue.stonehenge.com>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
	<81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
	<Pine.LNX.4.64.0510201038320.3369@g5.osdl.org>
	<loom.20051020T220751-355@post.gmane.org>
	<Pine.LNX.4.64.0510201432260.10477@g5.osdl.org>
	<7vek6f220h.fsf@arte.twinsun.com>
	<Pine.LNX.4.64.0510201645450.10477@g5.osdl.org>
	<loom.20051021T022509-63@post.gmane.org>
	<Pine.LNX.4.64.0510201752050.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@twinsun.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 15:51:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESxH1-0002RI-Hz
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 15:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVJUNt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 09:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbVJUNt3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 09:49:29 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:19858 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964951AbVJUNt2
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 09:49:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 352978F5E3;
	Fri, 21 Oct 2005 06:49:49 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 12414-02-9; Fri, 21 Oct 2005 06:49:48 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id C6B628FAD8; Fri, 21 Oct 2005 06:49:48 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
x-mayan-date: Long count = 12.19.12.13.2; tzolkin = 12 Ik; haab = 0 Zac
In-Reply-To: <Pine.LNX.4.64.0510201752050.10477@g5.osdl.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10433>

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> On Fri, 21 Oct 2005, Junio C Hamano wrote:
>> 
>> I am reasonably sure that the screw-up was only rewinding one commit too much.
>> I've done the merge so things should look better once mirrors catch up.

Linus> Yup, works at least for me. Thx,

Doesn't yet work for me.  What do I need to do now?

    * committish: 4ae22d96fe9248dac4f26b1fc91154ba5e879799
      branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
    * refs/heads/origin: same as branch 'master' of rsync://rsync.kernel.org/pub/scm/git/git
    Updating from ea5a65a59916503d2a14369c46b1023384d51645 to 4ae22d96fe9248dac4f26b1fc91154ba5e879799.
    fetch-pack.c: needs update
    fatal: Entry 'daemon.c' would be overwritten by merge. Cannot merge.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
