From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git rev-list --pretty=format:"" issue
Date: Thu, 18 Apr 2013 09:30:36 +0200
Message-ID: <87bo9cxplv.fsf@linux-k42r.v.cablecom.net>
References: <CAH2yXXYggB=Wv-w4B9qU=ZxAuqjPVa5WRNZRnMRrWShkTp0UFg@mail.gmail.com>
	<7vk3o0erjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Forrest Galloway <f.galloway@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 09:30:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USjIo-00079B-Nq
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 09:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966020Ab3DRHai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 03:30:38 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:13447 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965799Ab3DRHai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 03:30:38 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 18 Apr
 2013 09:30:28 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 18 Apr 2013 09:30:36 +0200
In-Reply-To: <7vk3o0erjq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 17 Apr 2013 15:11:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221617>

Junio C Hamano <gitster@pobox.com> writes:

> Forrest Galloway <f.galloway@gmail.com> writes:
>
>> git 1.8.2.1 on OSX(Mountain Lion) installed with Homebrew
>>
>> I am seeing an issue when trying to format the output from rev-list command.
>> git log --pretty=format:"%H - %an, %ar : %s" When I attempt the above
>> string, instead of printing to the shell, LESS is opened and the
>> output is displayed there.
[...]
>
> Actually, less is running in both cases.
[...]
> If you do not want pager, run it with no-pager, like this:
>
> 	git --no-pager log ...your other parameters...

Also note that the pager is automatically disabled if you redirect
stdout, so --no-pager is only required in some fringe cases, notably
when attempting to run git under GDB.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
