From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Mention that 'push .. master' is in explicit form master:refs/heads/master
Date: Wed, 19 Sep 2007 13:37:41 +0300
Organization: Private
Message-ID: <bqbzj5ze.fsf@blue.sea.net>
References: <wsuomgyu.fsf@blue.sea.net>
	<7vfy1bvgn1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 19 12:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXwwo-0003rf-06
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 12:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbXISKiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 06:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756466AbXISKiS
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 06:38:18 -0400
Received: from main.gmane.org ([80.91.229.2]:57744 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756431AbXISKiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 06:38:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IXwv2-0002Cf-HP
	for git@vger.kernel.org; Wed, 19 Sep 2007 12:36:33 +0200
Received: from a81-197-175-198.elisa-laajakaista.fi ([81.197.175.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 12:36:32 +0200
Received: from jari.aalto by a81-197-175-198.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 12:36:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a81-197-175-198.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:VFuL3EK3BBt09usES3pacWBq+4E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58701>

* Tue 2007-09-18 Junio C Hamano <gitster AT pobox.com>
* Message-Id: 7vfy1bvgn1.fsf AT gitster.siamese.dyndns.org
>>  	Find a ref that matches `master` in the source repository
>>  	(most likely, it would find `refs/heads/master`), and update
>>  	the same ref (e.g. `refs/heads/master`) in `origin` repository
>> -	with it.
>> +	with it. The following would be exactly same command:
>> +
>> +	git push origin master:refs/heads/master
>
> They _might_ be exactly the same.
>
> The reason people often explicitly write
>
> 	$ git push $URL refs/heads/master:refs/heads/master
>
> in their insns for newbies is because this form would not be
> affected by the random factors at $URL repository (or your
> repository) and will consistently get the same result.
>
> 	$ git push $URL foo
>
> may push branch head 'foo' or tag 'foo' depending on which one
> you have locally.  Having both is not encouraged, but spelling
> the insn out explicitly as refs/heads/foo makes it clear the
> command is talking about the branch even when there is a tag
> with the same name.

Thank you, kindly broaden the current documentation to include this
explanation.

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
