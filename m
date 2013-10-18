From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 00/14] Officially start moving to the term 'staging area'
Date: Fri, 18 Oct 2013 11:46:12 +0200
Message-ID: <vpqbo2m7vyz.fsf@anie.imag.fr>
References: <1381789769-9893-1-git-send-email-felipe.contreras@gmail.com>
	<1381789769-9893-4-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s3u_SMyZOe5jxkvoGn5MBJ_g70iHRT5v_3u1rZwFoqiVA@mail.gmail.com>
	<xmqqwqlbznfp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 11:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VX6dU-00035s-OX
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 11:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab3JRJqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 05:46:21 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60791 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab3JRJqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 05:46:19 -0400
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r9I9kCqq030182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Oct 2013 11:46:12 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id r9I9kDVE012612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Oct 2013 11:46:13 +0200
In-Reply-To: <xmqqwqlbznfp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 17 Oct 2013 12:50:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 18 Oct 2013 11:46:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r9I9kCqq030182
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1382694373.22138@+znwlzR8/UHWKnmjLlgpqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236341>

I'm lacking time to read and answer in detail, sorry.

Junio C Hamano <gitster@pobox.com> writes:

> "It must be done" is different from "any change is good, as long as
> it introduces more instances of word 'stage'".

I agree. Something must be done, at least to remove the cache Vs index
confusion. I'm not sure exactly what's best, and we should agree where
to go before going there. The previous attempts to introduce more
"stage" in Git's command-line (e.g. the "git stage" alias) introduced
more confusion than anything else.

> The phrase "staging area" is not an everyday phrase or common CS
> lingo, and that unfortunately makes it a suboptimal choice of words
> especially to those of us, to whom a large portion of their exposure
> to the English language is through the command words we use when we
> talk to our computers.

I do not think being understandable immediately by non-native is so
important actually. To me as a french, "commit" makes no sense as an
english word to describe what "git commit" does, but it's OK as I never
really translate it. Even fr.po translates "a commit" by "un commit".

That said, having something that immediately makes sense to a non-native
is obviously a good point.

Another proposal which I liked BTW was to use the word "precommit".
Short, and easily understood as the place where the next commit is
prepared.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
