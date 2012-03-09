From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 06:56:34 -0800 (PST)
Message-ID: <m3ipidzuxp.fsf@localhost.localdomain>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<4F58C977.8000400@xiplink.com> <vpq62efjeqd.fsf@bauges.imag.fr>
	<CAHkcotiOGaOdDvibpoiEgys3PnSPfSw0mT3DeEOix+FuboULiA@mail.gmail.com>
	<vpqfwdjas0m.fsf@bauges.imag.fr>
	<20120309033826.GA6164@sigill.intra.peff.net>
	<7vsjhi9wku.fsf@alter.siamese.dyndns.org>
	<vpqobs65gfc.fsf@bauges.imag.fr>
	<7vwr6u6qrn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Carlos Martin Nieto <cmn@elego.de>,
	Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 15:56:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S61FJ-00079y-3O
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 15:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754464Ab2CIO4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 09:56:36 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:40069 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab2CIO4g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 09:56:36 -0500
Received: by wejx9 with SMTP id x9so1145590wej.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 06:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NmKYZngEq+BfgSXG8602/zmrLX/dbDzZsThKJ/ZlqPg=;
        b=RzNbNvyEWwOsaL6NeDy65Ils4Cg+DspqAeCxupicSy8QZMvn64MuAY9sLStED7rmtN
         WAZbUwkakYeX1sqjn9VZDDRkLOvkM5Q/PuHs9d9IseJdCuuLe8D5av0VxLp+G5QM/hGf
         Ek6eItSrqL2TBupzLdNA11VOJD2cNNq2jDi8yqevDbXpFxolqzv9dlE+XKe2Xbn00DP0
         hXU0ZSCX4wzbTeiqRBVbiJoADi9ljuA2NzJhPSPJTrXg4dpGBJucwvjooLsExZYEPd6Y
         UTXj3DwncAUq0ZxxBTO/FACucw9zMloCeFXeV+shPVC3kQAx8lw3k7hzArG/6Hidgl6v
         03xQ==
Received: by 10.180.91.10 with SMTP id ca10mr5479545wib.17.1331304994937;
        Fri, 09 Mar 2012 06:56:34 -0800 (PST)
Received: from localhost.localdomain (abwp68.neoplus.adsl.tpnet.pl. [83.8.239.68])
        by mx.google.com with ESMTPS id t20sm10993226wiv.0.2012.03.09.06.56.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 06:56:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q29EtJa1006053;
	Fri, 9 Mar 2012 15:55:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q29EsQgv006034;
	Fri, 9 Mar 2012 15:54:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vwr6u6qrn.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192722>

[I am sorry if you have received duplicates]

Junio C Hamano <gitster@pobox.com> writes:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I just dug it up; start from here:
>>>
>>>     http://thread.gmane.org/gmane.comp.version-control.git/123350/focus=123541
>>
>> That's an old discussion. A more recent one is here:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/166743
>>
>> (interleaved with a discussion about tag namespace, but the end of the
>> message is about push.default)
> 
> I'd say that it only shows that everybody for some strange reason
> forgot to learn from history, including me, in that more recent
> thread. Luckily, Jeff noticed eerily familiarity this time around.

Nb. if I remember it correctly one of problems seen with transition to
new default was that there were no command-line equivalent to
'push.default = matching'... but now we have ":" and "+:" magic
refspec.

>> (i.e. "Care to roll an appliable patch?", which I guess everyone has
>> been too lazy to do)
[...]

> Resurrecting the old patch that was reverted is the easiest part.
> 
> It is much more important to spread the word to the people who will
> be hurt by the default change well before it actually happens, and
> to get them engaged in the discussion, along with those who would
> benefit from such a change. That needs to happen before any patch
> that reverts a revert.
> 
> Even in the kernel community, I suspect that most people do not
> follow this mailing list anymore and simply trust that we won't make
> changes that affect them negatively. People will complain only after
> a change hits them, and tell us "We didn't know that you will be
> making this stupid change." And having this thread here does not
> count as "spreading the word".
> 
> I can send a message saying "There is a proposal to change the
> default behaviour of 'git push' on the Git mailing list, and you may
> be negatively affected if you do not see anything in the output from
> 'git config push.default' when such a change happens. On the other
> hand, you may want to see the default behaviour to change. In either
> case, please join the discussion to give us more data point and help
> us decide the future of Git." to the kernel list. Anybody could, for
> that matter.

There are other places where we can send such message beside git
mailing list and LKML: There is Junio's "Git Blame" blog, there is Git
page on Google+; we can ask for such annoncement to be posted also
on GitHub Blog...

Spread the word...
-- 
Jakub Narebski
