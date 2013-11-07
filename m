From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Thu, 07 Nov 2013 11:52:43 +0100
Message-ID: <vpqtxfo8ow4.fsf@anie.imag.fr>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
	<CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
	<xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
	<1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
	<xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
	<vpq1u2tb3px.fsf@anie.imag.fr> <20131106234544.GF10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 11:52:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeNCr-0007vn-C3
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 11:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab3KGKwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 05:52:54 -0500
Received: from mx2.imag.fr ([129.88.30.17]:49588 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab3KGKwv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 05:52:51 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id rA7AqhHq017694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 Nov 2013 11:52:43 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rA7AqiFQ005138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 7 Nov 2013 11:52:44 +0100
In-Reply-To: <20131106234544.GF10302@google.com> (Jonathan Nieder's message of
	"Wed, 6 Nov 2013 15:45:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 07 Nov 2013 11:52:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rA7AqhHq017694
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1384426365.51243@H99fbhK8/GmIa4KkuBbQbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237393>

Jonathan Nieder <jrnieder@gmail.com> writes:

> 	When push.default is set to 'matching', git will push local branches
> 	to remote branches that already exist with the same (matching) name.

Yes, that's better than the original patch (and remains two lines).

>>>>> +   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
>>>>> +   "branch to the same remote branch used by git pull.   A push will\n"
>>>>> +   "only succeed if the remote and local branches have the same name.\n"
>>>
>>> while you can see that it is not telling a lie if you read it twice,
>>> "will only succeed if" feels somewhat roundabout.
>>>
>>> 	... push only the current branch back to the branch of the
>>> 	same name, but only if 'git pull' is set to pull from that
>>> 	branch. Otherwise the push will fail.
>>>
>>> might be an improvement, but I dunno.
>>
>> I do not see much difference actually. I tend to prefer the original
>> version: to me the expected behavior is to make push and pull
>> essentially symetrical, and the fact that it fails if the branch is
>> named differently is a safety feature comming on top of that.
>
> Perhaps:
>
> 	In Git 2.0 (or now, if push.default is set to 'simple'), git will behave
> 	more conservatively by pushing only the current branch to the corresponding
> 	remote branch used by "git pull", and only if the remote and local branches
> 	have the same name.

I prefered the original, as it had two sentences. Reading only the first
one gave the important information.

> 	In Git 2.0, git will default to a more conservative 'simple' behavior
> 	that only pushes the current branch.

That's an option too, but I think mentionning "git pull" was a good
idea.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
